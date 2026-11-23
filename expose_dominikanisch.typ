

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



= Abstract / Problembeschreibung
Gerade bei Großschadenslagen können Ausfälle des BOS-Digitalfunks und andere Systeme die Arbeit von Rettungs- und Hilfskräften zusätzlich erschweren.
Deshalb soll eine einfache, möglichst unabhängige Möglichkeit entwickelt werden, kurze Textnachrichten auszutauschen.
Der Würfel soll nicht als weiteres Kommunikationsgerät für den Regelbetrieb entwickelt werden, sondern als Rückfallsystem.

// Einsatzszenario 1: Logistik (ausgewählt)
//Bei größeren Einsätzen müssen neben akuten Notfällen auch Material, Verpflegung und freiwillige Helfer koordiniert werden. Die Nachricht, dass der Nudelvorrat einer Hilfsstation nur noch bei fünf Prozent liegt, ist durchaus wichtig -- sollte aber nicht den Funkverkehr während einer Brandbekämpfung belegen. NotKubi soll solche organisatorischen Nachrichten auf einen eigenen Kommunikationsweg verlagern. Dank einer unabhängigen Energieversorgung könnten die Würfel auch an Hilfsstationen und freiwillige Helfer ausgegeben werden. Dringende Meldungen sollen dabei Vorrang erhalten.

// Einsatzszenario 2: Rückfallebene (Alternative, auskommentiert)
 
Der Würfel soll resilient gegen Krisen-, Katastrophen und Blackoutlagen, wenn gewohnte Kommunikationswege nicht mehr funktionieren, auch noch zuverfässige rudimentäre Kommunikation gewährleisten.
Außerdem soll der Fokus auf einfacher Bedienbarkeit und hoher Robustheit liegen.
Die Kantenlänge des Würfels soll ca. $15  "cm"$ betragen.

= Lösungsvorschlag
Der Lösungsvorschlag ist ein Text-Funkgerät, das auf lizenfreiem LoRa Funk basiert.
Konkret wird das quelloffene Funkprotokoll Meshtastic als Grundlage genutzt.
Das bereits weitverbreitete dezentrale Netzwerk ist resilient und zuverlässig.
#align(center)[#image("map_plus_logo.png", width: 100%)]
Die Eingabe und Anzeige einfacher Nachrichten erfolgt über ein integriertes Display und mehrere Tasten.
//#align(center)[#image("moc.png" ,width: 20%)]
Unabhängikeit von bestehender Kommunikations-Infrastruktur wird mit einem Mesh-Netzwerk gelöst.
Ein integrieter Akku und kleine Baugröße ermöglichen den mobilen Einsatz.


// Als Grundlage dient ein Mikrocontroller, ein Display, und ein LoRa-Funkmodul für das 868-MHz-Band vorgesehen.
// Sowohl Freitext als auch vordefinierte Nachrichten sollen am Würfel verfasst, versendet, empfangen und angezeigt werden.
// Eine wesentliche Anforderung ist die Kommunikation über ein Mesh-Netzwerk.
// Jeder Würfel soll also auch Nachrichten für andere Geräte weiterleiten können.
// Dadurch lässt sich die Kommunikation über mehrere Würfel hinweg erweitern, ohne eine zentrale Station zu benötigen.
// Die Stromversorgung soll über einen Akku erfolgen.


// = Zielsetzung und offene Fragen
// Machbarkeit. Die Kommunikation zwischen mindestens zwei Geräten soll funktionsfähig umgesetzt werden, einschließlich des Verfassens, Versendens und Anzeigens von Textnachrichten. Die geforderte Mesh-Funktionalität soll anhand mehrerer Netzwerkknoten und der Weiterleitung von Nachrichten demonstriert werden.
// 
// Dabei müssen nicht alle Netzwerkknoten als vollständig ausgebaute Würfel vorliegen. Einzelne Komponenten können auch in einem offenen Versuchsaufbau betrieben werden.
// 
// Ein erster Akkubetrieb ist vorgesehen. Ob ein fest integrierter Akku oder eine externe Energieversorgung, beispielsweise über eine USB-C-Powerbank, langfristig sinnvoller ist, bleibt zu klären.
// 
// Eine umfassende Erprobung unter realen Einsatzbedingungen, die Prüfung der Zulassungsfähigkeit sowie der Nachweis einer IP-Schutzart oder vergleichbarer Zertifizierungen sind nicht Bestandteil des Projekts.