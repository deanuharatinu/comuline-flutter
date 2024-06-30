import 'package:alice_chopper/alice_chopper_adapter.dart';
import 'package:chopper/chopper.dart';
import 'package:comuline/data/repository/station_repository.dart';
import 'package:comuline/di/factory/api_service_factory.dart';
import 'package:comuline/di/factory/chopper_factory.dart';
import 'package:comuline/di/factory/isar_factory.dart';
import 'package:comuline/di/factory/repository_factory.dart';
import 'package:pretty_chopper_logger/pretty_chopper_logger.dart';

class RepositoryInjector {
  RepositoryInjector._();

  static Future<StationRepository> injectStationRepository({
    required AliceChopperAdapter aliceChopperAdapter,
  }) async {
    final isar = await IsarFactory().isar;
    final localSource = LocalSourceFactory.create(isar);

    final client = ChopperFactory(
      converter: const JsonConverter(),
      errorConverter: const JsonConverter(),
      interceptors: [
        PrettyChopperLogger(
          level: Level.body,
        ),
        aliceChopperAdapter,
      ],
    ).client;
    final apiService = ApiServiceFactory.create(client: client);
    final remoteSource = RemoteSourceFactory.create(apiService);

    return StationRepository(
      localSource: localSource,
      remoteSource: remoteSource,
    );
  }
}
