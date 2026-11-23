
#set page(
  paper: "a4",
  margin: (left: 2.4cm, right: 2.4cm, top: 0.4cm, bottom: 2.3cm),
  numbering: none,
)
#set text(lang: "de", size: 12pt)
#set par(first-line-indent: 0pt)

#align(center)[
  #set text(font: "Arial Black", size: 1.8em,)
  commscube
  #box(move(dx: 0pt, dy: 22pt ,image("logo.svg", width: 21%)))
  
  #text(size: 11pt, style: "italic")[NotKubi, Tessa, bananacube]
]

#set heading(numbering: "1.1", )
#show heading: it => {
  set align(center)
  set block(above: 4em, below: 1em)
  it
}

#title([Sprint 1: Ablaufplan])

= Technische Präsentation

- Wir schicken 1 Person mit Gerät los, für Demo
- Technische Präsentation (7-10 Minuten)
  - Problemstellung
  - Unser Lösungsvorschlag (Würfel)
  - Ziel Sprint 1: funktionsfähiges Funkgerät


= Demonstration

== Setup

- 3 Geräte
  - 1 Bananamesh vor Ort
  - 1 Bananamesh weg
  - 1 Meshtastic Standardgerät vor Ort an Laptop via Serial zwecks Visualisierung
  - Alle Geräte offline

== Durchführung

- Durchführung
  - Von Bananamesh vor Ort wird Nachricht gesendet
  - Nachricht wird von Meshtastic vor Ort empfangen
  - Bananamesh unterwegs antwortet auf Nachricht
  - UI wird mit Dokumentenkamera vorgestellt