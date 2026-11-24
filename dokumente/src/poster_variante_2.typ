// Poster A0 hochkant, Variante 2: jeder Bereich auf eigener Fläche
#let dunkel = rgb("#243247")
#let akzent = color.hsl(140.69deg, 75.65%, 35.00%)
#let grau = rgb("#5b6675")
#let hintergrund = rgb("#F2F5F3")

// Weiße Fläche für jeden Bereich
#let bereich(hoehe: auto, inhalt) = block(fill: white, width: 100%, height: hoehe, inset: 2cm, radius: 1.5cm, inhalt)

// Nebeneinander, alle so hoch wie das höchste Element
#let gleich-hoch(abstand: 1.5cm, element, ..inhalte) = layout(groesse => {
  let inhalte = inhalte.pos()
  let breite = (groesse.width - abstand * (inhalte.len() - 1)) / inhalte.len()
  let hoehe = calc.max(..inhalte.map(i => measure(element(i), width: breite).height))
  grid(
    columns: (1fr,) * inhalte.len(),
    column-gutter: abstand,
    ..inhalte.map(i => element(i, hoehe: hoehe)),
  )
})

#set page(paper: "a0", margin: 4cm, fill: hintergrund)

// Drittelraster zur Kontrolle: typst compile --input raster=1 poster_variante_2.typ
#set page(foreground: if sys.inputs.at("raster", default: "0") == "1" {
  for f in (1 / 3, 2 / 3) {
    place(line(start: (f * 100%, 0%), end: (f * 100%, 100%), stroke: 0.15cm + red))
    place(line(start: (0%, f * 100%), end: (100%, f * 100%), stroke: 0.15cm + red))
  }
})
#set text(lang: "de", size: 32pt, font: "Inter", fill: dunkel)
#set par(leading: 0.65em)

#show heading.where(level: 2): set text(size: 54pt, hyphenate: false)
#show heading.where(level: 2): set block(below: 1.2cm)

#set list(
  marker: circle(radius: 0.35cm, fill: akzent),
  body-indent: 0.6em,
  spacing: 1.1em,
)

#set figure(numbering: none)
#show figure: set align(left)
#show figure.caption: set text(size: 20pt, fill: grau)

// Kopf
#grid(
  columns: (1fr, auto),
  align: horizon,
  [
    #stack(
      spacing: 1cm,
      text(size: 130pt, weight: "black")[CommsCube],
      text(size: 50pt, fill: grau)[Erreichbar, wenn die Netze schweigen],
      text(size: 30pt, fill: grau)[Fabian Fahmüller · Dominik Dethleffsen · Julian Störig · Florian Rößler],
    )
  ],
  image("bilder/logo.svg", width: 18cm),
)

#v(1.5cm)

// Kernaussage
#block(fill: akzent.lighten(50%), width: 100%, inset: (x: 3cm, y: 2.5cm), radius: 1cm)[
  #align(center, text(size: 72pt, weight: "bold")[
    Kurze Nachrichten von Gerät zu Gerät. \ Ohne Mobilfunk und ohne Internet.
  ])
]

#v(2.2cm)

// Mesh-Skizze
#let mesh = {
  let knoten = (
    (2, 14), (8, 4), (10, 17), (16, 9), (21, 19), (24, 3), (28, 12), (34, 6), (33, 18),
  )
  let kanten = ((0, 1), (0, 2), (1, 3), (2, 3), (2, 4), (3, 5), (3, 6), (4, 6), (5, 7), (6, 7), (6, 8), (4, 8))
  let weg = ((0, 2), (2, 3), (3, 6), (6, 8))
  let e = 0.6cm
  box(width: 36 * e, height: 20 * e, {
    for (a, b) in kanten {
      let aktiv = weg.contains((a, b))
      place(line(
        start: (knoten.at(a).at(0) * e, knoten.at(a).at(1) * e),
        end: (knoten.at(b).at(0) * e, knoten.at(b).at(1) * e),
        stroke: if aktiv { 0.5cm + akzent } else { 0.12cm + luma(200) },
      ))
    }
    for (i, (x, y)) in knoten.enumerate() {
      let rand = if i == 0 or i == 8 { dunkel } else { akzent }
      place(dx: x * e - 0.75cm, dy: y * e - 0.75cm, circle(radius: 0.75cm, fill: white, stroke: 0.3cm + rand))
    }
    let (ax, ay) = knoten.first()
    let (bx, by) = knoten.last()
    place(dx: ax * e - 2.1cm, dy: ay * e + 0.3cm, text(size: 28pt, weight: "bold")[A])
    place(dx: bx * e + 1.2cm, dy: by * e - 0.2cm, text(size: 28pt, weight: "bold")[B])
  })
}

// Gerät, oberer Schnittpunkt rechts
#bereich(grid(
  columns: (1fr, 1fr),
  column-gutter: 3cm,
  align: horizon,
  [
    == Der CommsCube
    - 4,2-Zoll-E-Paper, auch in der Sonne lesbar und sparsam
    - Gespeicherte Nachrichten, wenn es schnell gehen muss
    - Tasten für Freitext
    - Integrierter Akku für den mobilen Einsatz
    - RAK4631 mit nRF52840 und LoRa-Chip SX1262
    - Kompatibel mit dem offenen Meshtastic-Netz
  ],
  figure(image("bilder/commscube_mockup.png", width: 18cm), caption: [Entwurf]),
))

#v(1.5cm)

// Zweck, untere Drittellinie
#let fall((titel, t), hoehe: auto) = block(fill: hintergrund, width: 100%, height: hoehe, inset: (x: 1.5cm, y: 1.3cm), radius: 1cm)[
  #block(below: 0.9em, text(size: 36pt, weight: "bold", titel))
  #t
]
#bereich[
  == Ersatzsystem für den Ernstfall
  Der CommsCube ersetzt keinen Funk im Regelbetrieb. Er springt ein, wenn gewohnte Wege ausfallen.

  #gleich-hoch(
    fall,
    ([Großschadenslage], [Fällt der BOS-Digitalfunk aus, bleiben Einsatzkräfte erreichbar.]),
    ([Blackout], [Hilfsstationen halten Kontakt, auch ohne Stromnetz.]),
    ([Einsatzlogistik], [Material und Verpflegung abstimmen, ohne den Einsatzfunk zu belegen.]),
    ([Helfer vor Ort], [Einfach genug für Freiwillige ohne Funkausbildung.]),
  )
]

#v(1.5cm)

// Technik, unterer Bereich
// Bild jeweils am unteren Rand, damit beide auf gleicher Höhe liegen
#let bildhoehe = 12cm
#let technik((text, bild), hoehe: auto) = bereich(hoehe: hoehe)[
  #text
  #if hoehe != auto { v(1fr) }
  #bild
]
#gleich-hoch(
  abstand: 1.5cm,
  technik,
  (
    [
      == Jedes Gerät ist ein Relais
      - Erreicht eine Nachricht ihr Ziel nicht direkt, reichen andere Würfel sie weiter
      - Fällt ein Knoten aus, nimmt sie einen anderen Weg. Eine Zentrale, die ausfallen könnte, gibt es nicht
      - Bis zu drei Weiterleitungen, maximal sieben
      - Verschlüsselt mit AES
    ],
    figure(
      block(fill: hintergrund, radius: 1cm, width: 100%, height: bildhoehe, align(center + horizon, mesh)),
      caption: [Nachricht von A nach B über drei Zwischenstationen],
    ),
  ),
  (
    [
      == Funktioniert auch im Nirgendwo
      - Jeder Punkt ist ein Meshtastic-Knoten
      - Die Geräte funken per LoRa im lizenzfreien 868-MHz-Band
      - Funkmasten, Internet oder Stromnetz braucht es dafür nicht
      - Eine einzelne Verbindung reicht in der Praxis rund 10 km weit
    ],
    figure(
      box(clip: true, radius: 1cm, width: 100%, height: bildhoehe,
        image("bilder/map_plus_logo.png", width: 100%, height: 100%, fit: "cover")),
      caption: [Platzhalter: Meshtastic-Knoten im Raum München],
    ),
  ),
)
