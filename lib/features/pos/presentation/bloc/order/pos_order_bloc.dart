import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/pos/domain/entities/pos_order_entity.dart';
import 'package:pos/features/pos/domain/entities/pos_order_line_entity.dart';
import 'package:pos/features/pos/domain/entities/product_entity.dart';
import 'package:pos/features/pos/domain/usecases/save_pos_order_usecase.dart';
import 'package:uuid/uuid.dart';

part 'pos_order_event.dart';
part 'pos_order_state.dart';

const _uuid = Uuid();

@injectable
class PosOrderBloc extends Bloc<PosOrderEvent, PosOrderState> {
  final SavePosOrderUseCase _savePosOrderUseCase;

  PosOrderBloc(this._savePosOrderUseCase) : super(const PosOrderState()) {
    on<AddProductToOrder>(_onAddProduct);
    on<UpdateOrderLineQty>(_onUpdateQty);
    on<RemoveOrderLine>(_onRemoveLine);
    on<ClearOrder>(_onClearOrder);
    on<SaveOrderEvent>(_onSaveOrder);
  }

  void _onAddProduct(AddProductToOrder event, Emitter<PosOrderState> emit) {
    final product = event.product;
    final currentOrder = state.order;

    if (currentOrder == null) {
      // Create a brand-new order with the first item
      final orderId = _uuid.v4();
      final line = PosOrderLineEntity(
        id: _uuid.v4(),
        productId: product.id,
        productVariantId: product.masterVariantId,
        name: product.name ?? product.id,
        unitPrice: product.unitPrice,
        qty: 1,
      );
      emit(state.copyWith(
        order: PosOrderEntity(id: orderId, lines: [line]),
        saveStatus: PosOrderSaveStatus.idle,
      ));
      return;
    }

    // Check if the same product (same productId + variantId) already exists
    final existingIndex = currentOrder.lines.indexWhere(
      (l) =>
          l.productId == product.id &&
          l.productVariantId == product.masterVariantId,
    );

    List<PosOrderLineEntity> updatedLines;
    if (existingIndex >= 0) {
      // Increment quantity of existing line
      updatedLines = List.of(currentOrder.lines);
      updatedLines[existingIndex] = updatedLines[existingIndex].copyWith(
        qty: updatedLines[existingIndex].qty + 1,
      );
    } else {
      // Add as a new line
      updatedLines = [
        ...currentOrder.lines,
        PosOrderLineEntity(
          id: _uuid.v4(),
          productId: product.id,
          productVariantId: product.masterVariantId,
          name: product.name ?? product.id,
          unitPrice: product.unitPrice,
          qty: 1,
        ),
      ];
    }

    emit(state.copyWith(
      order: currentOrder.copyWith(lines: updatedLines),
      saveStatus: PosOrderSaveStatus.idle,
    ));
  }

  void _onUpdateQty(UpdateOrderLineQty event, Emitter<PosOrderState> emit) {
    final currentOrder = state.order;
    if (currentOrder == null) return;

    List<PosOrderLineEntity> updatedLines;
    if (event.newQty <= 0) {
      updatedLines =
          currentOrder.lines.where((l) => l.id != event.lineId).toList();
    } else {
      updatedLines = currentOrder.lines.map((l) {
        return l.id == event.lineId ? l.copyWith(qty: event.newQty) : l;
      }).toList();
    }

    emit(state.copyWith(
      order: currentOrder.copyWith(lines: updatedLines),
    ));
  }

  void _onRemoveLine(RemoveOrderLine event, Emitter<PosOrderState> emit) {
    final currentOrder = state.order;
    if (currentOrder == null) return;

    final updatedLines =
        currentOrder.lines.where((l) => l.id != event.lineId).toList();
    emit(state.copyWith(order: currentOrder.copyWith(lines: updatedLines)));
  }

  void _onClearOrder(ClearOrder event, Emitter<PosOrderState> emit) {
    emit(const PosOrderState());
  }

  Future<void> _onSaveOrder(
    SaveOrderEvent event,
    Emitter<PosOrderState> emit,
  ) async {
    final currentOrder = state.order;
    if (currentOrder == null || currentOrder.lines.isEmpty) return;

    emit(state.copyWith(saveStatus: PosOrderSaveStatus.saving));

    final result = await _savePosOrderUseCase(currentOrder);

    result.fold(
      (failure) => emit(state.copyWith(
        saveStatus: PosOrderSaveStatus.failure,
        errorMessage: failure.errorMessage,
      )),
      (_) {
        // Clear order after successful save — new order ID generated on next add
        emit(const PosOrderState(saveStatus: PosOrderSaveStatus.success));
      },
    );
  }
}
