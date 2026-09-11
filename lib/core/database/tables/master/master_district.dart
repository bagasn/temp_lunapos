import 'package:drift/drift.dart';

@DataClassName('districts')
class TableDistrict extends Table {
  @override
  String? get tableName => 'districts';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get cityId => integer()();
  TextColumn get name => text()();
}
