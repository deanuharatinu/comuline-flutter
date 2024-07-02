import 'package:comuline/data/repository/app_state_repository.dart';
import 'package:comuline/data/repository/station_repository.dart';
import 'package:comuline/di/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart' as logging;

class AppBootstraper {
  AppBootstraper._();

  static Future<void> init({
    required Widget mainAppWidget,
    required void Function(Widget) runApp,
  }) async {
    _setupLogging();
    final appRouter = ServiceLocator.getAppRouter();

    // Network inspector tool
    if (kDebugMode) {
      final alice = ServiceLocator.getAlice();
      final aliceChopperAdapter = ServiceLocator.getAliceChopperAdapter();
      alice.addAdapter(aliceChopperAdapter);
      alice.setNavigatorKey(appRouter.navigatorKey);
    }

    final stationRepository = await ServiceLocator.getStationRepository();
    final appStateRepository = await ServiceLocator.getAppStateRepository();

    final providers = MultiRepositoryProvider(
      providers: [
        RepositoryProvider<StationRepository>(
          create: (context) => stationRepository,
        ),
        RepositoryProvider<AppStateRepository>(
          create: (context) => appStateRepository,
        ),
      ],
      child: mainAppWidget,
    );

    runApp(providers);
  }

  static void _setupLogging() {
    logging.Logger.root.level = logging.Level.ALL;
    logging.Logger.root.onRecord.listen((record) {
      debugPrint('${record.level.name}: ${record.time}: ${record.message}');
    });
  }
}
