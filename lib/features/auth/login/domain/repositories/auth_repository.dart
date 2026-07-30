import 'package:dartz/dartz.dart';
import 'package:pos/features/auth/login/domain/entities/token_entity.dart';
import 'package:pos/features/auth/select_outlet/domain/entities/outlet_entity.dart';
import 'package:pos/shared/domain/entities/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, TokenEntity>> loginWithPassword({
    required String username,
    required String password,
  });

  Future<Either<Failure, List<OutletEntity>>> getOutlets(String accessToken);

  Future<Either<Failure, TokenEntity>> selectOutlet({
    required String posAuthKey,
  });
}
