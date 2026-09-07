import 'package:drift/drift.dart';

@DataClassName('orderLines')
class TableOrderLine extends Table {
  @override
  String get tableName => 'orderLines';

  TextColumn get id => text()();
  TextColumn get orderId => text()();
  TextColumn get productId => text().nullable()();
  TextColumn get productVariantId => text().nullable()();
  TextColumn get description => text().nullable()();
  RealColumn get qty => real().nullable()();
  RealColumn get unitPrice => real().nullable()();
  RealColumn get modifierPrice => real().nullable()();
  TextColumn get discountId => text().nullable()();
  RealColumn get discountPercent => real().nullable()();
  RealColumn get discountAmount => real().nullable()();
  RealColumn get totalBeforeDiscount => real().nullable()();
  RealColumn get totalDiscountAmount => real().nullable()();
  RealColumn get total => real().nullable()();
  BoolColumn get serviceCharged => boolean().nullable()();
  BoolColumn get taxed => boolean().nullable()();
  TextColumn get taxId => text().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get sortOrder => integer().nullable()();
  TextColumn get createdByUserId => text().nullable()();
  DateTimeColumn get createdDateTime => dateTime().nullable()();
  TextColumn get lastUpdateByUserId => text().nullable()();
  DateTimeColumn get lastUpdateDateTime => dateTime().nullable()();
  BoolColumn get cancelled => boolean().withDefault(const Constant(false))();
  TextColumn get cancelledByUserId => text().nullable()();
  DateTimeColumn get cancellationDate => dateTime()();
  DateTimeColumn get cancellationDateTime => dateTime().nullable()();
  TextColumn get cancellationReason => text().nullable()();
  TextColumn get lineType => text().withDefault(const Constant('item'))();
  TextColumn get itemType => text().withDefault(const Constant('item'))();
  TextColumn get promoId => text().nullable()();
  TextColumn get promoName => text().nullable()();
  RealColumn get promoDiscountPercent => real().nullable()();
  RealColumn get promoDiscountAmount => real().nullable()();
  BoolColumn get isPromoReward => boolean().withDefault(const Constant(false))();
  TextColumn get relatedTo => text().nullable()();
  TextColumn get rewardIds => text()();
  BoolColumn get haveCommission => boolean().nullable()();
  TextColumn get priceTierId => text().nullable()();
  TextColumn get order => text()();
  TextColumn get product => text()();
  TextColumn get productVariant => text()();
  TextColumn get discount => text()();
  TextColumn get tax => text()();
  TextColumn get createdByUser => text()();
  TextColumn get lastUpdateByUser => text()();
  TextColumn get cancelledByUser => text()();
  TextColumn get modifiers => text()();
  TextColumn get priceTier => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
