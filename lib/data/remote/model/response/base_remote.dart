import 'package:json_annotation/json_annotation.dart';

part 'base_remote.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  createToJson: false,
)
class BaseRemote<T> {
  int? status;
  List<T>? data;

  BaseRemote({
    this.status,
    this.data,
  });

  factory BaseRemote.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseRemoteFromJson(json, fromJsonT);
}
