import 'package:drift/drift.dart';

@DataClassName('qrisHistories')
class TableQrisHistory extends Table {
  TextColumn get id => text()();
  TextColumn get id_transaction_pos => text()();
  RealColumn get tenantId => real()();
  RealColumn get outletId => real()();
  DateTimeColumn get createDateUtc => dateTime()();
  DateTimeColumn get updatedDateUtc => dateTime()();
  TextColumn get transactionNumber => text()();
  TextColumn get description => text()();
  RealColumn get transactionAmount => real()();
  RealColumn get mdrRate => real()();
  RealColumn get mdrAmount => real()();
  RealColumn get transactionTotal => real()();
  RealColumn get refundAmount => real()();
  TextColumn get transactionDate => text()();
  TextColumn get transactionTime => text()();
  DateTimeColumn get transactionDateUtc => dateTime()();
  TextColumn get paymentDate => text()();
  TextColumn get paymentTime => text()();
  DateTimeColumn get paymentDateUtc => dateTime()();
  TextColumn get paymentMethodId => text()();
  TextColumn get subPaymentMethod => text()();
  TextColumn get bankAcquirerId => text()();
  TextColumn get internalTransactionId => text()();
  TextColumn get bankTransactionId => text()();
  TextColumn get bankReferenceNumber => text()();
  TextColumn get bankQrCode => text()();
  TextColumn get bankApprovalDate => text()();
  BoolColumn get isClientTransactionType => boolean()();
  TextColumn get clientTransactionType => text()();
  TextColumn get clientTransactionId => text()();
  TextColumn get createUserId => text()();
  TextColumn get createUserDeviceId => text()();
  RealColumn get statusQris => real()();
  TextColumn get orderNumberPos => text()();
  BoolColumn get isSync => boolean()();
  DateTimeColumn get syncDate => dateTime()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
