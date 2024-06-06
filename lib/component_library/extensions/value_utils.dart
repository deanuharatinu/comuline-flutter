extension OrOther on dynamic {
  String get orEmpty => this ?? '';
  int orInt(int value) => this ?? value;
  bool orBool(bool value) => this ?? value;
}

extension StringManipulator on String {
  String get capitalize {
    final splittedText = split(' ');
    return splittedText.map((word) => _capitalize(word)).join(' ');
  }

  String _capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
