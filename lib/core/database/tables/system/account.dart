import 'package:drift/drift.dart';

@DataClassName('Account')
class TableAccount extends Table {
  TextColumn get id => text()();
  TextColumn get systemSetting => text()();
  TextColumn get companyId => text()();
  TextColumn get outletId => text()();
  TextColumn get lastUserId => text()();
  TextColumn get companyName => text()();
  TextColumn get outletName => text()();
  TextColumn get authKey => text()();
  TextColumn get accessToken => text()();
  TextColumn get refreshToken => text()();
  TextColumn get accessTokenTenant => text()();
  TextColumn get refreshTokenTenant => text()();
  TextColumn get lunaOneAccessToken => text()();
  TextColumn get lunaOneRefreshToken => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
