import 'package:dartz/dartz.dart';
import 'package:pos/features/pos/domain/entities/product_entity.dart';
import 'package:pos/shared/domain/entities/failure.dart';

abstract class PosProductRepository {
  Future<Either<Failure, List<PosProductEntity>>> getProducts({
    required int limit,
    required int offset,
    String? searchQuery,
  });
}
