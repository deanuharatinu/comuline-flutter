import 'package:comuline/data/remote/api_service.dart';
import 'package:comuline/data/remote/remote_source.dart';
import 'package:comuline/data/repository/station_repository.dart';

class RepositoryFactory {
  static StationRepository createStationRepository({
    required RemoteSource remoteSource,
  }) {
    return StationRepository(remoteSource: remoteSource);
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
