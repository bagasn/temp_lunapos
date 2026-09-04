import 'package:json_annotation/json_annotation.dart';

part 'sync_payload.g.dart';

@JsonSerializable()
class SyncPayload {
  String appVersion;
  String? serverTime;

  SyncPayload({this.appVersion = '1', this.serverTime});

  factory SyncPayload.fromJson(Map<String, dynamic> json) =>
      _$SyncPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$SyncPayloadToJson(this);
}
