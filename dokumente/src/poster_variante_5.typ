// Poster A0 quer, Variante 5: wie Variante 3, im Querformat
#let dunkel = black
// Rot aus dem Logo der Hochschule München
#let akzent = rgb("#FC5555")
#let grau = rgb("#5b6675")
#let linie = luma(215)

#let hm-logo = image("bilder/hm_logo.svg", height: 9cm)

#set page(paper: "a0", flipped: true, margin: (x: 3.5cm, top: 3cm, bottom: 3.5cm), fill: white)

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

// Aufzählungszeichen: rotes Dreieck
#let dreieck = box(baseline: -0.12em, polygon(fill: akzent, (0em, 0em), (0.55em, 0.3em), (0em, 0.6em)))
#show title: set text(size: 120pt, weight: "bold")

// Zwischentitel innerhalb eines Teils, ohne Nummer
#show heading.where(level: 2): set text(size: 38pt)
#show heading.where(level: 2): it => block(above: 1.4cm, below: 0.6cm, it.body)

#set list(marker: dreieck, body-indent: 0.6em, spacing: 0.7em)
#show list: set par(justify: false)

// Bildunterschrift mit fetter Kennung, z. B. „Abbildung 1:“
#set figure(gap: 0.8cm)
#show figure.caption: it => {
  set text(size: 32pt)
  set par(justify: false)
  [#strong[#it.supplement #context it.counter.display(it.numbering):] #it.body]
}

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

// Literatur, Einträge auf vier Spalten verteilt (dafür feste Höhe)
#let literatur = block(width: 100%, stroke: (top: 0.08cm + linie), inset: (top: 1cm))[
  #set text(size: 26pt, fill: grau)
  #block(height: 6cm, columns(4, gutter: 2.5cm, bibliography("refs.bib", title: none, style: "ieee")))
]


// Abbildung neben Text, wahlweise rechts vom Text
#let nebeneinander(breite, bild, text, bild-rechts: false) = {
  let text = {
    set par(justify: false)
    text
  }
  grid(
    columns: if bild-rechts { (1fr, breite) } else { (breite, 1fr) },
    column-gutter: 2cm,
    align: top,
    ..if bild-rechts { (text, bild) } else { (bild, text) },
  )
}

// Aufbau jedes Teils: kurze Einleitung als Fließtext, eine Kernaussage,
// danach Einzelheiten unter Zwischentiteln als Aufzählung ganzer Sätze oder Satzteile.

#let teil-1 = [
  = Motivation
  Im Ernstfall fallen gewohnte Kommunikationswege aus. Der BOS-Digitalfunk (TETRA) kann bei Großschadenslagen ausfallen oder überlastet werden, Mobilfunk und Internet hängen am Stromnetz. Einsatz- und Hilfskräften fehlt dann ein einfacher und schneller Weg, wichtige Nachrichten auszutauschen.

  #kern[Ziel: ein robustes Gerät für Textnachrichten, das ohne externe Infrastruktur funktioniert. Es ersetzt keinen TETRA-Funk im Regelbetrieb, sondern springt ein, wenn gewohnte Wege ausfallen.]

  == Anforderungen
  - Funktioniert ohne Mobilfunk, Internet und Stromnetz.
  - Reicht mehrere Kilometer weit.
  - Sendet Freitext, gespeicherte Nachrichten und Notfall-Meldungen auf Knopfdruck.
  - Ist ohne Funkausbildung und mit Handschuhen bedienbar.
  - Bleibt bei Sonne und Dunkelheit lesbar.
  - Läuft mehrere Tage mit einer Akkuladung.
]

#let teil-2 = [
  = Lösungsansatz
  Akkubetriebene Handfunkgeräte bilden untereinander ein Netz. Dieses sogenannte "Mesh" wächst mit jedem weiteren Gerät.

  #kern[Jedes Gerät ist ein Knoten und leitet Nachrichten für andere weiter. Eine Zentrale gibt es nicht.]

  == Mesh-Routing
  #nebeneinander(
    18.7cm,
    bild-rechts: true,
    [#figure(
      block(stroke: 0.05cm + linie, inset: 1cm, scale(75%, reflow: true, mesh)),
      caption: [Nachricht von A nach B über drei Zwischenstationen],
    ) <abb-mesh>],
    [
      - Jeder Knoten sendet eine Nachricht einmal weiter @meshtastic-algo.
      - Eine Nachricht wird bis zu dreimal weitergeleitet @meshtastic-lora.
      - Fällt ein Knoten aus, nimmt die Nachricht einen anderen Weg.
      - AES verschlüsselt jede Nachricht @meshtastic-enc.
    ],
  )

  == Systemaufbau
  #nebeneinander(
    15cm,
    bild-rechts: true,
    [#figure(
      image("bilder/commscube_mockup.png", width: 100%),
      caption: [Entwurf des CommsCube],
    ) <abb-geraet>],
    [
      - Kernmodul RAK4631 mit LoRa-Funk im lizenzfreien 868-MHz-Band @rak4631 @lora-wiki.
      - Meshtastic als quelloffenes Protokoll @meshtastic-intro.
      - E-Paper-Anzeige mit 4,2 Zoll.
      - Große Tasten, Drehrad und versenkter Notfall-Taster.
      - Li-Ionen-Akku mit 10~000~mAh.
    ],
  )
]

#let teil-3 = [
  = Ergebnis
  #kern[Ein LoRa-Mesh auf Basis von Meshtastic eignet sich als einfaches Ersatzsystem für Textnachrichten.]

  == Versuch
  - Zwei eigene Knoten und ein handelsübliches Meshtastic-Gerät tauschen Nachrichten über das Mesh aus.

  #figure(
    image("bilder/map_plus_logo.png", width: 26cm),
    caption: [Meshtastic-Knoten im Raum München (Platzhalter)],
  ) <abb-karte>

  == Energiebedarf
  - Der Akku hält auch im Dauerbetrieb mindestens 8 Tage (@abb-energie).
  - Am meisten verbraucht das dauerhaft laufende GNSS-Modul.

  #[
    #show figure: set align(left)
    #figure(
      image("bilder/energie_laufzeit_rot_breit.svg"),
      caption: read("bilder/energie_laufzeit.txt"),
    ) <abb-energie>
  ]

  == Ausblick
  - Tests unter Einsatzbedingungen und Messung des Energiebedarfs.
]

// Drei Teile von links nach rechts, getrennt durch senkrechte Linien
// Motivation braucht am wenigsten Platz
#let teile = grid(
  columns: (0.7fr, 1.2fr, 1.1fr),
  inset: (x, y) => (left: if x > 0 { 2.5cm } else { 0cm }, right: if x < 2 { 2.5cm } else { 0cm }),
  stroke: (x, y) => if x > 0 { (left: 0.06cm + linie) },
  teil-1, teil-2, teil-3,
)

// Ganze Seite als Raster mit fester Höhe
#block(height: 100%, grid(
  rows: (auto, 1fr, auto),
  row-gutter: 1.5cm,
  kopf,
  teile,
  literatur,
))
