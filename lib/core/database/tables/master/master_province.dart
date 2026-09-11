import 'package:drift/drift.dart';

@DataClassName('provinces')
class TableProvince extends Table {
  @override
  String? get tableName => 'provinces';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}
