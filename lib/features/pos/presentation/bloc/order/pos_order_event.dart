part of 'pos_order_bloc.dart';

sealed class PosOrderEvent extends Equatable {
  const PosOrderEvent();
  @override
  List<Object?> get props => [];
}

/// Tambah produk ke order. Jika produk sudah ada, increment qty-nya.
final class AddProductToOrder extends PosOrderEvent {
  final PosProductEntity product;
  const AddProductToOrder(this.product);
  @override
  List<Object?> get props => [product];
}

/// Update qty sebuah order line. Jika qty <= 0, line dihapus.
final class UpdateOrderLineQty extends PosOrderEvent {
  final String lineId;
  final int newQty;
  const UpdateOrderLineQty({required this.lineId, required this.newQty});
  @override
  List<Object?> get props => [lineId, newQty];
}

/// Hapus satu order line dari list.
final class RemoveOrderLine extends PosOrderEvent {
  final String lineId;
  const RemoveOrderLine(this.lineId);
  @override
  List<Object?> get props => [lineId];
}

/// Reset seluruh order (hapus semua item).
final class ClearOrder extends PosOrderEvent {
  const ClearOrder();
}

/// Simpan order aktif ke database lokal.
final class SaveOrderEvent extends PosOrderEvent {
  const SaveOrderEvent();
}
