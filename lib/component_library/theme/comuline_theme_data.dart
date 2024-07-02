import 'package:comuline/component_library/theme/dark_mode_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

extension ThemeExtension on DarkModePreference? {
  SystemUiOverlayStyle getStatusBarStyle() {
    if (this == DarkModePreference.alwaysLight) {
      return SystemUiOverlayStyle.dark;
    } else {
      return SystemUiOverlayStyle.light;
    }
  }

  DarkModePreference toggleDarkMode() {
    if (this == DarkModePreference.alwaysLight) {
      return DarkModePreference.alwaysDark;
    } else {
      return DarkModePreference.alwaysLight;
    }
  }
}
