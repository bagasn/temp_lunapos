import 'package:drift/drift.dart';

@DataClassName('Villages')
class TableVillage extends Table {
  @override
  String? get tableName => 'villages';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get districtId => integer()();
  TextColumn get name => text()();
  TextColumn get zipCode => text()();
}
