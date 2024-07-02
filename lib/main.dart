import 'package:alice/alice.dart';
import 'package:alice_chopper/alice_chopper_adapter.dart';
import 'package:comuline/app.dart';
import 'package:comuline/data/repository/app_state_repository.dart';
import 'package:comuline/data/repository/station_repository.dart';
import 'package:comuline/di/repository_injector.dart';
import 'package:comuline/router/router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart' as logging;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _setupLogging();
  AppRouter appRouter = AppRouter();

  // Network inspector tool
  late AliceChopperAdapter aliceChopperAdapter;
  if (kDebugMode) {
    Alice alice = Alice(
      showInspectorOnShake: true,
      showNotification: true,
      showShareButton: true,
    );
    aliceChopperAdapter = AliceChopperAdapter();
    alice.addAdapter(aliceChopperAdapter);
    alice.setNavigatorKey(appRouter.navigatorKey);
  }

  final StationRepository stationRepository =
      await RepositoryInjector.injectStationRepository(
    aliceChopperAdapter: aliceChopperAdapter,
  );
  final AppStateRepository appStateRepository =
      await RepositoryInjector.injectAppStateRepository();

  final app = Comuline(appRouter: appRouter);
  final providers = MultiRepositoryProvider(
    providers: [
      RepositoryProvider<StationRepository>(
        create: (context) => stationRepository,
      ),
      RepositoryProvider<AppStateRepository>(
        create: (context) => appStateRepository,
      ),
    ],
    child: app,
  );

  runApp(providers);
}

void _setupLogging() {
  logging.Logger.root.level = logging.Level.ALL;
  logging.Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });
}
