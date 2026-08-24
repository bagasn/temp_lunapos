import 'package:drift/drift.dart';
import 'package:pos/core/database/connection/connection.dart';
import 'package:pos/core/database/tables/setting/account.dart';
import 'package:pos/core/database/tables/setting/display.dart';
import 'package:pos/core/database/tables/setting/outlet.dart';
import 'package:pos/core/database/tables/setting/system_setting.dart';

part 'setting_database.g.dart';

@DriftDatabase(
  tables: [TableSystemSetting, TableAccount, TableOutlet, TableDisplay],
)
class SettingDatabase extends _$SettingDatabase {
  SettingDatabase() : super(connectDatabase('db_system'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      // if (from < 1) {
      //   await m.createAll();
      // }
    },
  );
}
