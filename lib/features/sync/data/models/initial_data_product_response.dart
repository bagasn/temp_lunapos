import 'package:json_annotation/json_annotation.dart';

part 'initial_data_product_response.g.dart';

@JsonSerializable()
class InitialDataProductResponse {
  @JsonKey(name: 'products')
  final List<Product>? products;
  @JsonKey(name: 'variants')
  final List<Variant>? variants;
  @JsonKey(name: 'categories')
  final List<Category>? categories;
  @JsonKey(name: 'productToCategories')
  final List<ProductToCategory>? productToCategories;
  @JsonKey(name: 'productToUsers')
  final List<ProductToUser>? productToUsers;
  @JsonKey(name: 'modifiers')
  final List<Modifier>? modifiers;
  @JsonKey(name: 'modifierItems')
  final List<ModifierItem>? modifierItems;
  @JsonKey(name: 'productToModifiers')
  final List<ProductToModifier>? productToModifiers;
  @JsonKey(name: 'priceList')
  final List<PriceList>? priceList;
  @JsonKey(name: 'priceLevelItems')
  final List<PriceLevelItem>? priceLevelItems;
  @JsonKey(name: 'priceLevels')
  final List<PriceLevel>? priceLevels;
  @JsonKey(name: 'employees')
  final List<Employee>? employees;
  @JsonKey(name: 'commisionProductToEmployeeRels')
  final List<CommisionProductToEmployeeRel>? commisionProductToEmployeeRels;
  @JsonKey(name: 'productTieredPrices')
  final List<ProductTieredPrice>? productTieredPrices;
  @JsonKey(name: 'serverTime')
  final String? serverTime;

  InitialDataProductResponse({
    this.products,
    this.variants,
    this.categories,
    this.productToCategories,
    this.productToUsers,
    this.modifiers,
    this.modifierItems,
    this.productToModifiers,
    this.priceList,
    this.priceLevelItems,
    this.priceLevels,
    this.employees,
    this.commisionProductToEmployeeRels,
    this.productTieredPrices,
    this.serverTime,
  });

  factory InitialDataProductResponse.fromJson(Map<String, dynamic> json) =>
      _$InitialDataProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InitialDataProductResponseToJson(this);
}

@JsonSerializable()
class Product {
  final String? id;
  final String? sku;
  final String? name;
  final String? detailDescription;
  final bool? serviceCharged;
  final String? salesTaxId;
  final num? unitPrice;
  final String? uom;
  final num? modifierCount;
  final bool? hasVariants;
  final bool? availableForAllPosUsers;
  final num? variantCount;
  final String? variantAttribute1;
  final String? variantAttribute2;
  final String? variantAttribute3;
  final String? masterVariantId;
  final String? pictureUrl;
  final bool? deleted;
  final bool? isDiscountDisabled;
  final ProductDimension? dimension;

  Product({
    this.id,
    this.sku,
    this.name,
    this.detailDescription,
    this.serviceCharged,
    this.salesTaxId,
    this.unitPrice,
    this.uom,
    this.modifierCount,
    this.hasVariants,
    this.availableForAllPosUsers,
    this.variantCount,
    this.variantAttribute1,
    this.variantAttribute2,
    this.variantAttribute3,
    this.masterVariantId,
    this.pictureUrl,
    this.deleted,
    this.isDiscountDisabled,
    this.dimension,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class ProductDimension {
  final num? weight;
  final num? height;
  final num? width;
  final num? length;
  final num? sizeUom;
  final num? weightUom;

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
  final String? id;
  final String? productId;
  final String? sku;
  final String? name;
  final String? variantName;
  final String? attribute1Value;
  final String? attribute2Value;
  final String? attribute3Value;
  final num? unitPrice;
  final num? sortOrder;
  final bool? isMaster;
  final bool? deleted;

  Variant({
    this.id,
    this.productId,
    this.sku,
    this.name,
    this.variantName,
    this.attribute1Value,
    this.attribute2Value,
    this.attribute3Value,
    this.unitPrice,
    this.sortOrder,
    this.isMaster,
    this.deleted,
  });

  factory Variant.fromJson(Map<String, dynamic> json) =>
      _$VariantFromJson(json);

  Map<String, dynamic> toJson() => _$VariantToJson(this);
}

@JsonSerializable()
class Category {
  final String? id;
  final String? name;
  final num? sortOrder;
  final bool? deleted;
  final bool? isCustom;
  final String? startDate;
  final String? startTime;
  final String? endDate;
  final String? endTime;
  final bool? monday;
  final bool? tuesday;
  final bool? wednesday;
  final bool? thursday;
  final bool? friday;
  final bool? saturday;
  final bool? sunday;

  Category({
    this.id,
    this.name,
    this.sortOrder,
    this.deleted,
    this.isCustom,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class ProductToCategory {
  final String? productId;
  final String? categoryId;
  final bool? deleted;

  ProductToCategory({this.productId, this.categoryId, this.deleted});

  factory ProductToCategory.fromJson(Map<String, dynamic> json) =>
      _$ProductToCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToCategoryToJson(this);
}

@JsonSerializable()
class ProductToUser {
  final String? productId;
  final String? userId;

  ProductToUser({this.productId, this.userId});

  factory ProductToUser.fromJson(Map<String, dynamic> json) =>
      _$ProductToUserFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToUserToJson(this);
}

@JsonSerializable()
class Modifier {
  final String? id;
  final String? name;
  final bool? required;
  final bool? allowMultiple;
  final num? maximumAllowed;
  final bool? haveMaximumItemAllowed;
  final num? maximumItemAllowed;
  final bool? deleted;

  Modifier({
    this.id,
    this.name,
    this.required,
    this.allowMultiple,
    this.maximumAllowed,
    this.haveMaximumItemAllowed,
    this.maximumItemAllowed,
    this.deleted,
  });

  factory Modifier.fromJson(Map<String, dynamic> json) =>
      _$ModifierFromJson(json);

  Map<String, dynamic> toJson() => _$ModifierToJson(this);
}

@JsonSerializable()
class ModifierItem {
  final String? id;
  final String? modifierId;
  final String? name;
  final String? productId;
  final String? productVariantId;
  final bool? useCustomPrice;
  final num? price;
  final num? sortOrder;

  ModifierItem({
    this.id,
    this.modifierId,
    this.name,
    this.productId,
    this.productVariantId,
    this.useCustomPrice,
    this.price,
    this.sortOrder,
  });

  factory ModifierItem.fromJson(Map<String, dynamic> json) =>
      _$ModifierItemFromJson(json);

  Map<String, dynamic> toJson() => _$ModifierItemToJson(this);
}

@JsonSerializable()
class ProductToModifier {
  final String? productId;
  final String? modifierId;
  final num? sortOrder;
  final bool? deleted;

  ProductToModifier({
    this.productId,
    this.modifierId,
    this.sortOrder,
    this.deleted,
  });

  factory ProductToModifier.fromJson(Map<String, dynamic> json) =>
      _$ProductToModifierFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToModifierToJson(this);
}

@JsonSerializable()
class PriceList {
  final String? productId;
  final String? productVariantId;
  final String? salesTypeId;
  final String? salesTypeName;
  final num? price;
  final bool? isMaster;
  final bool? deleted;

  PriceList({
    this.productId,
    this.productVariantId,
    this.salesTypeId,
    this.salesTypeName,
    this.price,
    this.isMaster,
    this.deleted,
  });

  factory PriceList.fromJson(Map<String, dynamic> json) =>
      _$PriceListFromJson(json);

  Map<String, dynamic> toJson() => _$PriceListToJson(this);
}

@JsonSerializable()
class PriceLevelItem {
  final String? productId;
  final String? productVariantId;
  final String? priceLevelId;
  final String? priceLevelName;
  final num? price;
  final bool? isMaster;
  final bool? deleted;

  PriceLevelItem({
    this.productId,
    this.productVariantId,
    this.priceLevelId,
    this.priceLevelName,
    this.price,
    this.isMaster,
    this.deleted,
  });

  factory PriceLevelItem.fromJson(Map<String, dynamic> json) =>
      _$PriceLevelItemFromJson(json);

  Map<String, dynamic> toJson() => _$PriceLevelItemToJson(this);
}

@JsonSerializable()
class PriceLevel {
  final String? id;
  final String? name;
  final num? systemType;
  final bool? inactive;
  final bool? isMaster;

  PriceLevel({
    this.id,
    this.name,
    this.systemType,
    this.inactive,
    this.isMaster,
  });

  factory PriceLevel.fromJson(Map<String, dynamic> json) =>
      _$PriceLevelFromJson(json);

  Map<String, dynamic> toJson() => _$PriceLevelToJson(this);
}

@JsonSerializable()
class Employee {
  final String? employeeId;
  final String? employeeName;

  Employee({this.employeeId, this.employeeName});

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}

@JsonSerializable()
class CommisionProductToEmployeeRel {
  final String? employeeId;
  final String? productId;

  CommisionProductToEmployeeRel({this.employeeId, this.productId});

  factory CommisionProductToEmployeeRel.fromJson(Map<String, dynamic> json) =>
      _$CommisionProductToEmployeeRelFromJson(json);

  Map<String, dynamic> toJson() => _$CommisionProductToEmployeeRelToJson(this);
}

@JsonSerializable()
class ProductTieredPrice {
  final String? id;
  final String? productId;
  final String? name;
  final num? minimumQty;
  final num? price;
  final num? sortOrder;

  ProductTieredPrice({
    this.id,
    this.productId,
    this.name,
    this.minimumQty,
    this.price,
    this.sortOrder,
  });

  factory ProductTieredPrice.fromJson(Map<String, dynamic> json) =>
      _$ProductTieredPriceFromJson(json);

  Map<String, dynamic> toJson() => _$ProductTieredPriceToJson(this);
}
