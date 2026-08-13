import 'package:drift/drift.dart';

import 'package:pos/core/database/connection/connection.dart';
import 'package:pos/core/database/tables/master/master_bank.dart';
import 'package:pos/core/database/tables/master/master_city.dart';
import 'package:pos/core/database/tables/master/master_district.dart';
import 'package:pos/core/database/tables/master/master_province.dart';
import 'package:pos/core/database/tables/master/master_village.dart';

part 'master_database.g.dart';

@DriftDatabase(
  tables: [TableCity, TableProvince, TableVillage, TableDistrict, TableBank],
)
class MasterDatabase extends _$MasterDatabase {
  MasterDatabase()
    : super(connectDatabase('db_master.sqlite', fromAssets: true));

  @override
  int get schemaVersion => 1;
}
