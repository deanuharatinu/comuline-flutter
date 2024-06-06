import 'package:chopper/chopper.dart';
import 'package:comuline/component_library/theme/comuline_theme.dart';
import 'package:comuline/component_library/theme/comuline_theme_data.dart';
import 'package:comuline/component_library/theme/dark_mode_preference.dart';
import 'package:comuline/data/remote/api_service.dart';
import 'package:comuline/data/remote/remote_source.dart';
import 'package:comuline/data/repository/station_repository.dart';
import 'package:comuline/features/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart' as logging;

void main() {
  _setupLogging();

  runApp(const Comuline());
}

void _setupLogging() {
  logging.Logger.root.level = logging.Level.ALL;
  logging.Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });
}

class Comuline extends StatefulWidget {
  const Comuline({super.key});

  @override
  State<Comuline> createState() => _ComulineState();
}

class _ComulineState extends State<Comuline> {
  var darkModePreference = DarkModePreference.alwaysLight;

  late final _chopper = ChopperClient(
    converter: const JsonConverter(),
    errorConverter: const JsonConverter(),
    interceptors: [
      HttpLoggingInterceptor(),
    ],
  );
  late final _apiService = ApiService.create(_chopper);

  late final _remoteSource = RemoteSource(apiService: _apiService);
  late final _repository = StationRepository(remoteSource: _remoteSource);

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
