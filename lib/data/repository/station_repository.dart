import 'package:comuline/data/remote/remote_source.dart';
import 'package:comuline/data/remote/result.dart';
import 'package:comuline/models/station.dart';

class StationRepository {
  StationRepository({
    required remoteSource,
  }) : _remoteSource = remoteSource;

  final RemoteSource _remoteSource;

  Stream<Result<List<Station>>> getStations() async* {
    final stations = await _remoteSource.getStations();
    yield stations;
  }
}
