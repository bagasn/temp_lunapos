import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/pos/data/datasources/pos_order_local_datasource.dart';
import 'package:pos/features/pos/domain/entities/pos_order_entity.dart';
import 'package:pos/features/pos/domain/repositories/pos_order_repository.dart';
import 'package:pos/shared/domain/entities/failure.dart';

@LazySingleton(as: PosOrderRepository)
class PosOrderRepositoryImpl implements PosOrderRepository {
  final PosOrderLocalDataSource _dataSource;
  PosOrderRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, void>> saveOrder(PosOrderEntity order) async {
    try {
      await _dataSource.saveOrder(order);
      return const Right(null);
    } catch (e, stack) {
      return Left(DatabaseFailure('Gagal menyimpan order: $e\n$stack'));
    }
  }
}
