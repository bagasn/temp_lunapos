import 'package:drift/drift.dart';

@DataClassName('banks')
class TableBank extends Table {
  @override
  String? get tableName => 'banks';

  TextColumn get id => text()();
  TextColumn get bankName => text()();
  RealColumn get code => real()();
  RealColumn get transferCode => real()();

  @override
  Set<Column> get primaryKey => {id};
}
