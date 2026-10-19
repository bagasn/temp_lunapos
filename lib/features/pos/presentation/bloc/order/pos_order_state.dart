part of 'pos_order_bloc.dart';

enum PosOrderSaveStatus { idle, saving, success, failure }

final class PosOrderState extends Equatable {
  final PosOrderEntity? order; // null = belum ada order aktif
  final PosOrderSaveStatus saveStatus;
  final String? errorMessage;

  const PosOrderState({
    this.order,
    this.saveStatus = PosOrderSaveStatus.idle,
    this.errorMessage,
  });

  bool get isEmpty => order == null || order!.lines.isEmpty;
  int get totalQty => order?.totalQty ?? 0;
  double get subTotal => order?.subTotal ?? 0.0;
  int get lineCount => order?.lineCount ?? 0;

  PosOrderState copyWith({
    PosOrderEntity? order,
    bool clearOrder = false,
    PosOrderSaveStatus? saveStatus,
    String? errorMessage,
  }) {
    return PosOrderState(
      order: clearOrder ? null : order ?? this.order,
      saveStatus: saveStatus ?? this.saveStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [order, saveStatus, errorMessage];
}
