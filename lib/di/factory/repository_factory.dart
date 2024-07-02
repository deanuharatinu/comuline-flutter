import 'package:comuline/data/local/local_source.dart';
import 'package:comuline/data/remote/api_service.dart';
import 'package:comuline/data/remote/remote_source.dart';
import 'package:comuline/data/repository/app_state_repository.dart';
import 'package:comuline/data/repository/station_repository.dart';
import 'package:isar/isar.dart';

class RepositoryFactory {
  static StationRepository createStationRepository({
    required RemoteSource remoteSource,
    required LocalSource localSource,
  }) {
    return StationRepository(
      localSource: localSource,
      remoteSource: remoteSource,
    );
  }

  static AppStateRepository createAppStateRepository({
    required LocalSource localSource,
  }) {
    return AppStateRepository(localSource: localSource);
  }
}

class RemoteSourceFactory {
  RemoteSourceFactory._();

  static RemoteSource create(
    ApiService apiService,
  ) {
    return RemoteSource(apiService: apiService);
  }
}

class LocalSourceFactory {
  LocalSourceFactory._();

  static LocalSource create(Isar isar) {
    return LocalSource(databaseService: isar);
  }
}
