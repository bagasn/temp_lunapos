import 'package:drift/drift.dart';

@DataClassName('Bank')
class TableBank extends Table {
  TextColumn get id => text()();
  TextColumn get bankName => text()();
  RealColumn get code => real()();
  RealColumn get transferCode => real()();

  @override
  Set<Column> get primaryKey => {id};
}
