class AuthOutletEntity {
  final int outletId;
  final String outletName;
  final int companyId;
  final String companyName;
  final String posAuthKey;
  final String? outletPictureUrl;
  final String? subscriptionDueDate;

  const AuthOutletEntity({
    required this.outletId,
    required this.outletName,
    required this.companyId,
    required this.companyName,
    required this.posAuthKey,
    this.outletPictureUrl,
    this.subscriptionDueDate,
  });
}
