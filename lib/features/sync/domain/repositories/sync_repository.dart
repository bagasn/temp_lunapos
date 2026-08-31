import 'package:dartz/dartz.dart';
import 'package:pos/shared/domain/entities/failure.dart';

abstract class SyncRepository {
  Future<Either<Failure, bool>> getInitialData();
  Future<Either<Failure, bool>> getInitialDataProduct();
  Future<Either<Failure, bool>> getInitialDataPromo();
}
