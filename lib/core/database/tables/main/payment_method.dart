import 'package:drift/drift.dart';

@DataClassName('PaymentMethods')
class TablePaymentMethod extends Table {
  @override
  String get tableName => 'paymentMethods';

  TextColumn get paymentMethodId => text()();
  TextColumn get paymentMethodType => text().nullable()();
  TextColumn get paymentMethodName => text().nullable()();
  TextColumn get paymentAccountId => text().nullable()();
  BoolColumn get isDefaultCash => boolean().nullable()();
  IntColumn get sortOrder => integer().nullable()();
  BoolColumn get deleted => boolean().nullable()();

  @override
  Set<Column> get primaryKey => {paymentMethodId};
}
