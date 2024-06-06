// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_remote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationRemote _$StationRemoteFromJson(Map<String, dynamic> json) =>
    StationRemote(
      id: json['id'] as String?,
      name: json['name'] as String?,
      daop: (json['daop'] as num?)?.toInt(),
      fgEnable: (json['fgEnable'] as num?)?.toInt(),
      haveSchedule: json['haveSchedule'] as bool?,
      updatedAt: json['updatedAt'] as String?,
    );
