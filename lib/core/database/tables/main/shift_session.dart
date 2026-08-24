import 'package:drift/drift.dart';

@DataClassName('shiftSessions')
class TableShiftSession extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get shiftOpeningDate => dateTime()();
  DateTimeColumn get shiftClosingDate => dateTime()();
  RealColumn get cashOnOpening => real()();
  RealColumn get cashOnClosing => real()();
  RealColumn get paymentCashTotal => real()();
  RealColumn get otherPaymentTotal => real()();
  RealColumn get balance => real()();
  RealColumn get difference => real()();
  RealColumn get totalTransaction => real()();
  RealColumn get spendMoney => real()();
  BoolColumn get isSync => boolean()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
