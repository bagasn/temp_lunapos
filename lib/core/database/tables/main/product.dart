import 'package:drift/drift.dart';

@DataClassName('products')
class TableProduct extends Table {
  TextColumn get id => text()();
  TextColumn get sku => text()();
  TextColumn get name => text()();
  TextColumn get detailDescription => text()();
  BoolColumn get serviceCharged => boolean()();
  TextColumn get salesTaxId => text()();
  TextColumn get uom => text()();
  RealColumn get modifierCount => real()();
  BoolColumn get hasVariants => boolean()();
  RealColumn get variantCount => real()();
  TextColumn get variantAttribute1 => text()();
  TextColumn get variantAttribute2 => text()();
  TextColumn get variantAttribute3 => text()();
  TextColumn get masterVariantId => text()();
  TextColumn get pictureUrl => text()();
  TextColumn get pictureLocal => text()();
  TextColumn get printerAreaId => text()();
  TextColumn get printerItemAreaId => text()();
  BoolColumn get isFavorite => boolean()();
  BoolColumn get isOutOfStock => boolean()();
  BoolColumn get deleted => boolean()();
  BoolColumn get availableForAllPosUsers => boolean()();
  BoolColumn get isDiscountDisabled => boolean()();
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
