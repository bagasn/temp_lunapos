import 'package:drift/drift.dart';

@DataClassName('products')
class TableProduct extends Table {
  @override
  String get tableName => 'products';

  TextColumn get id => text()();
  TextColumn get sku => text().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get detailDescription => text().nullable()();
  BoolColumn get serviceCharged => boolean().nullable()();
  TextColumn get salesTaxId => text().nullable()();
  TextColumn get uom => text().nullable()();
  IntColumn get modifierCount => integer().nullable()();
  BoolColumn get hasVariants => boolean().nullable()();
  IntColumn get variantCount => integer().nullable()();
  TextColumn get variantAttribute1 => text().nullable()();
  TextColumn get variantAttribute2 => text().nullable()();
  TextColumn get variantAttribute3 => text().nullable()();
  TextColumn get masterVariantId => text().nullable()();
  TextColumn get pictureUrl => text().nullable()();
  TextColumn get pictureLocal => text().nullable()();
  TextColumn get printerAreaId => text().nullable()();
  TextColumn get printerItemAreaId => text().nullable()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  BoolColumn get isOutOfStock => boolean().withDefault(const Constant(false))();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
  BoolColumn get availableForAllPosUsers => boolean().nullable()();
  BoolColumn get isDiscountDisabled => boolean().nullable()();
  TextColumn get salesTax => text()();
  TextColumn get categories => text()();
  TextColumn get modifiers => text()();
  TextColumn get productVariants => text()();
  TextColumn get printerArea => text()();
  TextColumn get printerItemArea => text()();
  TextColumn get priceTiers => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
