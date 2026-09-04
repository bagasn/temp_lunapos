import 'package:json_annotation/json_annotation.dart';

part 'initial_data_product_response.g.dart';

@JsonSerializable()
class InitialDataProductResponse {
  final List<Product> products;
  final List<Variant> variants;
  final List<Category> categories;
  final List<ProductToCategory> productToCategories;
  final List<ProductToUser> productToUsers;
  final List<Modifier> modifiers;
  final List<ModifierItem> modifierItems;
  final List<ProductToModifier> productToModifiers;
  final List<PriceList> priceList;
  final List<PriceLevelItem> priceLevelItems;
  final List<PriceLevel> priceLevels;
  final List<Employee> employees;
  final List<CommisionProductToEmployeeRel> commisionProductToEmployeeRels;
  final List<ProductTieredPrice> productTieredPrices;

  InitialDataProductResponse({
    required this.products,
    required this.variants,
    required this.categories,
    required this.productToCategories,
    required this.productToUsers,
    required this.modifiers,
    required this.modifierItems,
    required this.productToModifiers,
    required this.priceList,
    required this.priceLevelItems,
    required this.priceLevels,
    required this.employees,
    required this.commisionProductToEmployeeRels,
    required this.productTieredPrices,
  });

  factory InitialDataProductResponse.fromJson(Map<String, dynamic> json) =>
      _$InitialDataProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InitialDataProductResponseToJson(this);
}

@JsonSerializable()
class Product {
  final String id;
  final String sku;
  final String name;
  final String detailDescription;
  final bool serviceCharged;
  final String salesTaxId;
  final double unitPrice;
  final String uom;
  final int modifierCount;
  final bool hasVariants;
  final bool availableForAllPosUsers;
  final int variantCount;
  final String? variantAttribute1; // null when hasVariants = false
  final String? variantAttribute2; // null when only 1 variant attribute
  final String? variantAttribute3; // null when less than 3 variant attributes
  final String masterVariantId;
  final String? pictureUrl; // null when product has no photo
  final bool deleted;
  final bool isDiscountDisabled;
  final ProductDimension dimension;

  Product({
    required this.id,
    required this.sku,
    required this.name,
    required this.detailDescription,
    required this.serviceCharged,
    required this.salesTaxId,
    required this.unitPrice,
    required this.uom,
    required this.modifierCount,
    required this.hasVariants,
    required this.availableForAllPosUsers,
    required this.variantCount,
    this.variantAttribute1,
    this.variantAttribute2,
    this.variantAttribute3,
    required this.masterVariantId,
    this.pictureUrl,
    required this.deleted,
    required this.isDiscountDisabled,
    required this.dimension,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class ProductDimension {
  final num? weight; // null or 0 in real data
  final num? height; // null or 0 in real data
  final num? width; // null or 0 in real data
  final num? length; // null or 0 in real data
  final num? sizeUom; // null or 0 in real data
  final num? weightUom; // null or 0 in real data

  ProductDimension({
    this.weight,
    this.height,
    this.width,
    this.length,
    this.sizeUom,
    this.weightUom,
  });

  factory ProductDimension.fromJson(Map<String, dynamic> json) =>
      _$ProductDimensionFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDimensionToJson(this);
}

@JsonSerializable()
class Variant {
  final String id;
  final String productId;
  final String sku;
  final String name;
  final String? variantName; // null when product has no variants
  final String? attribute1Value; // null when product has no variants
  final String? attribute2Value; // null when only 1 variant attribute
  final String? attribute3Value; // null when less than 3 variant attributes
  final double unitPrice;
  final int sortOrder;
  final bool isMaster;
  final bool deleted;

  Variant({
    required this.id,
    required this.productId,
    required this.sku,
    required this.name,
    this.variantName,
    this.attribute1Value,
    this.attribute2Value,
    this.attribute3Value,
    required this.unitPrice,
    required this.sortOrder,
    required this.isMaster,
    required this.deleted,
  });

  factory Variant.fromJson(Map<String, dynamic> json) =>
      _$VariantFromJson(json);

  Map<String, dynamic> toJson() => _$VariantToJson(this);
}

@JsonSerializable()
class Category {
  final String id;
  final String name;
  final int sortOrder;
  final bool deleted;
  final bool isCustom;
  final String? startDate; // null when no schedule restriction
  final String? startTime; // null when no schedule restriction
  final String? endDate; // null when no schedule restriction
  final String? endTime; // null when no schedule restriction
  final bool monday;
  final bool tuesday;
  final bool wednesday;
  final bool thursday;
  final bool friday;
  final bool saturday;
  final bool sunday;

  Category({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.deleted,
    required this.isCustom,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class ProductToCategory {
  final String productId;
  final String categoryId;
  final bool deleted;

  ProductToCategory({
    required this.productId,
    required this.categoryId,
    required this.deleted,
  });

  factory ProductToCategory.fromJson(Map<String, dynamic> json) =>
      _$ProductToCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToCategoryToJson(this);
}

@JsonSerializable()
class ProductToUser {
  final String productId;
  final String userId;

  ProductToUser({required this.productId, required this.userId});

  factory ProductToUser.fromJson(Map<String, dynamic> json) =>
      _$ProductToUserFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToUserToJson(this);
}

@JsonSerializable()
class Modifier {
  final String id;
  final String name;
  final bool required;
  final bool allowMultiple;
  final num? maximumAllowed; // null in real data
  final bool haveMaximumItemAllowed;
  final num? maximumItemAllowed; // null in real data
  final bool deleted;

  Modifier({
    required this.id,
    required this.name,
    required this.required,
    required this.allowMultiple,
    this.maximumAllowed,
    required this.haveMaximumItemAllowed,
    this.maximumItemAllowed,
    required this.deleted,
  });

  factory Modifier.fromJson(Map<String, dynamic> json) =>
      _$ModifierFromJson(json);

  Map<String, dynamic> toJson() => _$ModifierToJson(this);
}

@JsonSerializable()
class ModifierItem {
  final String id;
  final String modifierId;
  final String name;
  final String? productId; // null when useCustomPrice = true
  final String? productVariantId; // null when useCustomPrice = true
  final bool useCustomPrice;
  final double? price; // null when useCustomPrice = false (uses product price)
  final int sortOrder;

  ModifierItem({
    required this.id,
    required this.modifierId,
    required this.name,
    this.productId,
    this.productVariantId,
    required this.useCustomPrice,
    this.price,
    required this.sortOrder,
  });

  factory ModifierItem.fromJson(Map<String, dynamic> json) =>
      _$ModifierItemFromJson(json);

  Map<String, dynamic> toJson() => _$ModifierItemToJson(this);
}

@JsonSerializable()
class ProductToModifier {
  final String productId;
  final String modifierId;
  final int sortOrder;
  final bool deleted;

  ProductToModifier({
    required this.productId,
    required this.modifierId,
    required this.sortOrder,
    required this.deleted,
  });

  factory ProductToModifier.fromJson(Map<String, dynamic> json) =>
      _$ProductToModifierFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToModifierToJson(this);
}

@JsonSerializable()
class PriceList {
  final String productId;
  final String productVariantId;
  final String salesTypeId;
  final String salesTypeName;
  final double price;
  final bool isMaster;
  final bool deleted;

  PriceList({
    required this.productId,
    required this.productVariantId,
    required this.salesTypeId,
    required this.salesTypeName,
    required this.price,
    required this.isMaster,
    required this.deleted,
  });

  factory PriceList.fromJson(Map<String, dynamic> json) =>
      _$PriceListFromJson(json);

  Map<String, dynamic> toJson() => _$PriceListToJson(this);
}

@JsonSerializable()
class PriceLevelItem {
  final String productId;
  final String productVariantId;
  final String priceLevelId;
  final String priceLevelName;
  final double price;
  final bool isMaster;
  final bool deleted;

  PriceLevelItem({
    required this.productId,
    required this.productVariantId,
    required this.priceLevelId,
    required this.priceLevelName,
    required this.price,
    required this.isMaster,
    required this.deleted,
  });

  factory PriceLevelItem.fromJson(Map<String, dynamic> json) =>
      _$PriceLevelItemFromJson(json);

  Map<String, dynamic> toJson() => _$PriceLevelItemToJson(this);
}

@JsonSerializable()
class PriceLevel {
  final String id;
  final String name;
  final int systemType;
  final bool inactive;
  final bool isMaster;

  PriceLevel({
    required this.id,
    required this.name,
    required this.systemType,
    required this.inactive,
    required this.isMaster,
  });

  factory PriceLevel.fromJson(Map<String, dynamic> json) =>
      _$PriceLevelFromJson(json);

  Map<String, dynamic> toJson() => _$PriceLevelToJson(this);
}

@JsonSerializable()
class Employee {
  final String employeeId;
  final String employeeName;

  Employee({required this.employeeId, required this.employeeName});

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}

@JsonSerializable()
class CommisionProductToEmployeeRel {
  final String employeeId;
  final String productId;

  CommisionProductToEmployeeRel({
    required this.employeeId,
    required this.productId,
  });

  factory CommisionProductToEmployeeRel.fromJson(Map<String, dynamic> json) =>
      _$CommisionProductToEmployeeRelFromJson(json);

  Map<String, dynamic> toJson() => _$CommisionProductToEmployeeRelToJson(this);
}

@JsonSerializable()
class ProductTieredPrice {
  final String id;
  final String productId;
  final String name;
  final num minimumQty;
  final double price;
  final int sortOrder;

  ProductTieredPrice({
    required this.id,
    required this.productId,
    required this.name,
    required this.minimumQty,
    required this.price,
    required this.sortOrder,
  });

  factory ProductTieredPrice.fromJson(Map<String, dynamic> json) =>
      _$ProductTieredPriceFromJson(json);

  Map<String, dynamic> toJson() => _$ProductTieredPriceToJson(this);
}
