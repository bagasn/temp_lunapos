import 'package:drift/drift.dart';

@DataClassName('ShiftSessions')
class TableShiftSession extends Table {
  @override
  String get tableName => 'shiftSessions';

  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get shiftOpeningDate => dateTime().nullable()();
  DateTimeColumn get shiftClosingDate => dateTime().nullable()();
  RealColumn get cashOnOpening => real().withDefault(const Constant(0))();
  RealColumn get cashOnClosing => real().withDefault(const Constant(0))();
  RealColumn get paymentCashTotal => real().withDefault(const Constant(0))();
  RealColumn get otherPaymentTotal => real().withDefault(const Constant(0))();
  RealColumn get balance => real().withDefault(const Constant(0))();
  RealColumn get difference => real().withDefault(const Constant(0))();
  IntColumn get totalTransaction => integer().withDefault(const Constant(0))();
  RealColumn get spendMoney => real()();
  BoolColumn get isSync => boolean().withDefault(const Constant(false))();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
