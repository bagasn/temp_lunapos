import 'package:drift/drift.dart';

@DataClassName('paymentMethods')
class TablePaymentMethod extends Table {
  TextColumn get paymentMethodId => text()();
  TextColumn get paymentMethodType => text()();
  TextColumn get paymentMethodName => text()();
  TextColumn get paymentAccountId => text()();
  BoolColumn get isDefaultCash => boolean()();
  IntColumn get sortOrder => integer()();
  BoolColumn get deleted => boolean()();

  @override
  Set<Column> get primaryKey => {paymentMethodId};
}
