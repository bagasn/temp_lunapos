import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/settings/domain/entities/setting_order_entity.dart';
import 'package:pos/features/settings/domain/repositories/settings_repository.dart';
import 'package:pos/shared/domain/entities/failure.dart';
import 'package:pos/shared/domain/usecases/usecase.dart';

@lazySingleton
class GetOrderSettings implements UseCase<SettingOrderEntity, NoParams> {
  final SettingsRepository _repository;

  GetOrderSettings(this._repository);

  @override
  Future<Either<Failure, SettingOrderEntity>> call(NoParams params) {
    return _repository.getOrderSettings();
  }
}
