# Java Processing

![ScreenShot](/images/ScreenShot.png)

### Programmieren mit Processing
---

#### 1. Variablen
##### Mit Variablen können wir etwas zwischenspeichern, um es später weiterzuverwenden. Sie werden erst deklariert und dann initialisiert. In java muss man bei der Deklarierung auch den Datentype angeben.
```java
int x;
x = 0;
println(x);
```
##### Als erstes deklarieren wir den integer x, initialisieren ihn auf 0 und drucken in anschließlich in der Konsole. Mit dem Semikolon am Ende einer Zeile können wir unsere Befehle voneinander trennen.
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
##### integer lassen sich adaptiv ändern über +, -, *, /. Durch += wird der alte Wert um einen neuen addiert.

##### andere Datentypen sind floats (fließkommazahlen), Strings, Booleans also Wahrheitswerte wie true oder false, chars und die in Processing vordefinierten Datentypen PImage, PFont

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
    println(abs(x), "negative");
}
else {
    println("x must be zero!");
}
```
```java
--> "x must be zero!"
```
---
#### 3. Schleifen
##### Die aktuelle weise wie wir code schreiben skaliert nicht sehr gut. Um dies zu ändern brauchen wir Schleifen. Es gibt for und while schleifen. 
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
##### Ein weiters Werkzeug beim prgrammieren sind Funktionen. Hierbei handelt es sich um längere Blöcke von Code, die wir an anderen Stellen aufrufen können.
```java
int CelsiusToFahrenheit(int c) {
    return c * 9/5 + 32;
}
println(CelsiusToFahrenheit(30));
```
```java
--> 86
```
##### Der Datentyp vor der Funktion gibt den Datentyp davon an, was die Funktion zurückgeben soll. Wenn man nichts 'returnen' möchte, kann man void angeben.
##### Ähnlich wie eigene Datentypen hat Processing auch native Funktionen.
##### So wird die Setup Funktion direkt beim Start ausgeführt und die draw Funktion ist wie eine While schleife. Sie wird also jeden Frame ausgeführt. Andere eingebaute Funktionen sind KeyPressed und MousePressed.
```java
int x;

void setup() {
    x = 2;
    println("1");
}

void draw() {
    println(x);
    x += 1;
}

void MousePressed() {
    println("click");
}
```
```java
--> "1"
--> 2
--> 3
--> "click"
--> 4
....
```
---
#### 5. Arrays
##### Arrays sind Listen von einem Datentyp
---
#### 6. Klassen
##### Klassen sind komplizierte Konstrukte, die wir ähnlich wie Funktionen mehreren anderen Stellen einsetzten können.