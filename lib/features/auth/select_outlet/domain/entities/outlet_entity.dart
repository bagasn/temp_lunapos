class OutletEntity {
  final String outletId;
  final String outletName;
  final String companyName;
  final String posAuthKey;
  final String? outletPictureUrl;
  final String? subscriptionDueDate;

  const OutletEntity({
    required this.outletId,
    required this.outletName,
    required this.companyName,
    required this.posAuthKey,
    this.outletPictureUrl,
    this.subscriptionDueDate,
  });
}
