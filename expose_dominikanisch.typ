#set page(
  paper: "a4",
  margin: (left: 2.4cm, right: 2.4cm, top: 1.3cm, bottom: 2.3cm),
  numbering: none,
)
#set text(lang: "de", size: 11pt)
#set par(first-line-indent: 0pt, spacing: 0.35em)

#align(center)[
  // Logo als Hauptüberschrift
  #image("logo.png", width: 33%)

  // Untertitel
  #text(size: 11pt, style: "italic")[Emergency Mesh Communication]

  // KI-Disclaimer für das Logo
  #text(size: 8pt, style: "italic")[(Logo KI-generiert)]
]

#set heading(numbering: "1.1", )
#show heading: it => {
  set align(center)
  set block(above: 2em, below: 1em)
  it
}


= Projektidee und Einsatzgebiet
Unsere digitalisierte Gesellschaft ist auf eine zuverlässige Energie- und Kommunikationsinfrastruktur angewiesen. Gerade bei Großschadenslagen können Ausfälle dieser Systeme die Arbeit von Rettungs- und Hilfskräften zusätzlich erschweren. NotKubi soll deshalb eine einfache, möglichst unabhängige Möglichkeit bieten, kurze Textnachrichten auszutauschen. Der Würfel soll keinen bestehenden Einsatzfunk ersetzen, sondern diesen sinnvoll ergänzen.

// Einsatzszenario 1: Logistik (ausgewählt)
Bei größeren Einsätzen müssen neben akuten Notfällen auch Material, Verpflegung und freiwillige Helfer koordiniert werden. Die Nachricht, dass der Nudelvorrat einer Hilfsstation nur noch bei fünf Prozent liegt, ist durchaus wichtig -- sollte aber nicht den Funkverkehr während einer Brandbekämpfung belegen. NotKubi soll solche organisatorischen Nachrichten auf einen eigenen Kommunikationsweg verlagern. Dank einer unabhängigen Energieversorgung könnten die Würfel auch an Hilfsstationen und freiwillige Helfer ausgegeben werden. Dringende Meldungen sollen dabei Vorrang erhalten.

// Einsatzszenario 2: Rückfallebene (Alternative, auskommentiert)
// Auch gut ausgestattete Rettungskräfte können in Situationen geraten,
// in denen gewohnte Kommunikationswege nicht mehr funktionieren: etwa bei
// Ausfall der Leitstelle, fehlender Funkabdeckung oder defekten Geräten.
// NotKubi soll dann als letzte Rückfallebene dienen. Dank eigener
// Energieversorgung könnten die Würfel weiterhin kurze Nachrichten
// austauschen, ohne auf eine bestehende Funk- oder Mobilfunkinfrastruktur
// angewiesen zu sein.


= Technische Umsetzung
Als Grundlage sind ein energiesparender Mikrocontroller, ein Display und ein LoRa-Funkmodul für das 868-MHz-Band vorgesehen. Nachrichten sollen am Würfel angezeigt, verfasst und versendet werden können. Eine wesentliche Anforderung ist der Aufbau eines Mesh-Netzwerks: Jeder Würfel soll nicht nur eigene Nachrichten senden und empfangen, sondern auch Nachrichten für andere Geräte weiterleiten können. Dadurch lässt sich die Kommunikation über mehrere Würfel hinweg erweitern, ohne eine zentrale Sendestation zu benötigen. Die Stromversorgung soll über einen Akku erfolgen.


= Zielsetzung und offene Fragen
Machbarkeit. Die Kommunikation zwischen mindestens zwei Geräten soll funktionsfähig umgesetzt werden, einschließlich des Verfassens, Versendens und Anzeigens von Textnachrichten. Die geforderte Mesh-Funktionalität soll anhand mehrerer Netzwerkknoten und der Weiterleitung von Nachrichten demonstriert werden.

Dabei müssen nicht alle Netzwerkknoten als vollständig ausgebaute Würfel vorliegen. Einzelne Komponenten können auch in einem offenen Versuchsaufbau betrieben werden.

Ein erster Akkubetrieb ist vorgesehen. Ob ein fest integrierter Akku oder eine externe Energieversorgung, beispielsweise über eine USB-C-Powerbank, langfristig sinnvoller ist, bleibt zu klären.

Eine umfassende Erprobung unter realen Einsatzbedingungen, die Prüfung der Zulassungsfähigkeit sowie der Nachweis einer IP-Schutzart oder vergleichbarer Zertifizierungen sind nicht Bestandteil des Projekts.
