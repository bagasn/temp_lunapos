import 'package:drift/drift.dart';

@DataClassName('cities')
class TableCity extends Table {
  @override
  String? get tableName => 'cities';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get provinceId => integer()();
  TextColumn get name => text()();
}
