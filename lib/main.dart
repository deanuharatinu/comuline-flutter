import 'package:comuline/component_library/theme/comuline_theme.dart';
import 'package:comuline/component_library/theme/comuline_theme_data.dart';
import 'package:comuline/component_library/theme/dark_mode_preference.dart';
import 'package:comuline/data/repository/station_repository.dart';
import 'package:comuline/di/repository_injector.dart';
import 'package:comuline/features/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart' as logging;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _setupLogging();

  final StationRepository repository =
      await RepositoryInjector.injectStationRepository();

  runApp(Comuline(
    stationRepository: repository,
  ));
}

void _setupLogging() {
  logging.Logger.root.level = logging.Level.ALL;
  logging.Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });
}

class Comuline extends StatefulWidget {
  const Comuline({
    required StationRepository stationRepository,
    super.key,
  }) : _stationRepository = stationRepository;

  final StationRepository _stationRepository;

  @override
  State<Comuline> createState() => _ComulineState();
}

class _ComulineState extends State<Comuline> {
  var darkModePreference = DarkModePreference.alwaysLight;

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
          darkModePreference: darkModePreference,
          repository: widget._stationRepository,
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
