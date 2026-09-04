import 'package:json_annotation/json_annotation.dart';

part 'initial_data_promo_response.g.dart';

@JsonSerializable()
class InitialDataPromoResponse {
  final List<Promo> promos;
  final List<PromoExtension> promoExtensions;
  final List<PromoCombined> promoCombined;
  final List<PromoToOutletRel> promoToOutletRels;
  final List<PromoToPaymentMethodRel> promoToPaymentMethodRels;
  final List<PromoToSalesTypeRel> promoToSalesTypeRels;
  final List<PromoProductTerm> promoProductTerms;
  final List<PromoProductVariantTerm> promoProductVariantTerms;
  final List<PromoProductReward> promoProductRewards;
  final List<PromoProductVariantReward> promoProductVariantRewards;

  InitialDataPromoResponse({
    required this.promos,
    required this.promoExtensions,
    required this.promoCombined,
    required this.promoToOutletRels,
    required this.promoToPaymentMethodRels,
    required this.promoToSalesTypeRels,
    required this.promoProductTerms,
    required this.promoProductVariantTerms,
    required this.promoProductRewards,
    required this.promoProductVariantRewards,
  });

  factory InitialDataPromoResponse.fromJson(Map<String, dynamic> json) =>
      _$InitialDataPromoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InitialDataPromoResponseToJson(this);
}

@JsonSerializable()
class Promo {
  final String id;
  final int tenantId;
  final String name;
  final int type;
  final bool appliesMultiple;
  final bool promoActivate;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String startDateTime;
  final String endDateTime;
  final String startDateString;
  final String endDateString;
  final bool useTimespan;
  final bool isFullDay;
  final bool monday;
  final bool tuesday;
  final bool wednesday;
  final bool thursday;
  final bool friday;
  final bool saturday;
  final bool sunday;
  final bool allOutlets;
  final bool allSalesType;
  final bool allPayment;
  final bool canBeCombined;
  final bool allPromoCombined;
  final int inactive;

  Promo({
    required this.id,
    required this.tenantId,
    required this.name,
    required this.type,
    required this.appliesMultiple,
    required this.promoActivate,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.startDateTime,
    required this.endDateTime,
    required this.startDateString,
    required this.endDateString,
    required this.useTimespan,
    required this.isFullDay,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
    required this.allOutlets,
    required this.allSalesType,
    required this.allPayment,
    required this.canBeCombined,
    required this.allPromoCombined,
    required this.inactive,
  });

  factory Promo.fromJson(Map<String, dynamic> json) => _$PromoFromJson(json);

  Map<String, dynamic> toJson() => _$PromoToJson(this);
}

@JsonSerializable()
class PromoExtension {
  final String id;
  final int tenantId;
  final String promoId;
  final int termType;
  final int rewardType;
  final double minimumPurchaseAmount;
  final double maxDiscountAmount;
  final int discountType;
  final double discountValue;
  final String operatorTerm;
  final String operatorReward;
  final int sortOrder;
  final int termVariantLength;
  final double discountPercentage;
  final double discountAmount;

  PromoExtension({
    required this.id,
    required this.tenantId,
    required this.promoId,
    required this.termType,
    required this.rewardType,
    required this.minimumPurchaseAmount,
    required this.maxDiscountAmount,
    required this.discountType,
    required this.discountValue,
    required this.operatorTerm,
    required this.operatorReward,
    required this.sortOrder,
    required this.termVariantLength,
    required this.discountPercentage,
    required this.discountAmount,
  });

  factory PromoExtension.fromJson(Map<String, dynamic> json) =>
      _$PromoExtensionFromJson(json);

  Map<String, dynamic> toJson() => _$PromoExtensionToJson(this);
}

@JsonSerializable()
class PromoCombined {
  final String id;
  final int tenantId;
  final String promoId;
  final String promoCombinedId;
  final int sortOrder;

  PromoCombined({
    required this.id,
    required this.tenantId,
    required this.promoId,
    required this.promoCombinedId,
    required this.sortOrder,
  });

  factory PromoCombined.fromJson(Map<String, dynamic> json) =>
      _$PromoCombinedFromJson(json);

  Map<String, dynamic> toJson() => _$PromoCombinedToJson(this);
}

@JsonSerializable()
class PromoToOutletRel {
  final String id;
  final int tenantId;
  final String promoId;
  final int outletId;
  final int sortOrder;

  PromoToOutletRel({
    required this.id,
    required this.tenantId,
    required this.promoId,
    required this.outletId,
    required this.sortOrder,
  });

  factory PromoToOutletRel.fromJson(Map<String, dynamic> json) =>
      _$PromoToOutletRelFromJson(json);

  Map<String, dynamic> toJson() => _$PromoToOutletRelToJson(this);
}

@JsonSerializable()
class PromoToPaymentMethodRel {
  final String id;
  final int tenantId;
  final String promoId;
  final String paymentMethodId;
  final int sortOrder;

  PromoToPaymentMethodRel({
    required this.id,
    required this.tenantId,
    required this.promoId,
    required this.paymentMethodId,
    required this.sortOrder,
  });

  factory PromoToPaymentMethodRel.fromJson(Map<String, dynamic> json) =>
      _$PromoToPaymentMethodRelFromJson(json);

  Map<String, dynamic> toJson() => _$PromoToPaymentMethodRelToJson(this);
}

@JsonSerializable()
class PromoToSalesTypeRel {
  final String id;
  final int tenantId;
  final String promoId;
  final String salesTypeId;
  final int sortOrder;

  PromoToSalesTypeRel({
    required this.id,
    required this.tenantId,
    required this.promoId,
    required this.salesTypeId,
    required this.sortOrder,
  });

  factory PromoToSalesTypeRel.fromJson(Map<String, dynamic> json) =>
      _$PromoToSalesTypeRelFromJson(json);

  Map<String, dynamic> toJson() => _$PromoToSalesTypeRelToJson(this);
}

@JsonSerializable()
class PromoProductTerm {
  final String id;
  final int tenantId;
  final String promoId;
  final String promoItemId;
  final String productId;
  final String categoryProductId;
  final int sortOrder;
  final bool allVariants;

  PromoProductTerm({
    required this.id,
    required this.tenantId,
    required this.promoId,
    required this.promoItemId,
    required this.productId,
    required this.categoryProductId,
    required this.sortOrder,
    required this.allVariants,
  });

  factory PromoProductTerm.fromJson(Map<String, dynamic> json) =>
      _$PromoProductTermFromJson(json);

  Map<String, dynamic> toJson() => _$PromoProductTermToJson(this);
}

@JsonSerializable()
class PromoProductVariantTerm {
  final String id;
  final int tenantId;
  final String promoId;
  final String promoProductTermId;
  final String productId;
  final String productVariantId;
  final int qty;
  final int sortOrder;
  final bool allVariants;

  PromoProductVariantTerm({
    required this.id,
    required this.tenantId,
    required this.promoId,
    required this.promoProductTermId,
    required this.productId,
    required this.productVariantId,
    required this.qty,
    required this.sortOrder,
    required this.allVariants,
  });

  factory PromoProductVariantTerm.fromJson(Map<String, dynamic> json) =>
      _$PromoProductVariantTermFromJson(json);

  Map<String, dynamic> toJson() => _$PromoProductVariantTermToJson(this);
}

@JsonSerializable()
class PromoProductReward {
  final String id;
  final int tenantId;
  final String promoId;
  final String promoItemId;
  final String productId;
  final int sortOrder;
  final bool allVariants;

  PromoProductReward({
    required this.id,
    required this.tenantId,
    required this.promoId,
    required this.promoItemId,
    required this.productId,
    required this.sortOrder,
    required this.allVariants,
  });

  factory PromoProductReward.fromJson(Map<String, dynamic> json) =>
      _$PromoProductRewardFromJson(json);

  Map<String, dynamic> toJson() => _$PromoProductRewardToJson(this);
}

@JsonSerializable()
class PromoProductVariantReward {
  final String id;
  final int tenantId;
  final String promoId;
  final String promoProductRewardId;
  final String productId;
  final String productVariantId;
  final int qty;
  final int sortOrder;
  final bool allVariants;

  PromoProductVariantReward({
    required this.id,
    required this.tenantId,
    required this.promoId,
    required this.promoProductRewardId,
    required this.productId,
    required this.productVariantId,
    required this.qty,
    required this.sortOrder,
    required this.allVariants,
  });

  factory PromoProductVariantReward.fromJson(Map<String, dynamic> json) =>
      _$PromoProductVariantRewardFromJson(json);

  Map<String, dynamic> toJson() => _$PromoProductVariantRewardToJson(this);
}
