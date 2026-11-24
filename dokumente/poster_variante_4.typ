// Poster A0 hochkant, Variante 4: Aufbau nach IEEE-Konferenzvorlage
#let schwarz = luma(0)
#let akzent = luma(20)
#let dunkel = luma(0)
#let grau = luma(90)
#let linie = luma(200)

#let hm-logo = image("bilder/hm_logo.svg", height: 8cm)

#set page(paper: "a0", margin: (x: 3.5cm, top: 3cm, bottom: 3.5cm), fill: white)

// Drittelraster zur Kontrolle: typst compile --input raster=1 poster_variante_4.typ
#set page(foreground: if sys.inputs.at("raster", default: "0") == "1" {
  for f in (1 / 3, 2 / 3) {
    place(line(start: (f * 100%, 0%), end: (f * 100%, 100%), stroke: 0.15cm + red))
    place(line(start: (0%, f * 100%), end: (100%, f * 100%), stroke: 0.15cm + red))
  }
})

// Times wie in IEEE-Vorlagen, Blocksatz mit Silbentrennung
#set text(lang: "de", size: 39pt, font: "TeX Gyre Termes", fill: schwarz)
#set par(justify: true, leading: 0.5em, spacing: 0.75em, first-line-indent: (amount: 1em, all: false))

// Abschnitte: römische Nummer, Kapitälchen, zentriert
#set heading(numbering: "I.")
#show heading.where(level: 1): it => block(above: 1.8cm, below: 0.9cm, width: 100%, align(center, text(
  size: 44pt,
  weight: "regular",
  hyphenate: false,
)[#counter(heading).display(it.numbering) #h(0.3em) #smallcaps(it.body)]))

#set list(marker: [•], body-indent: 0.5em, spacing: 0.6em)
#show list: set par(justify: false)

// Bildunterschriften wie bei IEEE: „Abb. 1.“ gefolgt vom Text, kleiner gesetzt
#set figure(gap: 0.7cm, supplement: [Abb.])
#show figure.caption: it => {
  set text(size: 30pt)
  set par(justify: true, first-line-indent: 0em)
  set align(left)
  [#it.supplement~#context it.counter.display(it.numbering). #it.body]
}

// Formeln rechts nummeriert
#set math.equation(numbering: "(1)")

// Begriffe als kursive Zwischenüberschrift im Fließtext (IEEE-Ebene 3)
#show terms.item: it => par(first-line-indent: 0em)[#emph[#it.term:] #it.description]

// Kernaussagen ohne Hervorhebung, wie normaler Absatz
#let kern(inhalt) = par(inhalt)

// Zusammenfassung und Schlüsselwörter mit fett-kursivem Einstieg
#let zusammenfassung = {
  set text(weight: "bold", size: 34pt)
  set par(first-line-indent: 0em)
  [#emph[Zusammenfassung.] Fallen im Ernstfall Digitalfunk, Mobilfunk und Internet aus, fehlt Einsatz- und Hilfskräften ein einfacher Weg, kurze Nachrichten auszutauschen. Der CommsCube ist ein akkubetriebenes Handfunkgerät, das Textnachrichten über ein LoRa-Mesh auf Basis von Meshtastic sendet und weiterleitet. Das Poster beschreibt Anforderungen, Systemaufbau und eine erste Abschätzung des Energiebedarfs.]
  parbreak()
  [#emph[Schlüsselwörter:] LoRa, Mesh-Netz, Meshtastic, Katastrophenschutz, E-Paper]
}

// Kopf: zentrierter Titel, Autoren, Einrichtung, Logos außen
#let kopf = {
  set par(justify: false, first-line-indent: 0em)
  set text(hyphenate: false)
  grid(
    columns: (auto, 1fr, auto),
    column-gutter: 3cm,
    align: horizon,
    hm-logo,
    align(center, stack(
      spacing: 1.2cm,
      text(size: 80pt)[CommsCube: Infrastrukturunabhängiger Textfunk als Ersatzsystem für den Ernstfall],
      text(size: 40pt)[Fabian~Fahmüller, Dominik~Dethleffsen, Julian~Störig, Florian~Rößler],
      text(size: 34pt, style: "italic")[Hochschule München, München, Deutschland],
    )),
    image("bilder/logo.svg", width: 12cm),
  )
}

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
#let literatur = block(width: 100%)[
  #align(center, text(size: 36pt, smallcaps[Literatur]))
  #set text(size: 26pt)
  #set par(first-line-indent: 0em)
  #block(height: 7cm, columns(3, gutter: 2.5cm, bibliography("refs.bib", title: none, style: "ieee")))
]

// Drei Spalten, der Inhalt fließt automatisch von einer Spalte in die nächste
#let spalten = columns(3, gutter: 2.5cm)[
  #zusammenfassung

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

  / Rechner: ESP32-S3
  / Funk: LoRa-Modul SX1276, 868 MHz @lora-board
  / Anzeige: 4,2-Zoll-E-Paper, 400 × 300 px
  / Bedienung: Große Tasten und seitliches Drehrad, auch mit Handschuhen
  / Notfall: Versenkter Taster sendet eine Notfall-Meldung
  / Energie: Li-Ionen-Akku, 10~000~mAh, 3,7~V

  = Mesh-Routing
  #figure(
    align(center, mesh),
    caption: [Nachricht von A nach B über drei Zwischenstationen],
  ) <abb-mesh>

  / Managed Flooding: Jeder Knoten sendet eine empfangene Nachricht einmal weiter @meshtastic-algo.
  / Vorrang: Knoten mit schwachem Empfang senden zuerst. Sie liegen meist am Rand der Reichweite.
  / Duplikate: Eine schon weitergeleitete Nachricht wird nicht erneut gesendet.
  / Hop-Limit: 3 Weiterleitungen, maximal 7 @meshtastic-lora.
  / Ausfall: Fällt ein Knoten aus, nimmt die Nachricht einen anderen Weg. Eine Zentrale gibt es nicht.
  / Verschlüsselung: AES mit Kanalschlüssel @meshtastic-enc.

  = Energiebedarf
  #figure(
    image("bilder/energie_laufzeit_grau.svg"),
    caption: read("bilder/energie_laufzeit.txt"),
  ) <abb-energie>

  Im Ernstfall mit dauerhaft aktivem GNSS zieht das Gerät im Mittel 43~mA. Mit 8500~mAh nutzbarer Ladung hält es rund 8 Tage:

  $ t = C / I = (8500 "mAh") / (43 "mA") approx 198 "h" $

  = Ergebnisse
  Ein Versuchsaufbau mit zwei eigenen Knoten und einem handelsüblichen Meshtastic-Gerät tauscht Nachrichten über das Mesh aus.

  #figure(
    image("bilder/map_plus_logo.png", width: 85%),
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
  row-gutter: 2.5cm,
  kopf,
  spalten,
  literatur,
))
