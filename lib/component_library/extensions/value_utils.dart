import 'package:flutter/material.dart';

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

extension HashHelper on dynamic {
  int get fastHash {
    if (this is String) {
      var hash = 0xcbf29ce484222325;

      var i = 0;
      while (i < this.length) {
        final codeUnit = this.codeUnitAt(i++);
        hash ^= codeUnit >> 8;
        hash *= 0x100000001b3;
        hash ^= codeUnit & 0xFF;
        hash *= 0x100000001b3;
      }

      return hash;
    }

    return 0;
  }
}

Color hexToColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
