class TokenEntity {
  final String accessToken;
  final String refreshToken;
  final String? outletId;
  final String? outletName;
  final String? companyId;
  final String? companyName;
  final bool hasCompany;

  const TokenEntity({
    required this.accessToken,
    required this.refreshToken,
    this.outletId,
    this.outletName,
    this.companyId,
    this.companyName,
    this.hasCompany = false,
  });
}
