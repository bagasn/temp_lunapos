import 'package:dartz/dartz.dart';
import 'package:pos/shared/domain/entities/failure.dart';

abstract class SyncRepository {
  Future<Either<Failure, String>> executeSync({bool force = false});
}
