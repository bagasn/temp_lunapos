import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/pos/data/datasources/pos_product_local_datasource.dart';
import 'package:pos/features/pos/domain/entities/product_entity.dart';
import 'package:pos/features/pos/domain/repositories/pos_product_repository.dart';
import 'package:pos/shared/domain/entities/failure.dart';

@LazySingleton(as: PosProductRepository)
class PosProductRepositoryImpl implements PosProductRepository {
  final PosProductLocalDataSource _localDataSource;

  PosProductRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, List<PosProductEntity>>> getProducts({
    required int limit,
    required int offset,
    String? searchQuery,
  }) async {
    try {
      final result = await _localDataSource.getProducts(
        limit: limit,
        offset: offset,
        searchQuery: searchQuery,
      );
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
