import 'package:alice/alice.dart';
import 'package:alice_chopper/alice_chopper_adapter.dart';
import 'package:chopper/chopper.dart';
import 'package:comuline/data/repository/app_state_repository.dart';
import 'package:comuline/data/repository/station_repository.dart';
import 'package:comuline/di/factory/alice_factory.dart';
import 'package:comuline/di/factory/api_service_factory.dart';
import 'package:comuline/di/factory/app_router_factory.dart';
import 'package:comuline/di/factory/chopper_factory.dart';
import 'package:comuline/di/factory/isar_factory.dart';
import 'package:comuline/di/factory/repository_factory.dart';
import 'package:comuline/router/router.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_chopper_logger/pretty_chopper_logger.dart';

class ServiceLocator {
  ServiceLocator._();

  /// Singleton
  static AppRouter getAppRouter() {
    return AppRouterFactory().appRouter;
  }

  /// Singleton
  static Alice getAlice() {
    return AliceFactory().alice;
  }

  /// Singleton
  static AliceChopperAdapter getAliceChopperAdapter() {
    return AliceFactory().aliceChopperAdapter;
  }

  static Future<StationRepository> getStationRepository() async {
    // Local source
    final isar = await IsarFactory().isar;
    final localSource = LocalSourceFactory.create(isar);

    // Remote source
    final client = ChopperFactory(
      converter: const JsonConverter(),
      errorConverter: const JsonConverter(),
      interceptors: [
        if (kDebugMode)
          PrettyChopperLogger(
            level: Level.body,
          ),
        if (kDebugMode) getAliceChopperAdapter(),
      ],
    ).client;
    final apiService = ApiServiceFactory.create(client: client);
    final remoteSource = RemoteSourceFactory.create(apiService);

    return RepositoryFactory.createStationRepository(
      localSource: localSource,
      remoteSource: remoteSource,
    );
  }

  static Future<AppStateRepository> getAppStateRepository() async {
    final isar = await IsarFactory().isar;
    final localSource = LocalSourceFactory.create(isar);
    return RepositoryFactory.createAppStateRepository(
      localSource: localSource,
    );
  }
}
