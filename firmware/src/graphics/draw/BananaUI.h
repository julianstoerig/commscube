
#pragma once

#include <stdint.h>

class OLEDDisplay;

namespace BananaUI {

    void draw(
        OLEDDisplay *display,
        int16_t x,
        int16_t y,
        uint16_t nodesOnline,
        uint16_t nodesTotal,
        const char *senderName,
        const char *messageText,
        uint8_t selectedMessage
    );

}
