import 'package:equatable/equatable.dart';
import 'package:pos/features/home/data/models/order_model.dart';

sealed class PosState extends Equatable {
  const PosState();
  @override
  List<Object?> get props => [];
}

final class PosInitial extends PosState {
  const PosInitial();
}

final class PosOrderActive extends PosState {
  final OrderModel order;
  const PosOrderActive(this.order);
  @override
  List<Object?> get props => [order];
}

final class PosSaving extends PosState {
  final OrderModel order;
  const PosSaving(this.order);
  @override
  List<Object?> get props => [order];
}

final class PosSaved extends PosState {
  const PosSaved();
}

final class PosPaid extends PosState {
  const PosPaid();
}

final class PosFailure extends PosState {
  final String message;
  const PosFailure(this.message);
  @override
  List<Object?> get props => [message];
}
