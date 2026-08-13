import 'package:drift/drift.dart';

@DataClassName('OrderPayment')
class TableOrderPayment extends Table {
  TextColumn get orderId => text()();
  TextColumn get paymentMethodId => text()();
  TextColumn get paymentAccountId => text()();
  RealColumn get paymentAmount => real()();
  TextColumn get cardNumber => text()();
  TextColumn get cardHolder => text()();
  TextColumn get referenceNumber => text()();
  TextColumn get partnerId => text()();
  TextColumn get partnerPaymentMethodId => text()();
  TextColumn get partnerPaymentMethodName => text()();
  TextColumn get partnerTransactionId => text()();
  TextColumn get otherPartyId => text()();
  TextColumn get depositId => text()();
  TextColumn get depositNumber => text()();
  RealColumn get sortOrder => real()();
  TextColumn get order => text()();
  TextColumn get paymentMethod => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
