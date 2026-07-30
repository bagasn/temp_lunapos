import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderLineModel {
  final String id;
  final String productId;
  final String productName;
  final num unitPrice;
  final num quantity;
  final num subTotal;
  final num discountAmount;
  final String? notes;
  final List<Map<String, dynamic>>? modifiers;

  const OrderLineModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.subTotal,
    this.discountAmount = 0,
    this.notes,
    this.modifiers,
  });

  factory OrderLineModel.fromJson(Map<String, dynamic> json) =>
      _$OrderLineModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderLineModelToJson(this);

  OrderLineModel copyWith({
    num? quantity,
    num? subTotal,
    String? notes,
  }) {
    return OrderLineModel(
      id: id,
      productId: productId,
      productName: productName,
      unitPrice: unitPrice,
      quantity: quantity ?? this.quantity,
      subTotal: subTotal ?? this.subTotal,
      discountAmount: discountAmount,
      notes: notes ?? this.notes,
      modifiers: modifiers,
    );
  }
}

class OrderModel {
  final String id;
  final String? orderName;
  final String? salesTypeId;
  final String? customerId;
  final String? tableId;
  final int numOfPax;
  final String status; // 'active' | 'saved' | 'paid' | 'cancelled'
  final DateTime createdAt;
  final DateTime updatedAt;
  final num subTotal;
  final num totalTax;
  final num totalDiscount;
  final num grandTotal;
  final List<OrderLineModel> orderLines;

  const OrderModel({
    required this.id,
    this.orderName,
    this.salesTypeId,
    this.customerId,
    this.tableId,
    this.numOfPax = 1,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.subTotal = 0,
    this.totalTax = 0,
    this.totalDiscount = 0,
    this.grandTotal = 0,
    this.orderLines = const [],
  });

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'orderName': orderName,
      'salesTypeId': salesTypeId,
      'customerId': customerId,
      'tableId': tableId,
      'numOfPax': numOfPax,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'subTotal': subTotal,
      'totalTax': totalTax,
      'totalDiscount': totalDiscount,
      'grandTotal': grandTotal,
      'orderLines': orderLines.map((l) => l.toJson()).toList(),
    };
  }

  factory OrderModel.fromFirestore(Map<String, dynamic> data) {
    final lines = (data['orderLines'] as List? ?? [])
        .map((l) => OrderLineModel.fromJson(l as Map<String, dynamic>))
        .toList();

    return OrderModel(
      id: data['id'] as String? ?? '',
      orderName: data['orderName'] as String?,
      salesTypeId: data['salesTypeId'] as String?,
      customerId: data['customerId'] as String?,
      tableId: data['tableId'] as String?,
      numOfPax: (data['numOfPax'] as num?)?.toInt() ?? 1,
      status: data['status'] as String? ?? 'active',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      subTotal: data['subTotal'] as num? ?? 0,
      totalTax: data['totalTax'] as num? ?? 0,
      totalDiscount: data['totalDiscount'] as num? ?? 0,
      grandTotal: data['grandTotal'] as num? ?? 0,
      orderLines: lines,
    );
  }

  OrderModel copyWith({
    String? orderName,
    String? status,
    List<OrderLineModel>? orderLines,
    num? subTotal,
    num? grandTotal,
    DateTime? updatedAt,
  }) {
    return OrderModel(
      id: id,
      orderName: orderName ?? this.orderName,
      salesTypeId: salesTypeId,
      customerId: customerId,
      tableId: tableId,
      numOfPax: numOfPax,
      status: status ?? this.status,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      subTotal: subTotal ?? this.subTotal,
      totalTax: totalTax,
      totalDiscount: totalDiscount,
      grandTotal: grandTotal ?? this.grandTotal,
      orderLines: orderLines ?? this.orderLines,
    );
  }
}
