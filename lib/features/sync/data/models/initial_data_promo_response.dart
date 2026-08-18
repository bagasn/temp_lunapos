import 'package:json_annotation/json_annotation.dart';

part 'initial_data_promo_response.g.dart';

@JsonSerializable()
class InitialDataPromoResponse {
  @JsonKey(name: 'promos')
  final List<Promo>? promos;
  @JsonKey(name: 'promoExtensions')
  final List<PromoExtension>? promoExtensions;
  @JsonKey(name: 'promoCombined')
  final List<PromoCombined>? promoCombined;
  @JsonKey(name: 'promoToOutletRels')
  final List<PromoToOutletRel>? promoToOutletRels;
  @JsonKey(name: 'promoToPaymentMethodRels')
  final List<PromoToPaymentMethodRel>? promoToPaymentMethodRels;
  @JsonKey(name: 'promoToSalesTypeRels')
  final List<PromoToSalesTypeRel>? promoToSalesTypeRels;
  @JsonKey(name: 'promoProductTerms')
  final List<PromoProductTerm>? promoProductTerms;
  @JsonKey(name: 'promoProductVariantTerms')
  final List<PromoProductVariantTerm>? promoProductVariantTerms;
  @JsonKey(name: 'promoProductRewards')
  final List<PromoProductReward>? promoProductRewards;
  @JsonKey(name: 'promoProductVariantRewards')
  final List<PromoProductVariantReward>? promoProductVariantRewards;
  @JsonKey(name: 'serverTime')
  final String? serverTime;

  InitialDataPromoResponse({
    this.promos,
    this.promoExtensions,
    this.promoCombined,
    this.promoToOutletRels,
    this.promoToPaymentMethodRels,
    this.promoToSalesTypeRels,
    this.promoProductTerms,
    this.promoProductVariantTerms,
    this.promoProductRewards,
    this.promoProductVariantRewards,
    this.serverTime,
  });

  factory InitialDataPromoResponse.fromJson(Map<String, dynamic> json) =>
      _$InitialDataPromoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InitialDataPromoResponseToJson(this);
}

@JsonSerializable()
class Promo {
  final String? id;
  final num? tenantId;
  final String? name;
  final num? type;
  final bool? appliesMultiple;
  final bool? promoActivate;
  final String? startDate;
  final String? endDate;
  final String? startTime;
  final String? endTime;
  final String? startDateTime;
  final String? endDateTime;
  final String? startDateString;
  final String? endDateString;
  final bool? useTimespan;
  final bool? isFullDay;
  final bool? monday;
  final bool? tuesday;
  final bool? wednesday;
  final bool? thursday;
  final bool? friday;
  final bool? saturday;
  final bool? sunday;
  final bool? allOutlets;
  final bool? allSalesType;
  final bool? allPayment;
  final bool? canBeCombined;
  final bool? allPromoCombined;
  final num? inactive;

  Promo({
    this.id,
    this.tenantId,
    this.name,
    this.type,
    this.appliesMultiple,
    this.promoActivate,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.startDateTime,
    this.endDateTime,
    this.startDateString,
    this.endDateString,
    this.useTimespan,
    this.isFullDay,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
    this.allOutlets,
    this.allSalesType,
    this.allPayment,
    this.canBeCombined,
    this.allPromoCombined,
    this.inactive,
  });

  factory Promo.fromJson(Map<String, dynamic> json) => _$PromoFromJson(json);

  Map<String, dynamic> toJson() => _$PromoToJson(this);
}

@JsonSerializable()
class PromoExtension {
  final String? id;
  final num? tenantId;
  final String? promoId;
  final num? termType;
  final num? rewardType;
  final num? minimumPurchaseAmount;
  final num? maxDiscountAmount;
  final num? discountType;
  final num? discountValue;
  final String? operatorTerm;
  final String? operatorReward;
  final num? sortOrder;
  final num? termVariantLength;
  final num? discountPercentage;
  final num? discountAmount;

  PromoExtension({
    this.id,
    this.tenantId,
    this.promoId,
    this.termType,
    this.rewardType,
    this.minimumPurchaseAmount,
    this.maxDiscountAmount,
    this.discountType,
    this.discountValue,
    this.operatorTerm,
    this.operatorReward,
    this.sortOrder,
    this.termVariantLength,
    this.discountPercentage,
    this.discountAmount,
  });

  factory PromoExtension.fromJson(Map<String, dynamic> json) =>
      _$PromoExtensionFromJson(json);

  Map<String, dynamic> toJson() => _$PromoExtensionToJson(this);
}

@JsonSerializable()
class PromoCombined {
  final String? id;
  final num? tenantId;
  final String? promoId;
  final String? promoCombinedId;
  final num? sortOrder;

  PromoCombined({
    this.id,
    this.tenantId,
    this.promoId,
    this.promoCombinedId,
    this.sortOrder,
  });

  factory PromoCombined.fromJson(Map<String, dynamic> json) =>
      _$PromoCombinedFromJson(json);

  Map<String, dynamic> toJson() => _$PromoCombinedToJson(this);
}

@JsonSerializable()
class PromoToOutletRel {
  final String? id;
  final num? tenantId;
  final String? promoId;
  final num? outletId;
  final num? sortOrder;

  PromoToOutletRel({
    this.id,
    this.tenantId,
    this.promoId,
    this.outletId,
    this.sortOrder,
  });

  factory PromoToOutletRel.fromJson(Map<String, dynamic> json) =>
      _$PromoToOutletRelFromJson(json);

  Map<String, dynamic> toJson() => _$PromoToOutletRelToJson(this);
}

@JsonSerializable()
class PromoToPaymentMethodRel {
  final String? id;
  final num? tenantId;
  final String? promoId;
  final String? paymentMethodId;
  final num? sortOrder;

  PromoToPaymentMethodRel({
    this.id,
    this.tenantId,
    this.promoId,
    this.paymentMethodId,
    this.sortOrder,
  });

  factory PromoToPaymentMethodRel.fromJson(Map<String, dynamic> json) =>
      _$PromoToPaymentMethodRelFromJson(json);

  Map<String, dynamic> toJson() => _$PromoToPaymentMethodRelToJson(this);
}

@JsonSerializable()
class PromoToSalesTypeRel {
  final String? id;
  final num? tenantId;
  final String? promoId;
  final String? salesTypeId;
  final num? sortOrder;

  PromoToSalesTypeRel({
    this.id,
    this.tenantId,
    this.promoId,
    this.salesTypeId,
    this.sortOrder,
  });

  factory PromoToSalesTypeRel.fromJson(Map<String, dynamic> json) =>
      _$PromoToSalesTypeRelFromJson(json);

  Map<String, dynamic> toJson() => _$PromoToSalesTypeRelToJson(this);
}

@JsonSerializable()
class PromoProductTerm {
  final String? id;
  final num? tenantId;
  final String? promoId;
  final String? promoItemId;
  final String? productId;
  final String? categoryProductId;
  final num? sortOrder;
  final bool? allVariants;

  PromoProductTerm({
    this.id,
    this.tenantId,
    this.promoId,
    this.promoItemId,
    this.productId,
    this.categoryProductId,
    this.sortOrder,
    this.allVariants,
  });

  factory PromoProductTerm.fromJson(Map<String, dynamic> json) =>
      _$PromoProductTermFromJson(json);

  Map<String, dynamic> toJson() => _$PromoProductTermToJson(this);
}

@JsonSerializable()
class PromoProductVariantTerm {
  final String? id;
  final num? tenantId;
  final String? promoId;
  final String? promoProductTermId;
  final String? productId;
  final String? productVariantId;
  final num? qty;
  final num? sortOrder;
  final bool? allVariants;

  PromoProductVariantTerm({
    this.id,
    this.tenantId,
    this.promoId,
    this.promoProductTermId,
    this.productId,
    this.productVariantId,
    this.qty,
    this.sortOrder,
    this.allVariants,
  });

  factory PromoProductVariantTerm.fromJson(Map<String, dynamic> json) =>
      _$PromoProductVariantTermFromJson(json);

  Map<String, dynamic> toJson() => _$PromoProductVariantTermToJson(this);
}

@JsonSerializable()
class PromoProductReward {
  final String? id;
  final num? tenantId;
  final String? promoId;
  final String? promoItemId;
  final String? productId;
  final num? sortOrder;
  final bool? allVariants;

  PromoProductReward({
    this.id,
    this.tenantId,
    this.promoId,
    this.promoItemId,
    this.productId,
    this.sortOrder,
    this.allVariants,
  });

  factory PromoProductReward.fromJson(Map<String, dynamic> json) =>
      _$PromoProductRewardFromJson(json);

  Map<String, dynamic> toJson() => _$PromoProductRewardToJson(this);
}

@JsonSerializable()
class PromoProductVariantReward {
  final String? id;
  final num? tenantId;
  final String? promoId;
  final String? promoProductRewardId;
  final String? productId;
  final String? productVariantId;
  final num? qty;
  final num? sortOrder;
  final bool? allVariants;

  PromoProductVariantReward({
    this.id,
    this.tenantId,
    this.promoId,
    this.promoProductRewardId,
    this.productId,
    this.productVariantId,
    this.qty,
    this.sortOrder,
    this.allVariants,
  });

  factory PromoProductVariantReward.fromJson(Map<String, dynamic> json) =>
      _$PromoProductVariantRewardFromJson(json);

  Map<String, dynamic> toJson() => _$PromoProductVariantRewardToJson(this);
}
