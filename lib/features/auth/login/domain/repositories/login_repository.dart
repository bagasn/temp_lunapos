import 'package:dartz/dartz.dart';
import 'package:pos/features/auth/login/domain/entities/login_entity.dart';
import 'package:pos/shared/domain/entities/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginEntity>> loginWithPassword({
    required String username,
    required String password,
  });
}
