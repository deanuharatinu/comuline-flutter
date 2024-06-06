import 'package:isar/isar.dart';

part 'station_local.g.dart';

@collection
class StationLocal {
  Id id = Isar.autoIncrement;
  String? stationId;
  String? name;
  int? daop;
  int? fgEnable;
  bool? haveSchedule;
  String? updatedAt;
}
