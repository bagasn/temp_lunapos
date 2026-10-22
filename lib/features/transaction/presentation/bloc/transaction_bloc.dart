import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

@injectable
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(const TransactionState()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<SwitchTransactionSource>(_onSwitchSource);
    on<ToggleTransactionFilterPanel>(_onToggleFilterPanel);
    on<SearchTransactionChanged>(_onSearchChanged);
    on<UpdateTransactionDateRange>(_onUpdateDateRange);
    on<ChangeTransactionStatusFilter>(_onChangeStatusFilter);
    on<ResetTransactionFilters>(_onResetFilters);
    on<SelectTransaction>(_onSelectTransaction);
    on<ToggleTransactionHistory>(_onToggleHistory);
    on<SyncTransactionEvent>(_onSyncTransaction);
  }

  void _onLoadTransactions(
    LoadTransactions event,
    Emitter<TransactionState> emit,
  ) {
    emit(state.copyWith(status: TransactionLoadStatus.loading));

    final defaultDate = DateTime(2026, 10, 22, 17, 23);
    final mockTransactions = _buildMockTransactions(defaultDate);

    final nextState = state.copyWith(
      status: TransactionLoadStatus.loaded,
      startDate: DateTime(2026, 10, 22),
      endDate: DateTime(2026, 10, 22),
      allTransactions: mockTransactions,
    );

    final filtered = _applyFilters(nextState);
    emit(
      nextState.copyWith(
        filteredTransactions: filtered,
        selectedTransaction: filtered.isNotEmpty ? filtered.first : null,
        clearSelectedTransaction: filtered.isEmpty,
      ),
    );
  }

  void _onSwitchSource(
    SwitchTransactionSource event,
    Emitter<TransactionState> emit,
  ) {
    if (state.activeSource == event.source) return;
    final updated = state.copyWith(
      activeSource: event.source,
      isHistoryShown: false,
    );
    final filtered = _applyFilters(updated);
    emit(
      updated.copyWith(
        filteredTransactions: filtered,
        selectedTransaction: filtered.isNotEmpty ? filtered.first : null,
        clearSelectedTransaction: filtered.isEmpty,
      ),
    );
  }

  void _onToggleFilterPanel(
    ToggleTransactionFilterPanel event,
    Emitter<TransactionState> emit,
  ) {
    emit(state.copyWith(isFilterExpanded: !state.isFilterExpanded));
  }

  void _onSearchChanged(
    SearchTransactionChanged event,
    Emitter<TransactionState> emit,
  ) {
    final updated = state.copyWith(searchQuery: event.query);
    final filtered = _applyFilters(updated);
    final currentSelected = state.selectedTransaction;
    final stillExists =
        currentSelected != null &&
        filtered.any((t) => t.id == currentSelected.id);

    emit(
      updated.copyWith(
        filteredTransactions: filtered,
        selectedTransaction: stillExists
            ? currentSelected
            : (filtered.isNotEmpty ? filtered.first : null),
        clearSelectedTransaction: filtered.isEmpty,
      ),
    );
  }

  void _onUpdateDateRange(
    UpdateTransactionDateRange event,
    Emitter<TransactionState> emit,
  ) {
    final updated = state.copyWith(
      startDate: event.startDate,
      clearStartDate: event.clearStartDate,
      endDate: event.endDate,
      clearEndDate: event.clearEndDate,
    );
    final filtered = _applyFilters(updated);
    emit(
      updated.copyWith(
        filteredTransactions: filtered,
        selectedTransaction: filtered.isNotEmpty ? filtered.first : null,
        clearSelectedTransaction: filtered.isEmpty,
      ),
    );
  }

  void _onChangeStatusFilter(
    ChangeTransactionStatusFilter event,
    Emitter<TransactionState> emit,
  ) {
    if (state.statusFilter == event.status) return;
    final defaultDay = DateTime(2026, 10, 22);
    final isCompleted = event.status == TransactionOrderStatus.completed;

    final updated = state.copyWith(
      statusFilter: event.status,
      startDate: isCompleted ? (state.startDate ?? defaultDay) : null,
      clearStartDate: !isCompleted,
      endDate: isCompleted ? (state.endDate ?? defaultDay) : null,
      clearEndDate: !isCompleted,
      isHistoryShown: false,
    );
    final filtered = _applyFilters(updated);
    emit(
      updated.copyWith(
        filteredTransactions: filtered,
        selectedTransaction: filtered.isNotEmpty ? filtered.first : null,
        clearSelectedTransaction: filtered.isEmpty,
      ),
    );
  }

  void _onResetFilters(
    ResetTransactionFilters event,
    Emitter<TransactionState> emit,
  ) {
    final defaultDay = DateTime(2026, 10, 22);
    final updated = state.copyWith(
      searchQuery: '',
      statusFilter: TransactionOrderStatus.completed,
      startDate: defaultDay,
      endDate: defaultDay,
      isHistoryShown: false,
    );
    final filtered = _applyFilters(updated);
    emit(
      updated.copyWith(
        filteredTransactions: filtered,
        selectedTransaction: filtered.isNotEmpty ? filtered.first : null,
        clearSelectedTransaction: filtered.isEmpty,
      ),
    );
  }

  void _onSelectTransaction(
    SelectTransaction event,
    Emitter<TransactionState> emit,
  ) {
    final found = state.filteredTransactions
        .where((t) => t.id == event.transactionId)
        .firstOrNull;
    if (found == null) return;
    emit(
      state.copyWith(
        selectedTransaction: found,
        isHistoryShown: false,
      ),
    );
  }

  void _onToggleHistory(
    ToggleTransactionHistory event,
    Emitter<TransactionState> emit,
  ) {
    emit(state.copyWith(isHistoryShown: !state.isHistoryShown));
  }

  void _onSyncTransaction(
    SyncTransactionEvent event,
    Emitter<TransactionState> emit,
  ) {
    final targetId = event.transactionId;
    final updatedAll = state.allTransactions.map((tx) {
      if (targetId == null || tx.id == targetId) {
        return tx.copyWith(isSynced: true);
      }
      return tx;
    }).toList();

    final tempState = state.copyWith(allTransactions: updatedAll);
    final filtered = _applyFilters(tempState);
    final selectedId = state.selectedTransaction?.id;
    final updatedSelected = selectedId != null
        ? filtered.where((t) => t.id == selectedId).firstOrNull
        : (filtered.isNotEmpty ? filtered.first : null);

    emit(
      tempState.copyWith(
        filteredTransactions: filtered,
        selectedTransaction: updatedSelected,
        clearSelectedTransaction: updatedSelected == null,
      ),
    );
  }

  List<TransactionUiModel> _applyFilters(TransactionState current) {
    return current.allTransactions.where((tx) {
      if (tx.source != current.activeSource) return false;
      if (tx.status != current.statusFilter) return false;

      if (current.searchQuery.trim().isNotEmpty) {
        final q = current.searchQuery.trim().toLowerCase();
        final matchOrderNo = tx.orderNumber.toLowerCase().contains(q);
        final matchCustomer =
            (tx.customerName ?? '').toLowerCase().contains(q);
        if (!matchOrderNo && !matchCustomer) return false;
      }

      final txDay = DateTime(
        tx.displayDate.year,
        tx.displayDate.month,
        tx.displayDate.day,
      );
      if (current.startDate != null) {
        final start = DateTime(
          current.startDate!.year,
          current.startDate!.month,
          current.startDate!.day,
        );
        if (txDay.isBefore(start)) return false;
      }
      if (current.endDate != null) {
        final end = DateTime(
          current.endDate!.year,
          current.endDate!.month,
          current.endDate!.day,
        );
        if (txDay.isAfter(end)) return false;
      }

      return true;
    }).toList();
  }

  List<TransactionUiModel> _buildMockTransactions(DateTime baseDate) {
    return [
      TransactionUiModel(
        id: 'tx-pos-1',
        orderNumber: 'POS-221026-2',
        orderDate: baseDate,
        closingDate: baseDate,
        queueNumber: null,
        serverName: 'Robin Richard (DEV)',
        cashierName: 'Robin Richard (DEV)',
        tableName: null,
        paxCount: 1,
        customerName: null,
        customerEmail: null,
        customerPhone: null,
        orderType: 'POS',
        salesType: 'Normal',
        source: TransactionOrderSource.pos,
        status: TransactionOrderStatus.completed,
        isSynced: false,
        lines: const [
          TransactionLineUiModel(
            id: 'line-1',
            qty: 1,
            name: '!ES KOPI',
            totalPrice: 0,
            isGift: true,
          ),
          TransactionLineUiModel(
            id: 'line-2',
            qty: 1,
            name: '! Qris (Rounding)',
            totalPrice: 1321,
          ),
          TransactionLineUiModel(
            id: 'line-3',
            qty: 1,
            name: '#hastag',
            totalPrice: 10000,
          ),
          TransactionLineUiModel(
            id: 'line-4',
            qty: 1,
            name: '!ES KOPI',
            totalPrice: 8000,
          ),
          TransactionLineUiModel(
            id: 'line-5',
            qty: 1,
            name: '( API )',
            totalPrice: 80000,
          ),
        ],
        payments: const [
          TransactionPaymentUiModel(
            id: 'pay-1',
            methodName: 'Cash',
            amount: 115112.36,
          ),
        ],
        subTotal: 99321,
        discountAmount: 0,
        serviceChargeRate: 5,
        serviceChargeAmount: 4966.05,
        taxAmount: 10825.31,
        adjustmentAmount: 0,
        totalAmount: 115112.36,
        totalItemsCount: 4,
        tenderAmount: 115112.36,
        changeAmount: 0,
        logs: [
          TransactionLogUiModel(
            id: 'log-1',
            userName: 'Robin Richard (DEV)',
            dateTime: baseDate,
            description: 'Order Created & Paid',
          ),
        ],
      ),
      TransactionUiModel(
        id: 'tx-pos-active-1',
        orderNumber: 'POS-221026-3',
        orderDate: DateTime(2026, 10, 22, 17, 45),
        closingDate: null,
        queueNumber: '12',
        serverName: 'Robin Richard (DEV)',
        cashierName: '-',
        tableName: 'Indoor / Meja 4',
        paxCount: 2,
        customerName: 'Budi Santoso',
        customerEmail: 'budi@example.com',
        customerPhone: '081234567890',
        orderType: 'POS',
        salesType: 'Dine In',
        source: TransactionOrderSource.pos,
        status: TransactionOrderStatus.active,
        isSynced: false,
        lines: const [
          TransactionLineUiModel(
            id: 'line-a1',
            qty: 2,
            name: '!ES KOPI',
            totalPrice: 16000,
          ),
        ],
        payments: const [],
        subTotal: 16000,
        discountAmount: 0,
        serviceChargeRate: 5,
        serviceChargeAmount: 800,
        taxAmount: 1680,
        adjustmentAmount: 0,
        totalAmount: 18480,
        totalItemsCount: 2,
        tenderAmount: 0,
        changeAmount: 0,
        logs: [
          TransactionLogUiModel(
            id: 'log-a1',
            userName: 'Robin Richard (DEV)',
            dateTime: DateTime(2026, 10, 22, 17, 45),
            description: 'Order Saved (Open)',
          ),
        ],
      ),
      TransactionUiModel(
        id: 'tx-pos-cancel-1',
        orderNumber: 'POS-221026-1',
        orderDate: DateTime(2026, 10, 22, 16, 10),
        closingDate: DateTime(2026, 10, 22, 16, 15),
        queueNumber: null,
        serverName: 'Robin Richard (DEV)',
        cashierName: 'Robin Richard (DEV)',
        tableName: null,
        paxCount: 1,
        customerName: null,
        customerEmail: null,
        customerPhone: null,
        orderType: 'POS',
        salesType: 'Normal',
        source: TransactionOrderSource.pos,
        status: TransactionOrderStatus.cancel,
        isSynced: true,
        lines: const [
          TransactionLineUiModel(
            id: 'line-c1',
            qty: 1,
            name: '#hastag',
            totalPrice: 10000,
          ),
        ],
        payments: const [],
        subTotal: 10000,
        discountAmount: 0,
        serviceChargeRate: 5,
        serviceChargeAmount: 500,
        taxAmount: 1050,
        adjustmentAmount: 0,
        totalAmount: 11550,
        totalItemsCount: 1,
        tenderAmount: 0,
        changeAmount: 0,
        logs: [
          TransactionLogUiModel(
            id: 'log-c1',
            userName: 'Robin Richard (DEV)',
            dateTime: DateTime(2026, 10, 22, 16, 15),
            description: 'Order Cancelled',
          ),
        ],
      ),
      TransactionUiModel(
        id: 'tx-online-1',
        orderNumber: 'ONL-221026-1',
        orderDate: DateTime(2026, 10, 22, 15, 30),
        closingDate: DateTime(2026, 10, 22, 15, 35),
        queueNumber: 'A01',
        serverName: 'System',
        cashierName: 'Robin Richard (DEV)',
        tableName: null,
        paxCount: 1,
        customerName: 'Andi Wijaya',
        customerEmail: 'andi@mail.com',
        customerPhone: '081987654321',
        orderType: 'TOKOLUNA',
        salesType: 'Online',
        source: TransactionOrderSource.onlineOrder,
        status: TransactionOrderStatus.completed,
        isSynced: true,
        lines: const [
          TransactionLineUiModel(
            id: 'line-o1',
            qty: 2,
            name: '!ES KOPI',
            totalPrice: 16000,
          ),
        ],
        payments: const [
          TransactionPaymentUiModel(
            id: 'pay-o1',
            methodName: 'QRIS',
            amount: 17600,
          ),
        ],
        subTotal: 16000,
        discountAmount: 0,
        serviceChargeRate: null,
        serviceChargeAmount: 0,
        taxAmount: 1600,
        adjustmentAmount: 0,
        totalAmount: 17600,
        totalItemsCount: 2,
        tenderAmount: 17600,
        changeAmount: 0,
        logs: [
          TransactionLogUiModel(
            id: 'log-o1',
            userName: 'Robin Richard (DEV)',
            dateTime: DateTime(2026, 10, 22, 15, 35),
            description: 'Online Order Completed',
          ),
        ],
      ),
    ];
  }
}
