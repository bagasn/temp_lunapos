import 'package:json_annotation/json_annotation.dart';

part 'token_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TokenResponseModel {
  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'refresh_token')
  final String? refreshToken;

  @JsonKey(name: 'company_id')
  final String? companyId;

  @JsonKey(name: 'company_name')
  final String? companyName;

  @JsonKey(name: 'outlet_id')
  final String? outletId;

  @JsonKey(name: 'outlet_name')
  final String? outletName;

  @JsonKey(name: 'outlet_role')
  final String? outletRole;

  @JsonKey(name: 'token_lunaone')
  final String? tokenLunaone;

  @JsonKey(name: 'refresh_token_lunaone')
  final String? refreshTokenLunaone;

  const TokenResponseModel({
    required this.accessToken,
    this.refreshToken,
    this.companyId,
    this.companyName,
    this.outletId,
    this.outletName,
    this.outletRole,
    this.tokenLunaone,
    this.refreshTokenLunaone,
  });

  factory TokenResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseModelToJson(this);

  bool get hasCompany => companyId != null && companyId!.isNotEmpty;
}
