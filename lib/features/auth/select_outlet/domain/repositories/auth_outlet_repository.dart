import 'package:dartz/dartz.dart';
import 'package:pos/features/auth/select_outlet/domain/entities/auth_outlet_entity.dart';
import 'package:pos/shared/domain/entities/failure.dart';

abstract class AuthOutletRepository {
  Future<Either<Failure, List<AuthOutletEntity>>> getOutlets({
    required String tokenAuth,
  });
}
