import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/auth/select_outlet/domain/entities/auth_outlet_entity.dart';
import 'package:pos/features/auth/select_outlet/domain/repositories/auth_outlet_repository.dart';
import 'package:pos/shared/data/response/token_response.dart';
import 'package:pos/shared/domain/entities/failure.dart';
import 'package:pos/shared/domain/usecases/usecase.dart';

final class GetAuthOutletParams {
  final String tokenAuth;

  const GetAuthOutletParams(this.tokenAuth);
}

@injectable
class GetAuthOutletUsecase
    extends UseCase<List<AuthOutletEntity>, GetAuthOutletParams> {
  final AuthOutletRepository _repository;

  GetAuthOutletUsecase(this._repository);

  @override
  Future<Either<Failure, List<AuthOutletEntity>>> call(
    GetAuthOutletParams params,
  ) {
    return _repository.getOutlets(tokenAuth: params.tokenAuth);
  }
}

final class OutletLoginParams {
  final AuthOutletEntity outlet;

  const OutletLoginParams(this.outlet);
}

class OutletLoginUseCase extends UseCase<TokenResponse, OutletLoginParams> {
  @override
  Future<Either<Failure, TokenResponse>> call(OutletLoginParams params) {
    throw UnimplementedError();
  }
}
