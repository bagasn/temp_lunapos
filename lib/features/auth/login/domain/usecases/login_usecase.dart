import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/auth/login/domain/entities/login_entity.dart';
import 'package:pos/features/auth/login/domain/repositories/login_repository.dart';
import 'package:pos/shared/domain/entities/failure.dart';
import 'package:pos/shared/domain/usecases/usecase.dart';

class LoginParams {
  final String username;
  final String password;
  const LoginParams({required this.username, required this.password});
}

@injectable
class LoginUseCase extends UseCase<LoginEntity, LoginParams> {
  final LoginRepository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, LoginEntity>> call(LoginParams params) => _repository
      .loginWithPassword(username: params.username, password: params.password);
}
