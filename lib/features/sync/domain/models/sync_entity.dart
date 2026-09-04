class SyncEntity {
  final int outletId;
  final int companyId;

  final bool outletSynced;
  final bool productSynced;
  final bool promoSynced;

  SyncEntity({
    required this.outletId,
    required this.companyId,
    required this.outletSynced,
    required this.productSynced,
    required this.promoSynced,
  });

  bool isSameOutlet(SyncEntity other) {
    return (companyId == other.companyId && outletId == other.outletId);
  }
}
