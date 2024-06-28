import 'package:flutter/material.dart';

abstract class ComulineThemeData {
  ThemeData get materialThemeData;
  LinearGradient get shimmerGradient;
}

class LightComulineThemeData extends ComulineThemeData {
  @override
  ThemeData get materialThemeData => ThemeData(
        fontFamily: 'Roboto',
        brightness: Brightness.light,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
        listTileTheme: ListTileThemeData(
          iconColor: Colors.grey.shade900,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.grey.shade800,
          selectionColor: Colors.grey.shade300,
          selectionHandleColor: Colors.grey.shade600,
        ),
      );

  @override
  LinearGradient get shimmerGradient => LinearGradient(
        colors: [
          Colors.grey.shade300,
          const Color(0xFFF4F4F4),
          Colors.grey.shade300,
        ],
        stops: const [
          0.1,
          0.3,
          0.4,
        ],
        begin: const Alignment(-1.0, -0.3),
        end: const Alignment(1.0, 0.3),
        tileMode: TileMode.clamp,
      );
}

class DarkComulineThemeData extends ComulineThemeData {
  @override
  ThemeData get materialThemeData => ThemeData(
        fontFamily: 'Roboto',
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey.shade900,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade900,
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.white70,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.white60,
          selectionColor: Colors.white60,
          selectionHandleColor: Colors.grey.shade700,
        ),
      );

  @override
  LinearGradient get shimmerGradient => LinearGradient(
        colors: [
          Colors.grey.shade800,
          Colors.grey.shade700,
          Colors.grey.shade800,
        ],
        stops: const [
          0.1,
          0.3,
          0.4,
        ],
        begin: const Alignment(-1.0, -0.3),
        end: const Alignment(1.0, 0.3),
        tileMode: TileMode.clamp,
      );
}

extension on Color {
  Map<int, Color> _toSwatch() => {
        50: withOpacity(0.1),
        100: withOpacity(0.2),
        200: withOpacity(0.3),
        300: withOpacity(0.4),
        400: withOpacity(0.5),
        500: withOpacity(0.6),
        600: withOpacity(0.7),
        700: withOpacity(0.8),
        800: withOpacity(0.9),
        900: this,
      };

  MaterialColor toMaterialColor() => MaterialColor(
        value,
        _toSwatch(),
      );
}
