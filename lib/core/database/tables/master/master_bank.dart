import 'package:drift/drift.dart';

@DataClassName('banks')
class TableBank extends Table {
  @override
  String? get tableName => 'banks';

  TextColumn get id => text()();
  TextColumn get bankName => text()();
  IntColumn get code => integer()();
  IntColumn get transferCode => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
