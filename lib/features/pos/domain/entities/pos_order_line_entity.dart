import 'package:equatable/equatable.dart';

/// Entity untuk setiap baris item dalam order (cart line).
class PosOrderLineEntity extends Equatable {
  final String id; // UUID, dibuat di BLoC saat penambahan
  final String productId;
  final String? productVariantId;
  final String name;
  final double unitPrice;
  final int qty;
  final String? notes;

  const PosOrderLineEntity({
    required this.id,
    required this.productId,
    this.productVariantId,
    required this.name,
    required this.unitPrice,
    required this.qty,
    this.notes,
  });

  double get lineTotal => unitPrice * qty;

  PosOrderLineEntity copyWith({
    String? id,
    String? productId,
    String? productVariantId,
    String? name,
    double? unitPrice,
    int? qty,
    String? notes,
  }) {
    return PosOrderLineEntity(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productVariantId: productVariantId ?? this.productVariantId,
      name: name ?? this.name,
      unitPrice: unitPrice ?? this.unitPrice,
      qty: qty ?? this.qty,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
    id,
    productId,
    productVariantId,
    name,
    unitPrice,
    qty,
    notes,
  ];
}
