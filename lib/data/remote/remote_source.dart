import 'dart:convert';
import 'dart:io';

import 'package:comuline/component_library/extensions/value_utils.dart';
import 'package:comuline/data/remote/api_service.dart';
import 'package:comuline/data/remote/model/response/base_remote.dart';
import 'package:comuline/data/remote/model/response/station_remote.dart';
import 'package:comuline/data/remote/result.dart';
import 'package:comuline/models/exceptions.dart';
import 'package:comuline/models/station.dart';

class RemoteSource {
  RemoteSource({
    required apiService,
  }) : _apiService = apiService;

  final ApiService _apiService;

  Future<Result<List<Station>>> getStations() async {
    try {
      final response = await _apiService.getStations();
      final jsonObject = json.decode(response.bodyString);

      final baseRemote = BaseRemote<StationRemote>.fromJson(
        jsonObject,
        (json) => StationRemote.fromJson(json as Map<String, dynamic>),
      );

      final stationRemoteList = baseRemote.data ?? [];

      if (response.isSuccessful) {
        final data = stationRemoteList
            .map(
              (stationRemote) => Station(
                id: stationRemote.id.orEmpty,
                name: stationRemote.name.orEmpty,
                daop: stationRemote.daop.orInt(0),
                fgEnable: stationRemote.fgEnable.orInt(0),
                haveSchedule: stationRemote.haveSchedule.orBool(false),
                updatedAt: stationRemote.updatedAt.orEmpty,
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
