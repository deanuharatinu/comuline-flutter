extension OrOther on dynamic {
  String get orEmpty => this ?? '';
  int orInt(int value) => this ?? value;
  bool orBool(bool value) => this ?? value;
}