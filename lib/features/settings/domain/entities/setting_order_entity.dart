import 'package:equatable/equatable.dart';

/// Entity representing all Order Settings stored in the local database
/// and preferences.
class SettingOrderEntity extends Equatable {
  /// Default view mode: 0 = Order, 1 = Table, 2 = Queue
  final int defaultView;
  final bool customerRequired;
  final bool shiftSessionRequired;

  /// Stored as inverse of `hideFinalCashEndShift` in DB.
  final bool showCashDetail;
  final bool roundOrderTotal;

  /// Rounding type: 0 = Round Up, 1 = Round Down, 2 = Round to Nearest.
  final int roundingType;

  /// Rounding base value (e.g. 500 → round to the nearest Rp 500).
  final int roundingBase;
  final bool queueNumbering;

  /// Maximum queue number before the counter resets.
  final int maxQueueNumber;

  /// Last issued queue number. Read-only in Settings; it is a runtime counter
  /// maintained by the order flow, so it is never written from this section.
  final int? lastQueueNumber;
  final bool addCustomNotes;
  final bool printKitchenSeparately;
  final bool syncOpenOrder;
  final bool cashPayment;
  final bool allowSavingOrders;
  final bool endingShiftNotAllowed;
  final bool tableSelectionRequired;
  final bool showStock;

  const SettingOrderEntity({
    required this.defaultView,
    required this.customerRequired,
    required this.shiftSessionRequired,
    required this.showCashDetail,
    required this.roundOrderTotal,
    required this.roundingType,
    required this.roundingBase,
    required this.queueNumbering,
    required this.maxQueueNumber,
    this.lastQueueNumber,
    required this.addCustomNotes,
    required this.printKitchenSeparately,
    required this.syncOpenOrder,
    required this.cashPayment,
    required this.allowSavingOrders,
    required this.endingShiftNotAllowed,
    required this.tableSelectionRequired,
    required this.showStock,
  });

  /// Default values matching the database column defaults in [TableOutletSetting].
  const SettingOrderEntity.defaults()
      : defaultView = 0,
        customerRequired = false,
        shiftSessionRequired = false,
        showCashDetail = false,
        roundOrderTotal = false,
        roundingType = 0,
        roundingBase = 500,
        queueNumbering = false,
        maxQueueNumber = 50,
        lastQueueNumber = null,
        addCustomNotes = false,
        printKitchenSeparately = false,
        syncOpenOrder = false,
        cashPayment = true,
        allowSavingOrders = true,
        endingShiftNotAllowed = false,
        tableSelectionRequired = false,
        showStock = false;

  SettingOrderEntity copyWith({
    int? defaultView,
    bool? customerRequired,
    bool? shiftSessionRequired,
    bool? showCashDetail,
    bool? roundOrderTotal,
    int? roundingType,
    int? roundingBase,
    bool? queueNumbering,
    int? maxQueueNumber,
    int? lastQueueNumber,
    bool? addCustomNotes,
    bool? printKitchenSeparately,
    bool? syncOpenOrder,
    bool? cashPayment,
    bool? allowSavingOrders,
    bool? endingShiftNotAllowed,
    bool? tableSelectionRequired,
    bool? showStock,
  }) {
    return SettingOrderEntity(
      defaultView: defaultView ?? this.defaultView,
      customerRequired: customerRequired ?? this.customerRequired,
      shiftSessionRequired: shiftSessionRequired ?? this.shiftSessionRequired,
      showCashDetail: showCashDetail ?? this.showCashDetail,
      roundOrderTotal: roundOrderTotal ?? this.roundOrderTotal,
      roundingType: roundingType ?? this.roundingType,
      roundingBase: roundingBase ?? this.roundingBase,
      queueNumbering: queueNumbering ?? this.queueNumbering,
      maxQueueNumber: maxQueueNumber ?? this.maxQueueNumber,
      lastQueueNumber: lastQueueNumber ?? this.lastQueueNumber,
      addCustomNotes: addCustomNotes ?? this.addCustomNotes,
      printKitchenSeparately:
          printKitchenSeparately ?? this.printKitchenSeparately,
      syncOpenOrder: syncOpenOrder ?? this.syncOpenOrder,
      cashPayment: cashPayment ?? this.cashPayment,
      allowSavingOrders: allowSavingOrders ?? this.allowSavingOrders,
      endingShiftNotAllowed:
          endingShiftNotAllowed ?? this.endingShiftNotAllowed,
      tableSelectionRequired:
          tableSelectionRequired ?? this.tableSelectionRequired,
      showStock: showStock ?? this.showStock,
    );
  }

  @override
  List<Object?> get props => [
        defaultView,
        customerRequired,
        shiftSessionRequired,
        showCashDetail,
        roundOrderTotal,
        roundingType,
        roundingBase,
        queueNumbering,
        maxQueueNumber,
        lastQueueNumber,
        addCustomNotes,
        printKitchenSeparately,
        syncOpenOrder,
        cashPayment,
        allowSavingOrders,
        endingShiftNotAllowed,
        tableSelectionRequired,
        showStock,
      ];
}
