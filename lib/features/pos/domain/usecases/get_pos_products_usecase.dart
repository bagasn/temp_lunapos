import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/pos/domain/entities/product_entity.dart';
import 'package:pos/features/pos/domain/repositories/pos_product_repository.dart';
import 'package:pos/shared/domain/entities/failure.dart';
import 'package:pos/shared/domain/usecases/usecase.dart';

class GetPosProductsParams {
  final int limit;
  final int offset;
  final String? searchQuery;

  const GetPosProductsParams({
    required this.limit,
    required this.offset,
    this.searchQuery,
  });
}

@injectable
class GetPosProductsUseCase
    extends UseCase<List<PosProductEntity>, GetPosProductsParams> {
  final PosProductRepository _repository;

  GetPosProductsUseCase(this._repository);

  @override
  Future<Either<Failure, List<PosProductEntity>>> call(
    GetPosProductsParams params,
  ) {
    return _repository.getProducts(
      limit: params.limit,
      offset: params.offset,
      searchQuery: params.searchQuery,
    );
  }
}
