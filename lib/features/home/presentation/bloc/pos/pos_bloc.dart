import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/home/domain/repositories/order_repository.dart';
import 'package:pos/features/home/presentation/bloc/pos/pos_event.dart';
import 'package:pos/features/home/presentation/bloc/pos/pos_state.dart';

@injectable
class PosBloc extends Bloc<PosEvent, PosState> {
  final OrderRepository _orderRepository;

  PosBloc(this._orderRepository) : super(const PosInitial()) {
    // on<PosInitRequested>(_onInit);
    // on<PosProductAdded>(_onProductAdded);
    // on<PosOrderLineQuantityChanged>(_onQtyChanged);
    // on<PosOrderLineRemoved>(_onLineRemoved);
    // on<PosSaveRequested>(_onSave);
    // on<PosPayRequested>(_onPay);
    // on<PosNewOrderStarted>(_onNewOrder);
  }

  Future<void> _onInit(PosInitRequested event, Emitter<PosState> emit) async {
    final existingResult = await _orderRepository.getActiveOrder();
    final existing = existingResult.fold((_) => null, (o) => o);

    if (existing != null) {
      emit(PosOrderActive(existing));
      return;
    }

    final newOrderResult = await _orderRepository.createNewOrder();
    newOrderResult.fold(
      (failure) => emit(PosFailure(failure.message)),
      (order) => emit(PosOrderActive(order)),
    );
  }

  Future<void> _onProductAdded(
    PosProductAdded event,
    Emitter<PosState> emit,
  ) async {
    final current = state;
    if (current is! PosOrderActive) return;

    final result = await _orderRepository.addItemToOrder(
      order: current.order,
      productId: event.product.id,
      productName: event.product.name,
      unitPrice: event.product.price,
    );
    result.fold(
      (failure) => emit(PosFailure(failure.message)),
      (updated) => emit(PosOrderActive(updated)),
    );
  }

  Future<void> _onQtyChanged(
    PosOrderLineQuantityChanged event,
    Emitter<PosState> emit,
  ) async {
    final current = state;
    if (current is! PosOrderActive) return;

    final result = await _orderRepository.updateOrderLineQuantity(
      order: current.order,
      orderLineId: event.orderLineId,
      quantity: event.quantity,
    );
    result.fold(
      (failure) => emit(PosFailure(failure.message)),
      (updated) => emit(PosOrderActive(updated)),
    );
  }

  Future<void> _onLineRemoved(
    PosOrderLineRemoved event,
    Emitter<PosState> emit,
  ) async {
    final current = state;
    if (current is! PosOrderActive) return;

    final result = await _orderRepository.removeOrderLine(
      order: current.order,
      orderLineId: event.orderLineId,
    );
    result.fold(
      (failure) => emit(PosFailure(failure.message)),
      (updated) => emit(PosOrderActive(updated)),
    );
  }

  Future<void> _onSave(PosSaveRequested event, Emitter<PosState> emit) async {
    final current = state;
    if (current is! PosOrderActive) return;
    emit(PosSaving(current.order));
    final result = await _orderRepository.saveOrder(current.order);
    result.fold(
      (failure) => emit(PosOrderActive(current.order)),
      (_) => emit(const PosSaved()),
    );
  }

  Future<void> _onPay(PosPayRequested event, Emitter<PosState> emit) async {
    final current = state;
    if (current is! PosOrderActive) return;
    emit(PosSaving(current.order));
    final result = await _orderRepository.payOrder(current.order);
    result.fold(
      (failure) => emit(PosOrderActive(current.order)),
      (_) => emit(const PosPaid()),
    );
  }

  Future<void> _onNewOrder(
    PosNewOrderStarted event,
    Emitter<PosState> emit,
  ) async {
    final result = await _orderRepository.createNewOrder();
    result.fold(
      (failure) => emit(PosFailure(failure.message)),
      (order) => emit(PosOrderActive(order)),
    );
  }
}
