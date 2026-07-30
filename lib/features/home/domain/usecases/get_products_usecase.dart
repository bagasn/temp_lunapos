import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/home/domain/entities/product_entity.dart';
import 'package:pos/features/home/domain/repositories/product_repository.dart';
import 'package:pos/shared/domain/entities/failure.dart';
import 'package:pos/shared/domain/usecases/usecase.dart';

@injectable
class GetProductsUseCase extends UseCase<List<ProductEntity>, NoParams> {
  final ProductRepository _repository;
  GetProductsUseCase(this._repository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(NoParams params) =>
      _repository.getProducts();
}

@injectable
class GetCategoriesUseCase extends UseCase<List<CategoryEntity>, NoParams> {
  final ProductRepository _repository;
  GetCategoriesUseCase(this._repository);

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams params) =>
      _repository.getCategories();
}
