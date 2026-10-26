#pragma once

#include <stdint.h>

namespace BananaButtonService {

    // Einmal beim Booten aufrufen
    void begin();

    // Regelmaessig aus der Hauptschleife aufrufen
    void poll();

    uint8_t selectedMessageNumber();

}
