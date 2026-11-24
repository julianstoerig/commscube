// Poster A0 hochkant, Variante 3: wissenschaftlicher Aufbau
#let dunkel = rgb("#243247")
// Rot aus dem Logo der Hochschule München
#let akzent = rgb("#FC5555")
#let grau = rgb("#5b6675")
#let linie = luma(215)

#let hm-logo = image("bilder/hm_logo.svg", height: 9cm)

#set page(paper: "a0", margin: (x: 3.5cm, top: 3cm, bottom: 3.5cm), fill: white)

#set text(lang: "de", size: 38pt, font: "Libertinus Serif", fill: dunkel)
#set par(justify: true, leading: 0.55em, spacing: 0.9em)

// Überschriften: Nummer in Akzentfarbe, feine Linie darunter
#set heading(numbering: "1")
#show heading.where(level: 1): set text(size: 60pt, hyphenate: false)
#show heading.where(level: 1): it => block(
  above: 2cm,
  below: 1cm,
  width: 100%,
  stroke: (bottom: 0.06cm + dunkel),
  inset: (bottom: 0.4cm),
  [#text(fill: akzent, counter(heading).display(it.numbering)) #h(0.4em) #it.body],
)

#show title: set text(size: 120pt, weight: "bold")

#set list(marker: [–], body-indent: 0.6em, spacing: 0.7em)
#show list: set par(justify: false)

// Bildunterschrift mit fetter Kennung, z. B. „Abbildung 1:“
#set figure(gap: 0.8cm)
#show figure.caption: it => {
  set text(size: 32pt)
  set par(justify: false)
  [#strong[#it.supplement #context it.counter.display(it.numbering):] #it.body]
}
// Begriffe fett mit Doppelpunkt, jeder Eintrag als eigener Absatz
#show terms.item: it => block(above: 0.7em, below: 0.7em)[#strong[#it.term:] #it.description]
#show terms: set par(justify: false)

// Hervorgehobener Kernsatz mit Akzentlinie links
#let kern(inhalt) = block(
  width: 100%,
  stroke: (left: 0.35cm + akzent),
  inset: (left: 1.2cm, y: 0.4cm),
  text(style: "italic", inhalt),
)

// Kopf
#let kopf = stack(
  spacing: 1.5cm,
  grid(
    columns: (1fr, auto, auto),
    column-gutter: 3cm,
    align: horizon,
    {
      set text(hyphenate: false)
      set par(justify: false)
      stack(
        spacing: 1.2cm,
        title[CommsCube],
        text(size: 58pt, style: "italic")[Infrastruktur-unabhängiger Textfunk als Ersatzsystem für den Ernstfall],
        text(size: 36pt, fill: grau)[Fabian~Fahmüller · Dominik~Dethleffsen · Julian~Störig · Florian~Rößler \ Hochschule München],
      )
    },
    image("bilder/logo.svg", width: 14cm),
    hm-logo,
  ),
  line(length: 100%, stroke: 0.25cm + dunkel),
)

// Mesh-Skizze
#let mesh = {
  let knoten = (
    (2, 14), (8, 4), (10, 17), (16, 9), (21, 19), (24, 3), (28, 12), (34, 6), (33, 18),
  )
  let kanten = ((0, 1), (0, 2), (1, 3), (2, 3), (2, 4), (3, 5), (3, 6), (4, 6), (5, 7), (6, 7), (6, 8), (4, 8))
  let weg = ((0, 2), (2, 3), (3, 6), (6, 8))
  let e = 0.62cm
  box(width: 36 * e, height: 20 * e, {
    for (a, b) in kanten {
      let aktiv = weg.contains((a, b))
      place(line(
        start: (knoten.at(a).at(0) * e, knoten.at(a).at(1) * e),
        end: (knoten.at(b).at(0) * e, knoten.at(b).at(1) * e),
        stroke: if aktiv { 0.45cm + akzent } else { 0.12cm + luma(190) },
      ))
    }
    for (i, (x, y)) in knoten.enumerate() {
      let rand = if i == 0 or i == 8 { dunkel } else { akzent }
      place(dx: x * e - 0.7cm, dy: y * e - 0.7cm, circle(radius: 0.7cm, fill: white, stroke: 0.28cm + rand))
    }
    let (ax, ay) = knoten.first()
    let (bx, by) = knoten.last()
    place(dx: ax * e - 2cm, dy: ay * e + 0.3cm, text(size: 26pt, weight: "bold")[A])
    place(dx: bx * e + 1.1cm, dy: by * e - 0.2cm, text(size: 26pt, weight: "bold")[B])
  })
}

// Literatur, Einträge auf drei Spalten verteilt (dafür feste Höhe)
#let literatur = block(width: 100%, stroke: (top: 0.08cm + linie), inset: (top: 1cm))[
  #set text(size: 26pt, fill: grau)
  #block(height: 8cm, columns(3, gutter: 2.5cm, bibliography("refs.bib", title: none, style: "ieee")))
]

// Drei Spalten, der Inhalt fließt automatisch von einer Spalte in die nächste
#let spalten = columns(3, gutter: 2.5cm)[
  = Motivation
  Im Ernstfall fallen gewohnte Kommunikationswege aus:
  - BOS-Digitalfunk (TETRA) ausgefallen oder überlastet, z. B. bei Großschadenslagen
  - Mobilfunk und Internet hängen am Stromnetz

  Einsatz- und Hilfskräften fehlt dann ein einfacher und schneller Weg, wichtige Nachrichten auszutauschen.

  #kern[Ziel: ein robustes Gerät für Textnachrichten, das ohne externe Infrastruktur funktioniert. Es ersetzt keinen TETRA-Funk im Regelbetrieb, sondern springt ein, wenn gewohnte Wege ausfallen.]

  = Anforderungen
  - Unabhängig von Mobilfunk, Internet und Stromnetz
  - Dezentral/dynamisch und möglichst automatisch
  - Reichweite von mehreren Kilometern
  - Lizenzfrei nutzbar, ohne Anmeldung
  - Freitext und gespeicherte Nachrichten
  - Notfall-Meldung auf Knopfdruck
  - Verschlüsselte Übertragung
  - Einfache Bedienung ohne Funkausbildung, auch mit Handschuhen
  - Anzeige bei Sonne und Dunkelheit lesbar
  - Akkulaufzeit von mehreren Tagen
  - Robust, handlich und mobil

  = Lösungsansatz
  Akkubetriebene Handfunkgeräte bilden untereinander ein Netz. Dieses sogenannte "Mesh" wächst mit jedem weiteren Gerät.

  / Vernetzung: Im Mesh gibt es keine Zentrale. Jedes Gerät ist ein Knoten und leitet Nachrichten für andere weiter.
  / Funk: Die Geräte übertragen per LoRa im lizenzfreien 868-MHz-Band. Das überbrückt Kilometer bei geringem Stromverbrauch @lora-wiki.
  / Protokoll: Das Weiterleiten übernimmt Meshtastic, ein quelloffenes und verbreitetes Mesh-Protokoll @meshtastic-intro.
  / Anzeige: Ein E-Paper-Display bleibt in der Sonne und im Licht der Stirnlampe lesbar. Es braucht nur beim Umschalten Strom.

  = Systemaufbau
  #figure(
    image("bilder/commscube_mockup.png", width: 100%),
    caption: [Entwurf des CommsCube mit E-Paper-Anzeige und Tastenfeld],
  ) <abb-geraet>

  / Rechner: nRF52840 (RAK4631) @rak4631
  / Funk: LoRa-Chip SX1262, 868 MHz
  / Anzeige: 4,2-Zoll-E-Paper, 400 × 300 px
  / Bedienung: Große Tasten und seitliches Drehrad, auch mit Handschuhen
  / Notfall: Versenkter Taster sendet eine Notfall-Meldung
  / Energie: Li-Ionen-Akku, 10~000~mAh, 3,7~V

  = Mesh-Routing
  #figure(
    block(stroke: 0.05cm + linie, width: 100%, inset: 1cm, align(center, mesh)),
    caption: [Nachricht von A nach B über drei Zwischenstationen],
  ) <abb-mesh>

  / Managed Flooding: Jeder Knoten sendet eine empfangene Nachricht einmal weiter @meshtastic-algo.
  / Vorrang: Knoten mit schwachem Empfang senden zuerst. Sie liegen meist am Rand der Reichweite.
  / Duplikate: Eine schon weitergeleitete Nachricht wird nicht erneut gesendet.
  / Hop-Limit: Eine Nachricht wird bis zu dreimal weitergeleitet, auf Wunsch bis zu siebenmal @meshtastic-lora.
  / Ausfall: Fällt ein Knoten aus, nimmt die Nachricht einen anderen Weg. Eine Zentrale gibt es nicht.
  / Verschlüsselung: AES mit Kanalschlüssel @meshtastic-enc.

  = Energiebedarf
  #figure(
    image("bilder/energie_laufzeit_rot.svg"),
    caption: read("bilder/energie_laufzeit.txt"),
  ) <abb-energie>

  Der interne Akku kann den Energiebedarf des Funkgerätes selbst bei dauerhafter Verwendung für 8 Tage decken.

  = Ergebnisse
  Ein Versuchsaufbau mit zwei eigenen Knoten und einem handelsüblichen Meshtastic-Gerät tauscht Nachrichten über das Mesh aus.

  #figure(
    image("bilder/map_plus_logo.png", width: 70%),
    caption: [Meshtastic-Knoten im Raum München (Platzhalter)],
  )

  = Fazit und Ausblick
  Ein LoRa-Mesh auf Basis von Meshtastic eignet sich als einfaches Ersatzsystem für Textnachrichten.

  Offen:
  - Tests unter Einsatzbedingungen
  - Fest verbauter oder externer Akku
  - Messung des Energiebedarfs
]

// Ganze Seite als Raster mit fester Höhe, damit die Spalten den Rest füllen
#block(height: 100%, grid(
  rows: (auto, 1fr, auto),
  row-gutter: 2cm,
  kopf,
  spalten,
  literatur,
))
