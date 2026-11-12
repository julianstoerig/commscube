#import "@preview/polylux:0.4.0": *

// 4:3 slide format.
#set page(
  width: 10in,
  height: 7.5in,
  margin: 0.6in,
  // No page number on the title slide.
  footer: context {
    let n = counter(page).get().first()
    if n > 1 { align(right, text(size: 14pt)[#n]) }
  },
)
#set text(size: 17pt, fill: rgb("#243247"))
#set par(leading: 0.7em)
#set heading(numbering: none)

// Slide titles are level-1 headings; they feed the table of contents.
#show heading.where(level: 1): set text(size: 32pt, weight: "bold")
#show heading.where(level: 1): set block(below: 1.2em)
#show figure.caption: set text(size: 10pt)

// Table of contents: entry, dotted leader, page number.
#set outline(depth: 1, indent: 0pt)
#set outline.entry(fill: repeat(gap: 0.3em)[.])
#show outline: set text(size: 22pt)
#show outline.entry: set block(above: 0.9em)

// Title slide.
#slide[
  #align(center + horizon)[
    #text(size: 42pt, weight: "bold")[commscube · bananacube  · tessa]

    #image("logo.svg", width: 30%)
    #v(0.5em)
    #text(size: 26pt)[meilenstein uno]

    #v(1.5em)
    #text(size: 18pt)[Fabian Fahmüller · Dominik Dethleffsen · Julian Störig · Florian Rößler]
  ]
]




#slide[
  #heading(outlined: false)[Inhaltsverzeichnis]
  #pad(x: 3cm, outline(title: none))
  #place(bottom + left)[
    #text(size: 10pt)[now, the coconut nut is a big, big nut But this delicious nut is not a nut]
  ]
]




#slide[
  = Problemstellung - Übersicht

  #grid(
    columns: (1fr, 1fr),
    gutter: 0.5in,
    [
      #v(2cm)
      == Apokalypsen Szenario
      - Dezentral
      - Minimale Kommunikation gewährleisten 
      - Unabhänging von jeglicher Infrastruktur
      - Einfache Bedienung
      - Robust/stoßfest
      
      == POC - Proof of Concept
      - Kommunikation @lora-board
      - Demo Board @lora-board
    ],
    [
      // Source of a picture: figure without number, caption cites the source.
      #figure(
        image("concept_art.webp", width: 78%),
        caption: [Konzept: @concept-art],
        numbering: none,
      )

      #figure(
        image("My-Eyes-the-goggles.jpg", width: 78%),
        caption: [KI Haftungsausschluss: @goggles],
        numbering: none,
      )
    ],
  )
]


#slide[
  = Hardware - POC

  #grid(
    columns: (1fr, 1.4fr),
    gutter: 0.5in,
    [
        #v(2cm)
        == LILYGO LoR32 @lora-board
      - ESP32s3
      - LoRa Modul SX1276 (868/915MHz)
      - 0.96" Oled Display
      - SMA Female Antenna Connector
      //#image("liygo_lora_board.webp", width: 70%)
    ],
    [
      #figure(
        image("liygo_lora_board_front_back.webp", width: 90%),
        caption: [LILYGO LoRa32: @lora-board],
        numbering: none,
      )
    ],
  )
]


#slide[
  = Funk - LoRa

  #grid(
    columns: (1.5fr, 1fr),
    gutter: 0.4in,
    [
      == Modulation
      - Chirp Spread Spectrum, Sub-GHz @lora-wiki
      - SF7--SF12 beim SX1276 @meshtastic-radio wir nutzen SF7
      - SF +1: 2x Airtime, +2,5 dB @meshtastic-radio
      == Eigenschaften
      - Praxis 10 km, Rekord 331 km @lora-wiki @meshtastic-range
      - Bandbreite 62,5 kHz: im 868-MHz-Band erlaubt, unkritischer Oszillator @meshtastic-radio
      - Coding Rate 4/5: Coderate 0,8, reduziert Kanalüberlastung 
      == Regulierung
      - Region `EU_868`: 868-MHz-ISM-Band 10 % Duty Cycle, +27 dBm ERP @meshtastic-radio
      - 868 MHz: beliebtestes Band in EU @meshtastic-radio
    ],
    [
      #figure(
        image("lora_mod.png", width: 87%),
        caption: [LoRa Modulation: @lora-mod],
        numbering: none,
      )
    ],
  )
]


#slide[
  = Protokoll - Meshtastic

  #grid(
    columns: (1fr, 1fr),
    gutter: 0.5in,
    [
      == Allgemeines
      - Open Source, 100 % Community~@meshtastic-intro
      - Managed Flooding (SNR-basiert) @meshtastic-algo
      - Hop Limit 3 (max. 7): Kapazität vor Reichweite~@meshtastic-lora
      - DMs: Next-Hop-Routing~@meshtastic-algo
      - Roles: `ROUTER`, `CLIENT`... ~@meshtastic-algo
      - Verschlüsselt: AES, Channel-Key~@meshtastic-enc
      == Commscube Einstellungen
      - Preset „Long Fast“ (auch Muc): ca. 156 dB Linkbudget, 1,07 kbit/s @meshtastic-radio
      - Sendeleistung `0` (Auto): Rundstrahlantenne < 3 dBi@meshtastic-lora

      == Custom Features
      - vordefinierte Nachrichten
      - Knopf interface Pin14 Select, Pin4 Send
    ],
    [
      #figure(
        image("map_meshtastic_logo.svg", width: 80%),
        caption: [Meshtastic Logo],
        numbering: none,
      )
    ],
  )
  
]


#slide[
  = Demo Setup

  #grid(
    columns: (1fr, 1fr),
    gutter: 0.5in,
    [
      #image("demso_setup.svg", width: 82%)
    ],
    [
      == Lokale Node
      - Verbunden mit Meshtastic
      - Custom Firmware
      
      == Remote Node
      - Verbunden mit Meshtastic
      - Custom Firmware
      - Im Roterwürfel

      == Standard Node
      - Verbunden mit Meshtastic
      - Standard Firmware
      - Per Serial von Laptop gesteuert

      == Offline Laptop
      - locale Website
      - Steuert Standard Client per Serial
    ],
  )
]


// Example slide: header followed by two equally sized columns.
#slide[
  = Geführte Demo

  #grid(
    columns: (1fr, 2.5fr),
    gutter: 0.5in,
    [
      #v(4em)
      == Local Demo
      - Laptop zu Doku-Cam
      - Doku-Cam zu Laptop

      == Long-range Demo
      - Laptop zu "weg"
      - "weg" zu Laptop
    ],
    [
      #v(0.5cm)
      #figure(
        image("pinout_edit.webp", width: 110%),
        caption: [Pinout Diagram @lora-board],
        numbering: none,
      )
    ],
  )
]


// Example slide: header followed by two equally sized columns.
#slide[
  = Interaktive Demo

  #align(center)[
      #v(5em)
      == Toben Sie sich aus Herr Gerstner
    ]
]


#slide[
  = Literatur
  #set text(size: 12pt)
  #bibliography("refs.bib", title: none, style: "ieee")
]


