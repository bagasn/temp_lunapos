import 'package:equatable/equatable.dart';

/// Entity yang merepresentasikan produk + master variant untuk ditampilkan di POS grid.
class PosProductEntity extends Equatable {
  final String id;
  final String? name;
  final String? sku;
  final String? pictureUrl;
  final bool hasVariants;
  final bool isOutOfStock;
  final bool isFavorite;
  final int modifierCount;
  final double unitPrice; // dari master variant
  final String? masterVariantId; // ID varian master, digunakan saat add to order

  const PosProductEntity({
    required this.id,
    this.name,
    this.sku,
    this.pictureUrl,
    required this.hasVariants,
    required this.isOutOfStock,
    required this.isFavorite,
    required this.modifierCount,
    required this.unitPrice,
    this.masterVariantId,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    sku,
    pictureUrl,
    hasVariants,
    isOutOfStock,
    isFavorite,
    modifierCount,
    unitPrice,
    masterVariantId,
  ];
}
