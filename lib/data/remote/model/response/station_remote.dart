import 'package:json_annotation/json_annotation.dart';

part 'station_remote.g.dart';

@JsonSerializable(createToJson: false)
class StationRemote {
  final String? id;
  final String? name;
  final int? daop;
  final int? fgEnable;
  final bool? haveSchedule;
  final String? updatedAt;

  StationRemote({
    this.id,
    this.name,
    this.daop,
    this.fgEnable,
    this.haveSchedule,
    this.updatedAt,
  });

  static const fromJson = _$StationRemoteFromJson;
}
