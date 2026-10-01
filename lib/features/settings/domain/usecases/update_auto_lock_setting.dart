import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/settings/domain/repositories/settings_repository.dart';
import 'package:pos/shared/domain/entities/failure.dart';
import 'package:pos/shared/domain/usecases/usecase.dart';

@lazySingleton
class UpdateAutoLockSetting implements UseCase<void, UpdateAutoLockParams> {
  final SettingsRepository repository;

  UpdateAutoLockSetting(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateAutoLockParams params) async {
    return await repository.updateAutoLockScreen(params.value);
  }
}

class UpdateAutoLockParams extends Equatable {
  final bool value;

  const UpdateAutoLockParams({required this.value});

  @override
  List<Object> get props => [value];
}
