import 'package:comuline/component_library/theme/comuline_theme.dart';
import 'package:comuline/component_library/theme/comuline_theme_data.dart';
import 'package:comuline/component_library/theme/dark_mode_preference.dart';
import 'package:comuline/data/repository/station_repository.dart';
import 'package:comuline/features/home/view/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Comuline());
}

class Comuline extends StatefulWidget {
  const Comuline({super.key});

  @override
  State<Comuline> createState() => _ComulineState();
}

class _ComulineState extends State<Comuline> {
  var darkModePreference = DarkModePreference.alwaysLight;

  late final _repository = StationRepository();

  @override
  Widget build(BuildContext context) {
    final lightTheme = LightComulineThemeData();
    final darkTheme = DarkComulineThemeData();

    return ComulineTheme(
      lightTheme: lightTheme,
      darkTheme: darkTheme,
      child: MaterialApp(
        title: 'Comuline',
        debugShowCheckedModeBanner: true,
        themeMode: darkModePreference.themeMode(),
        theme: lightTheme.materialThemeData,
        darkTheme: darkTheme.materialThemeData,
        home: HomeScreen(
          repository: _repository,
          onThemeToggleTap: () {
            setState(() {
              darkModePreference =
                  darkModePreference == DarkModePreference.alwaysLight
                      ? DarkModePreference.alwaysDark
                      : DarkModePreference.alwaysLight;
            });
          },
        ),
      ),
    );
  }
}

extension on DarkModePreference {
  ThemeMode themeMode() {
    switch (this) {
      case DarkModePreference.alwaysDark:
        return ThemeMode.dark;
      case DarkModePreference.alwaysLight:
        return ThemeMode.light;
    }
  }
}
