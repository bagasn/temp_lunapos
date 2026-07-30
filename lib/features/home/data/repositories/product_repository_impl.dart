import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/home/data/datasources/product_local_datasource.dart';
import 'package:pos/features/home/domain/entities/product_entity.dart';
import 'package:pos/features/home/domain/repositories/product_repository.dart';
import 'package:pos/shared/domain/entities/failure.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDatasource _datasource;
  ProductRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final models = await _datasource.getProducts();
      final entities = models
          .map((m) => ProductEntity(
                id: m.id,
                name: m.name ?? '',
                price: m.price ?? 0,
                pictureUrl: m.pictureUrl,
                sku: m.sku,
                isOutOfStock: m.isOutOfStock ?? false,
                stock: m.stock,
                isFavorite: m.isFavorite ?? false,
              ))
          .toList();
      return Right(entities);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final models = await _datasource.getCategories();
      final entities = models
          .map((m) => CategoryEntity(
                id: m.id,
                name: m.name ?? '',
                sortOrder: (m.sortOrder ?? 0).toInt(),
              ))
          .toList();
      return Right(entities);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
