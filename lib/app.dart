import 'package:comuline/component_library/theme/comuline_theme.dart';
import 'package:comuline/component_library/theme/comuline_theme_data.dart';
import 'package:comuline/component_library/theme/dark_mode_preference.dart';
import 'package:comuline/data/repository/app_state_repository.dart';
import 'package:comuline/di/service_locator.dart';
import 'package:comuline/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Comuline extends StatefulWidget {
  const Comuline({super.key});

  @override
  State<Comuline> createState() => _ComulineState();
}

class _ComulineState extends State<Comuline> {
  final lightTheme = LightComulineThemeData();
  final darkTheme = DarkComulineThemeData();
  late AppRouter appRouter;

  @override
  void initState() {
    appRouter = ServiceLocator.getAppRouter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appStateRepository =
        RepositoryProvider.of<AppStateRepository>(context);

    return StreamBuilder<DarkModePreference>(
        stream: appStateRepository.getDarkModePreference(),
        builder: (context, snapshot) {
          final darkModePreference = snapshot.data;

          return ComulineTheme(
            lightTheme: lightTheme,
            darkTheme: darkTheme,
            child: MaterialApp.router(
              title: 'Comuline',
              debugShowCheckedModeBanner: true,
              themeMode: darkModePreference?.themeMode(),
              theme: lightTheme.materialThemeData,
              darkTheme: darkTheme.materialThemeData,
              routerConfig: appRouter.config(),
            ),
          );
        });
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
