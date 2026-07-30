class TokenEntity {
  final String accessToken;
  final String? refreshToken;
  final String? companyId;
  final String? outletId;
  final String? outletName;
  final bool hasCompany;

  const TokenEntity({
    required this.accessToken,
    this.refreshToken,
    this.companyId,
    this.outletId,
    this.outletName,
    this.hasCompany = false,
  });
}
