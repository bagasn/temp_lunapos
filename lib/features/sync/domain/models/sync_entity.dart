// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  SyncEntity copyWith({
    int? outletId,
    int? companyId,
    bool? outletSynced,
    bool? productSynced,
    bool? promoSynced,
  }) {
    return SyncEntity(
      outletId: outletId ?? this.outletId,
      companyId: companyId ?? this.companyId,
      outletSynced: outletSynced ?? this.outletSynced,
      productSynced: productSynced ?? this.productSynced,
      promoSynced: promoSynced ?? this.promoSynced,
    );
  }
}
