
#include "BananaUI.h"

#include "graphics/ScreenFonts.h"
#include <OLEDDisplay.h>
#include <stdio.h>

namespace BananaUI {

void draw(
    OLEDDisplay *display,
    int16_t x,
    int16_t y,
    uint16_t nodesOnline,
    uint16_t nodesTotal,
    const char *senderName,
    const char *messageText,
    uint8_t selectedMessage  // <-- NEU!
) {
    if (!display) {
        return;
    }

    display->setColor(WHITE);
    display->setTextAlignment(TEXT_ALIGN_LEFT);
    display->setFont(FONT_SMALL);

    // Header
    char title[24];

    snprintf(
        title,
        sizeof(title),
        "FixMessage: %u",
        (unsigned)selectedMessage
    );

    display->drawString(x + 2, y, title);


    // Mesh-Status
    char buffer[40];

    snprintf(
        buffer, sizeof(buffer),
        "NODES: %u/%u",
        (unsigned)nodesOnline,
        (unsigned)nodesTotal
    );
    display->drawString(x + 2, y + 12, buffer);

    // Absender
    snprintf(
        buffer, sizeof(buffer),
        "FROM: %.20s",
        senderName ? senderName : "UNKNOWN"
    );

    display->drawStringMaxWidth(
        x + 2, y + 24,
        display->getWidth() - 4,
        buffer
    );

    // Letzte empfangene Nachricht
    display->drawStringMaxWidth(
        x + 2, y + 38,
        display->getWidth() - 4,
        messageText ? messageText : "NO MESSAGES"
    );
}

}
