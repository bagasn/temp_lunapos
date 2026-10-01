import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/settings/domain/repositories/settings_repository.dart';
import 'package:pos/shared/domain/entities/failure.dart';
import 'package:pos/shared/domain/usecases/usecase.dart';

@lazySingleton
class GetAutoLockSetting implements UseCase<bool, NoParams> {
  final SettingsRepository repository;

  GetAutoLockSetting(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.getAutoLockScreen();
  }
}
