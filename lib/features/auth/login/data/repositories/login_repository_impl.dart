import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/local_storage/session_manager.dart';
import 'package:pos/features/auth/login/data/datasources/login_service.dart';
import 'package:pos/features/auth/login/domain/entities/login_entity.dart';
import 'package:pos/features/auth/login/domain/repositories/login_repository.dart';
import 'package:pos/shared/domain/entities/failure.dart';

@LazySingleton(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginService _loginService;
  final SessionManager _sessionManager;

  LoginRepositoryImpl(this._loginService, this._sessionManager);

  @override
  Future<Either<Failure, LoginEntity>> loginWithPassword({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _loginService.loginWithPassword(
        username: username,
        password: password,
      );

      await _sessionManager.auth.saveUserToken(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      return Right(
        LoginEntity(
          accessToken: response.accessToken,
          refreshToken: response.refreshToken,
          companyName: response.companyName,
          hasCompany: response.companyId != null,
        ),
      );
    } catch (e, stack) {
      return Left(NetworkFailure.error(e, stackTrace: stack));
    }
  }
}
