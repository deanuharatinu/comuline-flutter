import 'package:comuline/data/local/local_source.dart';
import 'package:comuline/data/remote/remote_source.dart';
import 'package:comuline/models/result.dart';
import 'package:comuline/models/station.dart';
import 'package:comuline/models/station_detail.dart';

class StationRepository {
  StationRepository({
    required localSource,
    required remoteSource,
  })  : _remoteSource = remoteSource,
        _localSource = localSource;

  final RemoteSource _remoteSource;
  final LocalSource _localSource;

  Stream<Result<List<Station>>> getStations() async* {
    // Get local data first
    var localData = await _localSource.getStations();
    if (localData.isNotEmpty) yield Success(localData);

    // Fetch remote data
    final remoteData = await _remoteSource.getStations();

    // If remote fetch success, save to local
    if (remoteData is Success<List<Station>>) {
      final value = remoteData.value;
      await _localSource.upsertStations(value);
    }

    // keep single source of truth: the local cache
    localData = await _localSource.getStations();

    // propagate error if any
    if (remoteData is Error<dynamic>) {
      final exception = (remoteData as Error<dynamic>).exception;
      yield Error(value: localData, exception: exception);
    } else {
      yield Success(localData);
    }
  }

  Future<Result<List<StationDetail>>> getStationDetailById(
    String stationId,
  ) async {
    return await _remoteSource.getStationDetailById(stationId);
  }
}
