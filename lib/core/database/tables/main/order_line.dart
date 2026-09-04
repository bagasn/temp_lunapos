import 'package:drift/drift.dart';

@DataClassName('orderLines')
class TableOrderLine extends Table {
  @override
  String get tableName => 'orderLines';

  TextColumn get id => text()();
  TextColumn get orderId => text()();
  TextColumn get productId => text()();
  TextColumn get productVariantId => text()();
  TextColumn get description => text()();
  RealColumn get qty => real()();
  RealColumn get unitPrice => real()();
  RealColumn get modifierPrice => real()();
  TextColumn get discountId => text()();
  RealColumn get discountPercent => real()();
  RealColumn get discountAmount => real()();
  RealColumn get totalBeforeDiscount => real()();
  RealColumn get totalDiscountAmount => real()();
  RealColumn get total => real()();
  BoolColumn get serviceCharged => boolean()();
  BoolColumn get taxed => boolean()();
  TextColumn get taxId => text()();
  TextColumn get notes => text()();
  RealColumn get sortOrder => real()();
  TextColumn get createdByUserId => text()();
  DateTimeColumn get createdDateTime => dateTime()();
  TextColumn get lastUpdateByUserId => text()();
  DateTimeColumn get lastUpdateDateTime => dateTime()();
  BoolColumn get cancelled => boolean()();
  TextColumn get cancelledByUserId => text()();
  DateTimeColumn get cancellationDate => dateTime()();
  DateTimeColumn get cancellationDateTime => dateTime()();
  TextColumn get cancellationReason => text()();
  TextColumn get lineType => text()();
  TextColumn get itemType => text()();
  TextColumn get promoId => text()();
  TextColumn get promoName => text()();
  RealColumn get promoDiscountPercent => real()();
  RealColumn get promoDiscountAmount => real()();
  BoolColumn get isPromoReward => boolean()();
  TextColumn get relatedTo => text()();
  TextColumn get rewardIds => text()();
  BoolColumn get haveCommission => boolean()();
  TextColumn get priceTierId => text()();
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
