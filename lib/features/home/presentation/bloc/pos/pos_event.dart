import 'package:equatable/equatable.dart';
import 'package:pos/features/home/domain/entities/product_entity.dart';

sealed class PosEvent extends Equatable {
  const PosEvent();
  @override
  List<Object?> get props => [];
}

final class PosInitRequested extends PosEvent {
  const PosInitRequested();
}

final class PosProductAdded extends PosEvent {
  final ProductEntity product;
  const PosProductAdded(this.product);
  @override
  List<Object?> get props => [product];
}

final class PosOrderLineQuantityChanged extends PosEvent {
  final String orderLineId;
  final num quantity;
  const PosOrderLineQuantityChanged(this.orderLineId, this.quantity);
  @override
  List<Object?> get props => [orderLineId, quantity];
}

final class PosOrderLineRemoved extends PosEvent {
  final String orderLineId;
  const PosOrderLineRemoved(this.orderLineId);
  @override
  List<Object?> get props => [orderLineId];
}

final class PosSaveRequested extends PosEvent {
  const PosSaveRequested();
}

final class PosPayRequested extends PosEvent {
  const PosPayRequested();
}

final class PosNewOrderStarted extends PosEvent {
  const PosNewOrderStarted();
}
