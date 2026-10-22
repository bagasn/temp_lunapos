part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

final class LoadTransactions extends TransactionEvent {
  const LoadTransactions();
}

final class SwitchTransactionSource extends TransactionEvent {
  final TransactionOrderSource source;

  const SwitchTransactionSource(this.source);

  @override
  List<Object?> get props => [source];
}

final class ToggleTransactionFilterPanel extends TransactionEvent {
  const ToggleTransactionFilterPanel();
}

final class SearchTransactionChanged extends TransactionEvent {
  final String query;

  const SearchTransactionChanged(this.query);

  @override
  List<Object?> get props => [query];
}

final class UpdateTransactionDateRange extends TransactionEvent {
  final DateTime? startDate;
  final bool clearStartDate;
  final DateTime? endDate;
  final bool clearEndDate;

  const UpdateTransactionDateRange({
    this.startDate,
    this.clearStartDate = false,
    this.endDate,
    this.clearEndDate = false,
  });

  @override
  List<Object?> get props => [
    startDate,
    clearStartDate,
    endDate,
    clearEndDate,
  ];
}

final class ChangeTransactionStatusFilter extends TransactionEvent {
  final TransactionOrderStatus status;

  const ChangeTransactionStatusFilter(this.status);

  @override
  List<Object?> get props => [status];
}

final class ResetTransactionFilters extends TransactionEvent {
  const ResetTransactionFilters();
}

final class SelectTransaction extends TransactionEvent {
  final String transactionId;

  const SelectTransaction(this.transactionId);

  @override
  List<Object?> get props => [transactionId];
}

final class ToggleTransactionHistory extends TransactionEvent {
  const ToggleTransactionHistory();
}

final class SyncTransactionEvent extends TransactionEvent {
  final String? transactionId;

  const SyncTransactionEvent({this.transactionId});

  @override
  List<Object?> get props => [transactionId];
}
