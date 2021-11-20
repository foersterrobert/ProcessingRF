# Java Processing
![ScreenShot](/images/ScreenShot.png)
### Programmieren mit Processing
---
#### 1. Variablen
##### Mit Variablen können wir etwas zwischenspeichern, um es später weiterzuverwenden. Sie werden erst deklariert und dann initialisiert. In java muss man bei der Deklarierung auch den Datentyp angeben.
```java
int x;
x = 0;
println(x);
```
##### Als Erstes deklarieren wir den integer x, initialisieren ihn auf 0 und drucken in anschließlich in der Konsole. Mit dem Semikolon am Ende einer Zeile können wir unsere Befehle voneinander trennen.
```java
--> 0
```
##### Wie der Name schon sagt, sind Variablen variabel, sie lassen sich also verändern.
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
##### integer lassen sich adaptiv über +, -, * und / ändern. Durch += wird der alte Wert um einen neuen addiert. Statt x = x + 1 können wir also x+=1 schreiben oder noch kürzer x++. Andersherum wird durch x-- die Variable x um 1 subtrahiert.
##### Parallel zu integern gibt es noch die primitiven Datentypen floats (Fließkommazahlen), Booleans (Wahrheitswerte) wie true oder false, color und chars (z.B. Buchstaben). Komplexer ist der Datentyp String, mit dem wir Texte speichern können, oder die in Processing vordefinierten Datentypen PImage, PFont und PVector, da diese ebenfalls über zusätzliche Methoden verfügen.
##### 1.1. Systemvariablen
##### Neben eigenen Datentypen liefert Processing auch eigene Systemvariablen, die uns immer automatisch zur Verfügung stehen. width und height liefern uns die Pixelgröße unseres Fensters, und mouseX und mouseY geben uns die Koordinaten unserer Maus.
---
#### 2. Bedingungsstatements
##### Aktuell sind unsere Befehle an den Computer noch sehr stumpf. Im nächsten Schritt wollen wir Logik einbauen. if sagt dem Computer, dass er einen Block von Befehlen ausführen soll, falls eine gewisse Bedingung zutrifft.
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
##### Neben dem if-Statement gibt es auch noch else und else if. else führt einen Block aus, falls eine Bedingung nicht zutrifft. Bei else-if wird eine Bedingung nur überprüft, falls weiter oben definierte Bedingungen nicht zutrafen.
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
##### Wenn wir mehrere Bedingungen haben, können wir diese mit den logischen Operatoren && (und) und || (oder) zu einem Statement kombinieren.
```java
int Puls = 71;
if (Puls < 90 && Puls > 55) {
    println("Sieht gut aus :)");
}
```
```java
--> "Sieht gut aus :)"
```
---
#### 3. Schleifen
##### Die aktuelle Weise, wie wir Code schreiben, skaliert nicht sehr gut. Deshalb brauchen wir Schleifen, die uns erlauben, einen bestimmten Block mehrmals laufen zu lassen. Die wichtigste Schleife ist die for-Schleife.
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
##### Zusätzlich gibt es noch die while-Schleife, die beim genaueren Hinsehen gar nicht so weit von der for-Schleife entfernt ist.
```java
int i = 0;
while (i < 3){
    println(x);
    i++;
}
```
```java
--> 0
--> 1
--> 2
```
---
#### 4. Funktionen
##### Ein weiteres Werkzeug zum Programmieren sind Funktionen. Hierbei handelt es sich um längere Blöcke von Code, die wir an anderen Stellen aufrufen können.
```java
int CelsiusToFahrenheit(int c) {
    return c * 9/5 + 32;
}
println(CelsiusToFahrenheit(30));
```
```java
--> 86
```
##### Der Datentyp vor der Funktion gibt den Datentyp von dem an, was die Funktion zurückgeben soll. Wenn wir nichts returnen möchten, können wir vorn void angeben.
##### Ähnlich wie eigene Datentypen hat Processing auch native Funktionen.
##### So wird die setup-Funktion direkt beim Start ausgeführt, die draw-Funktion ist wie eine while-Schleife. Sie wird also bei jedem Frame ausgeführt. Andere eingebaute Funktionen sind KeyPressed, MousePressed. Daneben stehen uns auch die Funktionen random, text, background, fill, print und println zur Verfügung.
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
##### Arrays sind Listen, die mehrere Werte von einem Datentyp unter einer Variable und mit zusätzlichen Methoden speichern können.
```java
int[] xarray = new int[5];
for (int i = 0; i<xarray.length; i++) {
    xarray[i] = i;
}
println(xarray);
```
```java
[0] 0
[1] 1
[2] 2
[3] 3
[4] 4
```
##### Einzelne Elemente einer Liste können wir einfach überschreiben.
```java
xarray[2] = 5;
println(xarray);
```
```java
[0] 0
[1] 1
[2] 5
[3] 3
[4] 4
```
---
#### 6. Klassen
##### Klassen sind komplizierte Konstrukte, die wir als Blaupause benutzen können, um einzelne Entitäten zu erschaffen.
```java
class Ball
{
   int xpos;
   int ypos;
   int d; // Durchmesser
}

Ball ball1 = new Ball(10, 10, 2);
Ball ball2 = new Ball(20, 20, 5);
println("ball1: " + ball1.d + ", ball2: " + ball2.d);
```
```java
"ball1: 2, ball2: 5"
```