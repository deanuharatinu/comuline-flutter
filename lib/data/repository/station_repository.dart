import 'package:comuline/data/local/local_source.dart';
import 'package:comuline/data/remote/remote_source.dart';
import 'package:comuline/models/destination_detail.dart';
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

  Future<Result<List<DestinationDetail>>> getStationDetailById(
    String stationId,
  ) async {
    final result = await _remoteSource.getStationDetailById(stationId);
    final Map<String, List<StationDetail>> groupedDestination = {};

    if (result is Success<List<StationDetail>>) {
      for (var stationDetail in result.value) {
        // Group by destination & color
        final key = '${stationDetail.destination} ${stationDetail.color}';
        if (!groupedDestination.containsKey(key)) {
          groupedDestination[key] = [];
        }

        groupedDestination[key]!.add(stationDetail);
      }

      final destinationDetailList = <DestinationDetail>[];
      groupedDestination.forEach((key, value) {
        final destinationDetail = DestinationDetail(
          destination: value.first.destination,
          color: value.first.color,
          timeEstimated: value.map((detail) => detail.destinationTime).toList(),
        );
        destinationDetailList.add(destinationDetail);
      });

      return Success(destinationDetailList);
    } else {
      return Error(
        value: [],
        exception: (result as Error).exception,
      );
    }
  }
}
