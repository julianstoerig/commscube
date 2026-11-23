
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

#title([LoRa Konfiguration])

= Einzelne Funk-Einstellungen

== Region

Dieser Parameter setzt das Frequenzband, Tastgrad und Sendeleistungsbeschränkungen. Die für Deutschland erlaubten Werte sind `EU_433`, `EU_866`, `EU_868`, `EU_N_868` & `LORA_24`. Hier sollte wegen der Leistungsbeschränkungen und Antennengröße unbedingt das 868 MHz ISM-Band `EU_868` gewählt werden.

== Maximale Anzahl von Sprüngen

Jede Nachricht legt im Mesh eine gewisse Zahl an Sprüngen zurück. Wenn sie die maximal erlaubte Anzahl von Sprüngen, 1-7, erreicht, ohne ihr Ziel zu erreichen, wird sie verworfen. Hohe Werte erhöhen die Reichweite in nicht-ausgelasteten Netzwerken, geringere Werte erhöhen die Kapazität des Mesh-Netzwerks.
Der Standardwert 3 hat sich als Kompromiss bewährt. Besonders für den eher auf kurze Reichweiten bezogenen CommsCube Einsatz ist er gut geeignet, um die Kapazität des Netzwerkes hoch zu halten.

== Sendeleistungsbeschränkungen

Die Sendeleistung sollte dem Minimum der der maximalen Sendeleistung des Geräts und der maximal zulässigen Sendeleistung abzüglich Antennengewinn entsprechen.
Für Geräte mit Rundstrahlantennen eines Gewinns von ca. $<3$ dBi ist dies mit der Automatik-Einstellung `0` implementiert.
CommsCube zählt auch zu diesen Geräten.

== Bandbreite

Niedrigere Bandbreiten reduzieren Rauschen, höhere Bandbreiten erhöhen die Datenrate und reduzieren die Gerätekomplexität.
Einen guten Kompromiss bietet die Einstellung `62` für $62.5$ kHz Bandbreite, die im 868 MHz ISM-Band erlaubt ist, mittlere Datenraten zulässt und keine besonderen Anforderungen an Oszillator-Genauigkeit stellt.

== Spreizfaktor

Der Spreizfaktor gibt an, wie viele "Chirps" pro Zeiteinheit gesendet werden, wobei höhere Spreizfaktoren einer geringeren Rate entsprechen.
Da pro Chirp eine gewisse Datenmenge übertragen wird, die langsameren Chirps eines höheren Spreizfaktors allerdings leichter zu detektieren und demodulieren sind, ist auch hier ein Kompromiss gefragt. Der Wert `SF7` aus dem Wertebereich `SF5` - `SF12` hat sich bewährt.

== Coding Rate

Setzt den Teiler der Coderate der Übertragung mit $4 / "Coding Rate"$. Der Standardwert 5 führt zur Coderate $4/5=0.8$ und reduziert Kanalüberlastung.
/*
== Verschlüsselung

Zur Verschlüsselung nutzt Meshtastic standardmäßig AES128 oder AES256 PSK.
*/
= Verwendete Einstellungen

In der Praxis sind viele der oben genannten Einstellungen schon unter sog. "Presets" zusammengefasst.
Die gewählten Einstellungen entsprechen dem Preset "Long Fast", welches breite Anwendung, auch im Raum München, findet.
Es erreicht mit einer Sendeempfangsantenne mit $3 "dBi"$ Gewinn ein typisches Linkbudget von $approx 156 "dB"$ bei einer Datenrate von $1.07 "kBit"/"s"$.