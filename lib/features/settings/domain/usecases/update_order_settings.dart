import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/settings/domain/entities/setting_order_entity.dart';
import 'package:pos/features/settings/domain/repositories/settings_repository.dart';
import 'package:pos/shared/domain/entities/failure.dart';
import 'package:pos/shared/domain/usecases/usecase.dart';

@lazySingleton
class UpdateOrderSettings implements UseCase<void, UpdateOrderSettingsParams> {
  final SettingsRepository _repository;

  UpdateOrderSettings(this._repository);

  @override
  Future<Either<Failure, void>> call(UpdateOrderSettingsParams params) {
    return _repository.updateOrderSettings(params.settings);
  }
}

class UpdateOrderSettingsParams extends Equatable {
  final SettingOrderEntity settings;

  const UpdateOrderSettingsParams({required this.settings});

  @override
  List<Object?> get props => [settings];
}
