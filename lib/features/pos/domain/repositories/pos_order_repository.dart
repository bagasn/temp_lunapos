import 'package:dartz/dartz.dart';
import 'package:pos/features/pos/domain/entities/pos_order_entity.dart';
import 'package:pos/shared/domain/entities/failure.dart';

abstract class PosOrderRepository {
  Future<Either<Failure, void>> saveOrder(PosOrderEntity order);
}
