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

  Future<Result<List<Station>>> getStations() async {
    try {
      final response = await _apiService.getStations();

      // Expecting response data in list of stations
      return parseResponseList(
        response: response,
        isSuccessful: response.isSuccessful,
        converter: () {
          final jsonObject = json.decode(response.bodyString);
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

          return Future.value(Success(data));
        },
      );
    } on Exception catch (e) {
      if (e is SocketException) {
        return Future.value(Error(
          value: [],
          exception: NoConnectionException(),
        ));
      }

      // unknown error or json parsing error
      return Future.value(Error(
        value: [],
        exception: e,
      ));
    }
  }

  Future<Result<List<OUT>>> parseResponseList<IN, OUT>({
    required Response<dynamic> response,
    required bool isSuccessful,
    required Future<Result<List<OUT>>> Function() converter,
  }) async {
    if (isSuccessful) {
      return converter();
    } else {
      if (response.statusCode == 404) {
        return Future.value(Error(value: [], exception: NotFoundException()));
      }

      // Client error
      if (response.statusCode >= 400 && response.statusCode < 500) {
        return Future.value(Error(value: [], exception: ClientException()));
      }

      // Server error
      if (response.statusCode >= 400 && response.statusCode < 500) {
        return Future.value(Error(value: [], exception: ServerException()));
      }

      return Future.value(Error(value: [], exception: UnknownException()));
    }
  }

  Future<Result<List<StationDetail>>> getStationDetailById(
    String stationId,
  ) async {
    try {
      final response = await _apiService.getStationDetailById(stationId);
      final jsonObject = json.decode(response.bodyString);

      final baseRemote = BaseRemote<StationDetailRemote>.fromJson(
        jsonObject,
        (json) => StationDetailRemote.fromJson(json as Map<String, dynamic>),
      );

      final stationDetailRemoteList = baseRemote.data ?? [];

      if (response.isSuccessful) {
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

        return Future.value(Success(data));
      } else {
        if (response.statusCode == 404) {
          return Future.value(Error(value: [], exception: NotFoundException()));
        }

        // Client error
        if (response.statusCode >= 400 && response.statusCode < 500) {
          return Future.value(Error(value: [], exception: ClientException()));
        }

        // Server error
        if (response.statusCode >= 400 && response.statusCode < 500) {
          return Future.value(Error(value: [], exception: ServerException()));
        }

        return Future.value(Error(value: [], exception: UnknownException()));
      }
    } on Exception catch (e) {
      if (e is SocketException) {
        return Future.value(Error(
          value: [],
          exception: NoConnectionException(),
        ));
      }

      // unknown error or json parsing error
      return Future.value(Error(
        value: [],
        exception: e,
      ));
    }
  }
}
