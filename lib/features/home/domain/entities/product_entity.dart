class ProductEntity {
  final String id;
  final String name;
  final num price;
  final String? pictureUrl;
  final String? sku;
  final bool isOutOfStock;
  final num? stock;
  final bool isFavorite;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    this.pictureUrl,
    this.sku,
    this.isOutOfStock = false,
    this.stock,
    this.isFavorite = false,
  });
}

class CategoryEntity {
  final String id;
  final String name;
  final int sortOrder;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.sortOrder = 0,
  });
}
