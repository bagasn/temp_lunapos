import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:pos/features/settings/domain/entities/setting_order_entity.dart';
import 'package:pos/features/settings/domain/repositories/settings_repository.dart';
import 'package:pos/shared/domain/entities/failure.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _dataSource;

  SettingsRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, bool>> getAutoLockScreen() async {
    try {
      final result = await _dataSource.getAutoLockScreen();
      return Right(result);
    } catch (e, stack) {
      return Left(DatabaseFailure('Gagal mendapatkan auto lock setting: $e\n$stack'));
    }
  }

  @override
  Future<Either<Failure, void>> updateAutoLockScreen(bool value) async {
    try {
      await _dataSource.updateAutoLockScreen(value);
      return const Right(null);
    } catch (e, stack) {
      return Left(DatabaseFailure('Gagal mengubah auto lock setting: $e\n$stack'));
    }
  }

  @override
  Future<Either<Failure, SettingOrderEntity>> getOrderSettings() async {
    try {
      final result = await _dataSource.getOrderSettings();
      return Right(result);
    } catch (e, stack) {
      return Left(DatabaseFailure('Gagal mendapatkan order settings: $e\n$stack'));
    }
  }

  @override
  Future<Either<Failure, void>> updateOrderSettings(SettingOrderEntity settings) async {
    try {
      await _dataSource.updateOrderSettings(settings);
      return const Right(null);
    } catch (e, stack) {
      return Left(DatabaseFailure('Gagal mengubah order settings: $e\n$stack'));
    }
  }
}
