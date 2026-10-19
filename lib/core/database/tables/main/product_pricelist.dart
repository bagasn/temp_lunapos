import 'package:drift/drift.dart';

@DataClassName('Pricelists')
class TableProductPricelist extends Table {
  @override
  String get tableName => 'pricelists';

  TextColumn get productId => text()();
  TextColumn get productVariantId => text()();
  TextColumn get salesTypeId => text()();
  TextColumn get salesTypeName => text().nullable()();
  RealColumn get price => real().nullable()();
  BoolColumn get isMaster => boolean().nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
