import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/auth/login/domain/entities/token_entity.dart';
import 'package:pos/features/auth/login/domain/repositories/auth_repository.dart';
import 'package:pos/features/auth/select_outlet/domain/entities/outlet_entity.dart';
import 'package:pos/shared/domain/entities/failure.dart';
import 'package:pos/shared/domain/usecases/usecase.dart';

class LoginParams {
  final String username;
  final String password;
  const LoginParams({required this.username, required this.password});
}

@injectable
class LoginUseCase extends UseCase<TokenEntity, LoginParams> {
  final AuthRepository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, TokenEntity>> call(LoginParams params) =>
      _repository.loginWithPassword(
        username: params.username,
        password: params.password,
      );
}

class GetOutletsParams {
  final String accessToken;
  const GetOutletsParams(this.accessToken);
}

@injectable
class GetOutletsUseCase extends UseCase<List<OutletEntity>, GetOutletsParams> {
  final AuthRepository _repository;
  GetOutletsUseCase(this._repository);

  @override
  Future<Either<Failure, List<OutletEntity>>> call(GetOutletsParams params) =>
      _repository.getOutlets(params.accessToken);
}

class SelectOutletParams {
  final String posAuthKey;
  const SelectOutletParams(this.posAuthKey);
}

@injectable
class SelectOutletUseCase extends UseCase<TokenEntity, SelectOutletParams> {
  final AuthRepository _repository;
  SelectOutletUseCase(this._repository);

  @override
  Future<Either<Failure, TokenEntity>> call(SelectOutletParams params) =>
      _repository.selectOutlet(posAuthKey: params.posAuthKey);
}
