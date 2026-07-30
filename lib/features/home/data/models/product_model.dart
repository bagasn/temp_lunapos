import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final String id;
  final String? name;
  final num? price;
  final String? pictureUrl;
  final String? sku;
  final bool? isOutOfStock;
  final num? stock;
  final bool? isFavorite;
  final bool? isActive;

  const ProductModel({
    required this.id,
    this.name,
    this.price,
    this.pictureUrl,
    this.sku,
    this.isOutOfStock,
    this.stock,
    this.isFavorite,
    this.isActive,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable()
class CategoryModel {
  final String id;
  final String? name;
  final num? sortOrder;

  const CategoryModel({required this.id, this.name, this.sortOrder});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
