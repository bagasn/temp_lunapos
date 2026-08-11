import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';

@JsonSerializable()
class TokenResponse {
  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  @JsonKey(name: 'have_lunaone', toJson: _boolToString, fromJson: _stringToBool)
  final bool haveLunaone;

  @JsonKey(name: 'token_lunaone')
  final String? tokenLunaone;

  @JsonKey(name: 'refresh_token_lunaone')
  final String? refreshTokenLunaone;

  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'user_name')
  final String username;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'company_id')
  final String? companyId;

  @JsonKey(name: 'company_name')
  final String? companyName;

  @JsonKey(name: 'country_id')
  final String? countryId;

  @JsonKey(name: 'master_outlet_id')
  final String? masterOutletId;

  @JsonKey(name: 'user_outlet_id')
  final String? userOutletId;

  TokenResponse(
    this.accessToken,
    this.refreshToken,
    this.haveLunaone,
    this.tokenLunaone,
    this.refreshTokenLunaone,
    this.userId,
    this.username,
    this.email,
    this.companyId,
    this.companyName,
    this.countryId,
    this.masterOutletId,
    this.userOutletId,
  );

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);

  static bool _stringToBool(String value) {
    return value == 'true' || value == '1';
  }

  static String _boolToString(bool value) {
    return value.toString();
  }
}
