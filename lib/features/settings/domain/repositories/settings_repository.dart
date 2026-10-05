import 'package:dartz/dartz.dart';
import 'package:pos/features/settings/domain/entities/setting_order_entity.dart';
import 'package:pos/shared/domain/entities/failure.dart';

abstract class SettingsRepository {
  Future<Either<Failure, bool>> getAutoLockScreen();
  Future<Either<Failure, void>> updateAutoLockScreen(bool value);

  Future<Either<Failure, SettingOrderEntity>> getOrderSettings();
  Future<Either<Failure, void>> updateOrderSettings(SettingOrderEntity settings);
}
