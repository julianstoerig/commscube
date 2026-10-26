
#include "BananaButtonService.h"

#include <Arduino.h>
#include <cstring>

#include "Channels.h"
#include "MeshService.h"
#include "Router.h"
#include "configuration.h"

#if HAS_SCREEN
#include "graphics/Screen.h"
#endif

namespace {

// =====================================
// Hardware
// =====================================

constexpr uint8_t SEND_PIN   = 4;
constexpr uint8_t SELECT_PIN = 14;

// =====================================
// Timing
// =====================================

constexpr uint32_t DEBOUNCE_MS = 60;
constexpr uint32_t COOLDOWN_MS = 2000;

// =====================================
// Unsere 5 Standardnachrichten
// =====================================

constexpr const char *PRESETS[] = {
    "Banane 1: Alles OK!",
    "Banane 2: Bin unterwegs.",
    "Banane 3: Bitte antworten.",
    "Banane 4: Funkcheck?",
    "Banane 5: Feierabend! :D"
};

constexpr uint8_t PRESET_COUNT =
    sizeof(PRESETS) / sizeof(PRESETS[0]);

uint8_t selectedIndex = 0; // 0 = Nachricht 1

// =====================================
// Allgemeine Tasterentprellung
// =====================================

class DebouncedButton {
public:
    explicit DebouncedButton(uint8_t gpio)
        : pin(gpio) {}

    void begin() {
        pinMode(pin, INPUT_PULLUP);

        stablePressed = digitalRead(pin) == LOW;
        lastRawPressed = stablePressed;
        lastChangeMs = millis();
    }

    // true genau einmal bei stabilem Tastendruck
    bool pressedEdge(uint32_t now) {
        bool rawPressed = digitalRead(pin) == LOW;

        if (rawPressed != lastRawPressed) {
            lastRawPressed = rawPressed;
            lastChangeMs = now;
        }

        if (now - lastChangeMs < DEBOUNCE_MS) {
            return false;
        }

        if (rawPressed == stablePressed) {
            return false;
        }

        stablePressed = rawPressed;
        return stablePressed;
    }

private:
    uint8_t pin;
    bool lastRawPressed = false;
    bool stablePressed = false;
    uint32_t lastChangeMs = 0;
};

DebouncedButton sendButton(SEND_PIN);
DebouncedButton selectButton(SELECT_PIN);

uint32_t lastSendMs = 0;
bool hasSent = false;

// =====================================
// Nachricht senden
// =====================================

void sendSelectedMessage() {
    if (!router || !service) {
        LOG_WARN("BANANA: Mesh not ready");
        return;
    }

    const char *message = PRESETS[selectedIndex];
    const size_t length = strlen(message);

    meshtastic_MeshPacket *packet =
        router->allocForSending();

    if (!packet) {
        LOG_ERROR("BANANA: Allocation failed");
        return;
    }

    if (length > sizeof(packet->decoded.payload.bytes)) {
        LOG_ERROR("BANANA: Message too long");
        packetPool.release(packet);
        return;
    }

    packet->decoded.portnum =
        meshtastic_PortNum_TEXT_MESSAGE_APP;

    packet->channel = channels.getPrimaryIndex();
    packet->to = NODENUM_BROADCAST;
    packet->want_ack = false;

    memcpy(
        packet->decoded.payload.bytes,
        message,
        length
    );

    packet->decoded.payload.size = length;

    service->sendToMesh(packet, RX_SRC_LOCAL, true);

    LOG_INFO(
        "BANANA: Sent preset %u",
        (unsigned)(selectedIndex + 1)
    );
}

// =====================================
// Naechste Nachricht auswaehlen
// =====================================

void selectNextMessage() {
    selectedIndex = (selectedIndex + 1) % PRESET_COUNT;

    LOG_INFO(
        "BANANA: Selected preset %u",
        (unsigned)(selectedIndex + 1)
    );

    // Die OLED-Oberflaeche aktualisieren
#if HAS_SCREEN
    if (screen) {
        screen->forceDisplay(true);
    }
#endif
}

} // anonymous namespace

// =====================================
// Oeffentliche Schnittstelle
// =====================================

namespace BananaButtonService {

void begin() {
    sendButton.begin();
    selectButton.begin();

    LOG_INFO("BANANA: Two buttons initialized");
}

void poll() {
    const uint32_t now = millis();

    // Nachrichtenauswahl
    if (selectButton.pressedEdge(now)) {
        selectNextMessage();
    }

    // Nachricht senden
    if (sendButton.pressedEdge(now)) {

        if (hasSent && now - lastSendMs < COOLDOWN_MS) {
            LOG_INFO("BANANA: Cooldown active");
            return;
        }

        lastSendMs = now;
        hasSent = true;

        sendSelectedMessage();
    }
}

uint8_t selectedMessageNumber() {
    return selectedIndex + 1;
}

} // namespace BananaButtonService
