import 'package:dartz/dartz.dart';
import 'package:pos/shared/domain/entities/failure.dart';

abstract class SettingsRepository {
  Future<Either<Failure, bool>> getAutoLockScreen();
  Future<Either<Failure, void>> updateAutoLockScreen(bool value);
}
