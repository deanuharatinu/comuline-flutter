import 'package:comuline/component_library/extensions/value_utils.dart';
import 'package:isar/isar.dart';

part 'station_local.g.dart';

@collection
class StationLocal {
  String? id;
  Id get isarId => id!.fastHash;
  String? name;
  int? daop;
  int? fgEnable;
  bool? haveSchedule;
  String? updatedAt;
  @Index()
  bool? isBookmarked;
}
