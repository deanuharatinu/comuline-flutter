import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension OrOther on dynamic {
  String get orEmpty => this ?? '';
  int orInt(int value) => this ?? value;
  bool orBool(bool value) => this ?? value;
}

extension StringUtils on String {
  String get capitalize {
    final splittedText = split(' ');
    return splittedText.map((word) => _capitalize(word)).join(' ');
  }

  String _capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  Color get hexToColor {
    try {
      final buffer = StringBuffer();
      if (length == 6 || length == 7) buffer.write('ff');
      buffer.write(replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } on Exception catch (e) {
      debugPrint(e.toString());
      return Colors.white;
    }
  }
}

extension HashUtils on dynamic {
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

class DateTimeUtils {
  static int parseToMillis({
    required String dateTime,
  }) {
    try {
      final dateTimeFormat = DateTime.parse(dateTime);
      return dateTimeFormat.millisecondsSinceEpoch;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  String parseMillisToDateFormat({
    required int millis,
    required String dateFormat,
  }) {
    try {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(millis, isUtc: true);
      return DateFormat(dateFormat).format(date);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }

  static String parseToDateFormat({
    required String date,
    required String dateFormat,
  }) {
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat(dateFormat).format(parsedDate);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }

  static Duration getTimeDiffFromNow({required String dateTime}) {
    final millis = parseToMillis(dateTime: dateTime);
    final dateTime1 = DateTime.now();
    final dateTime2 = DateTime.fromMillisecondsSinceEpoch(millis);

    return dateTime2.difference(dateTime1);
  }
}
