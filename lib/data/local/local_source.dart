import 'package:comuline/component_library/extensions/value_utils.dart';
import 'package:comuline/data/local/model/station_local.dart';
import 'package:comuline/models/station.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class LocalSource {
  LocalSource({
    required Isar databaseService,
  }) : _dbService = databaseService;

  final Isar _dbService;

  Future<List<Station>> getStations() async {
    final stationsLocalList = await _dbService.stationLocals.where().findAll();

    return stationsLocalList.map((stationLocal) {
      return Station(
        id: stationLocal.stationId.orEmpty,
        name: stationLocal.name.orEmpty,
        daop: stationLocal.daop.orInt(0),
        fgEnable: stationLocal.fgEnable.orInt(0),
        haveSchedule: stationLocal.haveSchedule.orBool(false),
        updatedAt: stationLocal.updatedAt.orEmpty,
      );
    }).toList();
  }

  Future<bool> upsertStations(List<Station> stations) async {
    final stationLocalList = stations.map((station) {
      return StationLocal()
        ..stationId = station.id
        ..daop = station.daop
        ..fgEnable = station.fgEnable
        ..haveSchedule = station.haveSchedule
        ..name = station.name
        ..updatedAt = station.updatedAt;
    }).toList();

    final result = await _dbService.writeTxn(() async {
      return await _dbService.stationLocals.putAll(stationLocalList);
    });

    debugPrint(result.length.toString());

    return true;
  }
}
