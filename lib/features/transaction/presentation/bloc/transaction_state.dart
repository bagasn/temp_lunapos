part of 'transaction_bloc.dart';

enum TransactionLoadStatus { initial, loading, loaded, failure }

enum TransactionOrderSource { pos, onlineOrder }

enum TransactionOrderStatus { completed, cancel, active }

class TransactionLineUiModel extends Equatable {
  final String id;
  final int qty;
  final String name;
  final double totalPrice;
  final bool isGift;
  final String? variantName;
  final String? notes;

  const TransactionLineUiModel({
    required this.id,
    required this.qty,
    required this.name,
    required this.totalPrice,
    this.isGift = false,
    this.variantName,
    this.notes,
  });

  @override
  List<Object?> get props => [
    id,
    qty,
    name,
    totalPrice,
    isGift,
    variantName,
    notes,
  ];
}

class TransactionPaymentUiModel extends Equatable {
  final String id;
  final String methodName;
  final double amount;

  const TransactionPaymentUiModel({
    required this.id,
    required this.methodName,
    required this.amount,
  });

  @override
  List<Object?> get props => [id, methodName, amount];
}

class TransactionLogUiModel extends Equatable {
  final String id;
  final String userName;
  final DateTime dateTime;
  final String description;

  const TransactionLogUiModel({
    required this.id,
    required this.userName,
    required this.dateTime,
    required this.description,
  });

  @override
  List<Object?> get props => [id, userName, dateTime, description];
}

class TransactionUiModel extends Equatable {
  final String id;
  final String orderNumber;
  final DateTime orderDate;
  final DateTime? closingDate;
  final String? queueNumber;
  final String? serverName;
  final String? cashierName;
  final String? tableName;
  final int? paxCount;
  final String? customerName;
  final String? customerEmail;
  final String? customerPhone;
  final String orderType;
  final String salesType;
  final TransactionOrderSource source;
  final TransactionOrderStatus status;
  final bool isSynced;
  final List<TransactionLineUiModel> lines;
  final List<TransactionPaymentUiModel> payments;
  final double subTotal;
  final double discountAmount;
  final double? serviceChargeRate;
  final double serviceChargeAmount;
  final double taxAmount;
  final double adjustmentAmount;
  final double totalAmount;
  final int totalItemsCount;
  final double tenderAmount;
  final double changeAmount;
  final List<TransactionLogUiModel> logs;

  const TransactionUiModel({
    required this.id,
    required this.orderNumber,
    required this.orderDate,
    this.closingDate,
    this.queueNumber,
    this.serverName,
    this.cashierName,
    this.tableName,
    this.paxCount,
    this.customerName,
    this.customerEmail,
    this.customerPhone,
    this.orderType = 'POS',
    this.salesType = 'Normal',
    this.source = TransactionOrderSource.pos,
    this.status = TransactionOrderStatus.completed,
    this.isSynced = false,
    this.lines = const [],
    this.payments = const [],
    this.subTotal = 0,
    this.discountAmount = 0,
    this.serviceChargeRate,
    this.serviceChargeAmount = 0,
    this.taxAmount = 0,
    this.adjustmentAmount = 0,
    this.totalAmount = 0,
    this.totalItemsCount = 0,
    this.tenderAmount = 0,
    this.changeAmount = 0,
    this.logs = const [],
  });

  DateTime get displayDate =>
      status == TransactionOrderStatus.active ? orderDate : (closingDate ?? orderDate);

  TransactionUiModel copyWith({
    String? id,
    String? orderNumber,
    DateTime? orderDate,
    DateTime? closingDate,
    String? queueNumber,
    String? serverName,
    String? cashierName,
    String? tableName,
    int? paxCount,
    String? customerName,
    String? customerEmail,
    String? customerPhone,
    String? orderType,
    String? salesType,
    TransactionOrderSource? source,
    TransactionOrderStatus? status,
    bool? isSynced,
    List<TransactionLineUiModel>? lines,
    List<TransactionPaymentUiModel>? payments,
    double? subTotal,
    double? discountAmount,
    double? serviceChargeRate,
    double? serviceChargeAmount,
    double? taxAmount,
    double? adjustmentAmount,
    double? totalAmount,
    int? totalItemsCount,
    double? tenderAmount,
    double? changeAmount,
    List<TransactionLogUiModel>? logs,
  }) {
    return TransactionUiModel(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      orderDate: orderDate ?? this.orderDate,
      closingDate: closingDate ?? this.closingDate,
      queueNumber: queueNumber ?? this.queueNumber,
      serverName: serverName ?? this.serverName,
      cashierName: cashierName ?? this.cashierName,
      tableName: tableName ?? this.tableName,
      paxCount: paxCount ?? this.paxCount,
      customerName: customerName ?? this.customerName,
      customerEmail: customerEmail ?? this.customerEmail,
      customerPhone: customerPhone ?? this.customerPhone,
      orderType: orderType ?? this.orderType,
      salesType: salesType ?? this.salesType,
      source: source ?? this.source,
      status: status ?? this.status,
      isSynced: isSynced ?? this.isSynced,
      lines: lines ?? this.lines,
      payments: payments ?? this.payments,
      subTotal: subTotal ?? this.subTotal,
      discountAmount: discountAmount ?? this.discountAmount,
      serviceChargeRate: serviceChargeRate ?? this.serviceChargeRate,
      serviceChargeAmount: serviceChargeAmount ?? this.serviceChargeAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      adjustmentAmount: adjustmentAmount ?? this.adjustmentAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      totalItemsCount: totalItemsCount ?? this.totalItemsCount,
      tenderAmount: tenderAmount ?? this.tenderAmount,
      changeAmount: changeAmount ?? this.changeAmount,
      logs: logs ?? this.logs,
    );
  }

  @override
  List<Object?> get props => [
    id,
    orderNumber,
    orderDate,
    closingDate,
    queueNumber,
    serverName,
    cashierName,
    tableName,
    paxCount,
    customerName,
    customerEmail,
    customerPhone,
    orderType,
    salesType,
    source,
    status,
    isSynced,
    lines,
    payments,
    subTotal,
    discountAmount,
    serviceChargeRate,
    serviceChargeAmount,
    taxAmount,
    adjustmentAmount,
    totalAmount,
    totalItemsCount,
    tenderAmount,
    changeAmount,
    logs,
  ];
}

final class TransactionState extends Equatable {
  final TransactionLoadStatus status;
  final TransactionOrderSource activeSource;
  final int posOrderCount;
  final int onlineOrderCount;
  final bool isFilterExpanded;
  final String searchQuery;
  final DateTime? startDate;
  final DateTime? endDate;
  final TransactionOrderStatus statusFilter;
  final List<TransactionUiModel> allTransactions;
  final List<TransactionUiModel> filteredTransactions;
  final TransactionUiModel? selectedTransaction;
  final bool isHistoryShown;
  final String? errorMessage;

  const TransactionState({
    this.status = TransactionLoadStatus.initial,
    this.activeSource = TransactionOrderSource.pos,
    this.posOrderCount = 1,
    this.onlineOrderCount = 7,
    this.isFilterExpanded = false,
    this.searchQuery = '',
    this.startDate,
    this.endDate,
    this.statusFilter = TransactionOrderStatus.completed,
    this.allTransactions = const [],
    this.filteredTransactions = const [],
    this.selectedTransaction,
    this.isHistoryShown = false,
    this.errorMessage,
  });

  TransactionState copyWith({
    TransactionLoadStatus? status,
    TransactionOrderSource? activeSource,
    int? posOrderCount,
    int? onlineOrderCount,
    bool? isFilterExpanded,
    String? searchQuery,
    DateTime? startDate,
    bool clearStartDate = false,
    DateTime? endDate,
    bool clearEndDate = false,
    TransactionOrderStatus? statusFilter,
    List<TransactionUiModel>? allTransactions,
    List<TransactionUiModel>? filteredTransactions,
    TransactionUiModel? selectedTransaction,
    bool clearSelectedTransaction = false,
    bool? isHistoryShown,
    String? errorMessage,
  }) {
    return TransactionState(
      status: status ?? this.status,
      activeSource: activeSource ?? this.activeSource,
      posOrderCount: posOrderCount ?? this.posOrderCount,
      onlineOrderCount: onlineOrderCount ?? this.onlineOrderCount,
      isFilterExpanded: isFilterExpanded ?? this.isFilterExpanded,
      searchQuery: searchQuery ?? this.searchQuery,
      startDate: clearStartDate ? null : (startDate ?? this.startDate),
      endDate: clearEndDate ? null : (endDate ?? this.endDate),
      statusFilter: statusFilter ?? this.statusFilter,
      allTransactions: allTransactions ?? this.allTransactions,
      filteredTransactions: filteredTransactions ?? this.filteredTransactions,
      selectedTransaction: clearSelectedTransaction
          ? null
          : (selectedTransaction ?? this.selectedTransaction),
      isHistoryShown: isHistoryShown ?? this.isHistoryShown,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    activeSource,
    posOrderCount,
    onlineOrderCount,
    isFilterExpanded,
    searchQuery,
    startDate,
    endDate,
    statusFilter,
    allTransactions,
    filteredTransactions,
    selectedTransaction,
    isHistoryShown,
    errorMessage,
  ];
}
