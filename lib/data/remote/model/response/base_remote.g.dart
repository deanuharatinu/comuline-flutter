// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_remote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseRemote<T> _$BaseRemoteFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseRemote<T>(
      status: (json['status'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)?.map(fromJsonT).toList(),
    );
