# Java Processing

![ScreenShot](/images/ScreenShot.png)

### Programmieren mit Processing
---

#### 1. Variablen
##### Variablen sagen dem Computer etwas abzuspeichern. Sie werden erst deklariert und dann initialisiert. In java muss man bei der Deklarierung auch den Datentyp angeben.
```java
int x;
x = 0;
println(x);
```
##### Als erstes deklarieren wir den integer x. Initialisieren ihn auf 0 und drucken in anschließlich in der Konsole. Mit dem Semikolon am Ende einer Zeile können wir unsere Befehlt voneinander trennen.
```java
--> 0
```
##### Wie der Name schon sagt sind Variablen variabel, sie lassen sich also verändern.
```java
int x;
x = 0;
println(x);
x = 2;
println(x);
```
```java
--> 0
--> 2
```
##### integer lassen sich adaptiv ändern über +, -, *, /. durch z.B. += wird der alte Wert um einen neuen addiert.

##### andere Datentypen sind floats (fließkommazahlen), Strings, Booleans wie true oder false, chars oder z.B. die in Processing vordefinierten Datentypen PImage, PFont

---
#### 2. Bedingungsstatements
##### Aktuell sind unsere Befehle an den Computer noch sehr stumpf. Im nächsten Schritt wollen wir Logik einbauen. If sagt dem Computer, dass er einen Block von befehlen ausführen soll, falls eine Gewisse Bedingung zutrifft.
```java
int x = 0;
if (x > 0): {
    println(x);
}
x += 1;
if (x > 0): {
    println(x);
}
```
```java
--> 1
```
##### Neben dem if-Statement gibt es noch else oder else if. Else führt einen Block aus, falls eine Bedingung nicht zutrifft. Bei else-if wird eine Bedingung nur überprüft, falls weiter oben definierte Bedingungen nicht zutrafen.
```java
int x = 0;
if (x > 0) {
    println(x);
}
else if (x < 0) {
    println(abs(x), "negative")
}
else {
    println('x must be zero!');
}
```
```java
--> 'x must be zero!'
```
---
#### 3. Schleifen
##### Die aktuelle weise wie wir code schreiben skaliert nicht sehr gut. Deshalb brauchen wir Schleifen. Es gibt for und while schleifen. 
```java
for (int i = 0; i < 3; i++){
    println(x);
}
```
```java
--> 0
--> 1
--> 2
```
---
#### 4. Funktionen
##### Ein weiters Werkzeug beim prgrammieren sind Funktionen. Hierbei handelt es sich um längere Blöcke von Code, die wir gezielt an anderen Stellen einsetzen können.
```java
int CelsiusToFahrenheit(int c) {
    return c * 9/5 + 32;
}
println(CelsiusToFahrenheit(30))
```
```java
--> 86
```
##### Der Datentyp der Funktion gibt den Datentyp davon an, was die Funktion zurückgeben soll. Wenn man nichts 'returnen' möchte, kann man void angeben.
##### Ähnlich wie eigene Datentypen hat Processing auch native Funktionen.
##### So wird die Setup Funktion direkt ausgeführt und die draw Funktion fungiert wie eine While schleife. Sie wird also jeden Frame wieder ausgeführt. Andere eingebaute Funktionen sind KeyPressed oder MousePressed.
```java
int x;

void setup() {
    x = 2;
    println('1')
}

void draw() {
    println(x);
    x += 1;
}
```
```java
--> '1'
--> 2
--> 3
--> 4
....
```
---
#### 5. Vorteile von Processing
##### Mit Java Processing ist es möglich sehr schnell visuelle Ergbnisse für seinen Code zu bekommen. Da wir SpaceInvaders programmieren wollen können wir als erstes ein Bild von einem Raumschiff auf einem Fenster zeichnen.
```java
PImage ship;

void setup() {
  size(600, 400);
  ship = loadImage("ship.png");
  ship.resize(100, 100);
}

void draw() {
  background(255);
  image(ship, width / 2 - ship.width / 2, height - ship.height);
}
```
##### Wir nutzen den Processing Datentyp PImage und laden im Setup das Bild "ship.png", das sich im selben Ordner befindet. Mit size(600, 400) erstellen wir ein Fenster mit 600x400 Pixeln. In der Hauptschleife draw() definieren wir eine Farbe für den Hintergrund und zeichnen dann unser Bild.
![ScreenShot](/TageBuchCode/SI1/img.png)
##### Lass uns das Bild nun mit Pfeiltasten bewegen.
```java
PImage ship;
int mode;
int x;
int Speed;

void setup() {
  size(600, 400);
  ship = loadImage("ship.png");
  ship.resize(100, 100);
  x = width / 2 - ship.width / 2;
  mode = 1;
  Speed = 3;
}

void draw() {
  background(255);
  image(ship, x, height - ship.height);
  if (mode == -1 && x >= 0) {
    x -= Speed;
  }
  if (mode == 1 && x <= width - ship.width) {
    x += Speed;
  }
}

void keyPressed() {
  if (keyCode == LEFT) {
    mode = -1;
  }
  if (keyCode == RIGHT) {
    mode = 1;
  }
}
```
##### Damit die Bewegungen flüssig sind arbeiten wir mit Modes.
---
#### 6. Klassen