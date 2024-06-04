import 'package:comuline/component_library/theme/comuline_theme_data.dart';
import 'package:flutter/material.dart';

class ComulineTheme extends InheritedWidget {
  const ComulineTheme({
    required this.lightTheme,
    required this.darkTheme,
    required super.child,
    super.key,
  });

  final ComulineThemeData lightTheme;
  final ComulineThemeData darkTheme;

  @override
  bool updateShouldNotify(ComulineTheme oldWidget) {
    return oldWidget.lightTheme != lightTheme ||
        oldWidget.darkTheme != darkTheme;
  }

  static ComulineThemeData of(BuildContext context) {
    final ComulineTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<ComulineTheme>();

    assert(inheritedTheme != null, 'No WonderTheme found in context');

    final currentBrightness = Theme.of(context).brightness;

    return currentBrightness == Brightness.dark
        ? inheritedTheme!.darkTheme
        : inheritedTheme!.lightTheme;
  }
}
