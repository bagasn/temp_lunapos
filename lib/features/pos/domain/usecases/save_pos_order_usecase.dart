import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/pos/domain/entities/pos_order_entity.dart';
import 'package:pos/features/pos/domain/repositories/pos_order_repository.dart';
import 'package:pos/shared/domain/entities/failure.dart';
import 'package:pos/shared/domain/usecases/usecase.dart';

@injectable
class SavePosOrderUseCase extends UseCase<void, PosOrderEntity> {
  final PosOrderRepository _repository;
  SavePosOrderUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(PosOrderEntity params) =>
      _repository.saveOrder(params);
}
