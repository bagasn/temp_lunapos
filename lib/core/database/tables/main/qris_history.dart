import 'package:drift/drift.dart';

@DataClassName('qrisHistories')
class TableQrisHistory extends Table {
  @override
  String get tableName => 'qrisHistories';

  TextColumn get id => text()();
  TextColumn get id_transaction_pos => text()();
  IntColumn get tenantId => integer().nullable()();
  IntColumn get outletId => integer().nullable()();
  DateTimeColumn get createDateUtc => dateTime().nullable()();
  DateTimeColumn get updatedDateUtc => dateTime().nullable()();
  TextColumn get transactionNumber => text().nullable()();
  TextColumn get description => text().nullable()();
  IntColumn get transactionAmount => integer().nullable()();
  IntColumn get mdrRate => integer().nullable()();
  IntColumn get mdrAmount => integer().nullable()();
  IntColumn get transactionTotal => integer().nullable()();
  IntColumn get refundAmount => integer().nullable()();
  TextColumn get transactionDate => text().nullable()();
  TextColumn get transactionTime => text().nullable()();
  DateTimeColumn get transactionDateUtc => dateTime().nullable()();
  TextColumn get paymentDate => text().nullable()();
  TextColumn get paymentTime => text().nullable()();
  DateTimeColumn get paymentDateUtc => dateTime().nullable()();
  TextColumn get paymentMethodId => text().nullable()();
  TextColumn get subPaymentMethod => text().nullable()();
  TextColumn get bankAcquirerId => text().nullable()();
  TextColumn get internalTransactionId => text().nullable()();
  TextColumn get bankTransactionId => text().nullable()();
  TextColumn get bankReferenceNumber => text().nullable()();
  TextColumn get bankQrCode => text().nullable()();
  TextColumn get bankApprovalDate => text().nullable()();
  BoolColumn get isClientTransactionType => boolean().nullable()();
  TextColumn get clientTransactionType => text().nullable()();
  TextColumn get clientTransactionId => text().nullable()();
  TextColumn get createUserId => text().nullable()();
  TextColumn get createUserDeviceId => text().nullable()();
  IntColumn get statusQris => integer().nullable()();
  TextColumn get orderNumberPos => text()();
  BoolColumn get isSync => boolean().withDefault(const Constant(false))();
  DateTimeColumn get syncDate => dateTime().nullable()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
