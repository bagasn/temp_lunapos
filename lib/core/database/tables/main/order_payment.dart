import 'package:drift/drift.dart';

@DataClassName('OrderPayments')
class TableOrderPayment extends Table {
  @override
  String get tableName => 'orderPayments';

  TextColumn get orderId => text().nullable()();
  TextColumn get paymentMethodId => text().nullable()();
  TextColumn get paymentAccountId => text().nullable()();
  RealColumn get paymentAmount => real().nullable()();
  TextColumn get cardNumber => text().nullable()();
  TextColumn get cardHolder => text().nullable()();
  TextColumn get referenceNumber => text().nullable()();
  TextColumn get partnerId => text().nullable()();
  TextColumn get partnerPaymentMethodId => text().nullable()();
  TextColumn get partnerPaymentMethodName => text().nullable()();
  TextColumn get partnerTransactionId => text().nullable()();
  TextColumn get otherPartyId => text().nullable()();
  TextColumn get depositId => text().nullable()();
  TextColumn get depositNumber => text().nullable()();
  IntColumn get sortOrder => integer().nullable()();
  TextColumn get order => text()();
  TextColumn get paymentMethod => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
