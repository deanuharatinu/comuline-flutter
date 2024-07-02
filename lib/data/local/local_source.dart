import 'package:comuline/component_library/extensions/value_utils.dart';
import 'package:comuline/component_library/theme/dark_mode_preference.dart';
import 'package:comuline/data/local/model/app_state_local.dart';
import 'package:comuline/data/local/model/station_local.dart';
import 'package:comuline/models/station.dart';
import 'package:isar/isar.dart';

class LocalSource {
  LocalSource({
    required Isar databaseService,
  }) : _dbService = databaseService;

  final Isar _dbService;

  Future<List<Station>> getStations() async {
    var stationsLocalList = await _dbService.stationLocals
        .where()
        .isBookmarkedEqualTo(true)
        .sortById()
        .findAll();

    if (stationsLocalList.isEmpty) {
      final defaultStation =
          await _dbService.stationLocals.where().sortById().findFirst();
      stationsLocalList = [if (defaultStation != null) defaultStation];
    }

    return stationsLocalList.map((stationLocal) {
      return Station(
        id: stationLocal.id.orEmpty,
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
        ..id = station.id
        ..daop = station.daop
        ..fgEnable = station.fgEnable
        ..haveSchedule = station.haveSchedule
        ..name = station.name
        ..updatedAt = station.updatedAt;
    }).toList();

    await _dbService.writeTxn(() async {
      return await _dbService.stationLocals.putAll(stationLocalList);
    });

    return true;
  }

  Future<void> upsertDarkModePreference(
      DarkModePreference darkModePreference) async {
    var appState = await _dbService.appStateLocals.where().findFirst();
    if (appState != null) {
      appState.darkModePreference = darkModePreference;
    } else {
      appState = AppStateLocal()..darkModePreference = darkModePreference;
    }

    await _dbService.writeTxn(() async {
      return await _dbService.appStateLocals.put(appState!);
    });
  }

  Future<DarkModePreference> getDarkModePreference() async {
    final appStateLocal = await _dbService.appStateLocals.where().findFirst();
    if (appStateLocal == null) {
      return DarkModePreference.alwaysLight;
    }

    return appStateLocal.darkModePreference;
  }
}
