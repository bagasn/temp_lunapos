import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/sync/domain/repositories/sync_repository.dart';
import 'package:pos/shared/domain/entities/failure.dart';
import 'package:pos/shared/domain/usecases/usecase.dart';

class SyncParams {
  final bool force;
  const SyncParams({this.force = false});
}

@injectable
class ExecuteSyncUseCase extends UseCase<String, SyncParams> {
  final SyncRepository _repository;
  ExecuteSyncUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(SyncParams params) =>
      _repository.executeSync(force: params.force);
}
