import 'package:dartz/dartz.dart';
import 'package:pos/features/home/domain/entities/product_entity.dart';
import 'package:pos/shared/domain/entities/failure.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
}
