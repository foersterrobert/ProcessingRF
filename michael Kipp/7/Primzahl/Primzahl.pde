void setup() {
  println(istPrim(7));
  println(istPrim(15));
  println(istPrim(97));
}

boolean istPrim(int n) {
  for (int i = 2; i < n; i++) {
    if (n / i == n / float(i)) {
      return false;
    }
  }
  return true;
}
