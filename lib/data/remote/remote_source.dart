import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:comuline/component_library/extensions/value_utils.dart';
import 'package:comuline/data/remote/api_service.dart';
import 'package:comuline/data/remote/model/response/base_remote.dart';
import 'package:comuline/data/remote/model/response/station_detail_remote.dart';
import 'package:comuline/data/remote/model/response/station_remote.dart';
import 'package:comuline/models/result.dart';
import 'package:comuline/models/exceptions.dart';
import 'package:comuline/models/station.dart';
import 'package:comuline/models/station_detail.dart';

class RemoteSource {
  RemoteSource({
    required apiService,
  }) : _apiService = apiService;

  final ApiService _apiService;

  Future<Result<OUT>> fetchData<OUT>({
    required Future<Response<dynamic>> Function() serviceToRun,
  }) async {
    try {
      final response = await serviceToRun.call();

      if (response.isSuccessful) {
        final jsonObject = json.decode(response.bodyString);
        return Success<OUT>(jsonObject);
      } else {
        if (response.statusCode == 404) {
          return Error<OUT>(exception: NotFoundException());
        }

        // Client error
        if (response.statusCode >= 400 && response.statusCode < 500) {
          return Error<OUT>(exception: ClientException());
        }

        // Server error
        if (response.statusCode >= 400 && response.statusCode < 500) {
          return Error<OUT>(exception: ServerException());
        }

        return Error<OUT>(exception: UnknownException());
      }
    } on Exception catch (e) {
      if (e is SocketException) {
        return Error<OUT>(
          exception: NoConnectionException(),
        );
      }

      // unknown error or json parsing error
      return Error<OUT>(
        exception: e,
      );
    }
  }

  Future<Result<List<Station>>> getStations() async {
    final response = await fetchData<Map<String, dynamic>>(
      serviceToRun: () => _apiService.getStations(),
    );

    if (response is Error) {
      return Error(
        value: [],
        exception: (response as Error<dynamic>).exception,
      );
    }

    if (response is Success<Map<String, dynamic>>) {
      final jsonObject = response.value;
      final baseRemote = BaseRemote<StationRemote>.fromJson(
        jsonObject,
        (json) => StationRemote.fromJson(json as Map<String, dynamic>),
      );
      final stationRemoteList = baseRemote.data ?? [];

      final data = stationRemoteList
          .map((stationRemote) => Station(
                id: stationRemote.id.orEmpty,
                name: stationRemote.name.orEmpty,
                daop: stationRemote.daop.orInt(0),
                fgEnable: stationRemote.fgEnable.orInt(0),
                haveSchedule: stationRemote.haveSchedule.orBool(false),
                updatedAt: stationRemote.updatedAt.orEmpty,
              ))
          .toList();

      return Success(data);
    }

    return Success([]);
  }

  Future<Result<List<StationDetail>>> getStationDetailById(
    String stationId,
  ) async {
    final response = await fetchData<Map<String, dynamic>>(
      serviceToRun: () => _apiService.getStationDetailById(stationId),
    );

    if (response is Error) {
      return Error(
        value: [],
        exception: (response as Error<dynamic>).exception,
      );
    }

    if (response is Success<Map<String, dynamic>>) {
      final jsonObject = response.value;
      final baseRemote = BaseRemote<StationDetailRemote>.fromJson(
        jsonObject,
        (json) => StationDetailRemote.fromJson(json as Map<String, dynamic>),
      );
      final stationDetailRemoteList = baseRemote.data ?? [];

      final data = stationDetailRemoteList
          .map(
            (stationDetailRemote) => StationDetail(
              id: stationDetailRemote.id.orEmpty,
              stationId: stationDetailRemote.stationId.orEmpty,
              trainId: stationDetailRemote.trainId.orEmpty,
              line: stationDetailRemote.line.orEmpty,
              route: stationDetailRemote.route.orEmpty,
              color: stationDetailRemote.color.orEmpty,
              destination: stationDetailRemote.destination.orEmpty,
              timeEstimated: stationDetailRemote.timeEstimated.orEmpty,
              destinationTime: stationDetailRemote.destinationTime.orEmpty,
              updatedAt: stationDetailRemote.updatedAt.orEmpty,
            ),
          )
          .toList();

      return Success(data);
    }

    return Success([]);
  }
}
