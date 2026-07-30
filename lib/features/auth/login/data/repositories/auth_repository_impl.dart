import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/local_storage/session_manager.dart';
import 'package:pos/features/auth/login/data/datasources/auth_remote_datasource.dart';
import 'package:pos/features/auth/login/data/models/token_response_model.dart';
import 'package:pos/features/auth/login/domain/entities/token_entity.dart';
import 'package:pos/features/auth/login/domain/repositories/auth_repository.dart';
import 'package:pos/features/auth/select_outlet/data/models/outlet_model.dart';
import 'package:pos/features/auth/select_outlet/domain/entities/outlet_entity.dart';
import 'package:pos/shared/domain/entities/failure.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _datasource;
  final SessionManager _sessionManager;

  AuthRepositoryImpl(this._datasource, this._sessionManager);

  @override
  Future<Either<Failure, TokenEntity>> loginWithPassword({
    required String username,
    required String password,
  }) async {
    try {
      final model = await _datasource.loginWithPassword(
        username: username,
        password: password,
      );
      await _sessionManager.auth.saveUserToken(
        accessToken: model.accessToken,
        refreshToken: model.refreshToken ?? '',
      );
      return Right(_mapToEntity(model));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Login failed'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OutletEntity>>> getOutlets(
    String accessToken,
  ) async {
    try {
      final models = await _datasource.getOutlets(accessToken);
      return Right(models.map(_mapOutletToEntity).toList());
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to get outlets'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TokenEntity>> selectOutlet({
    required String posAuthKey,
  }) async {
    try {
      final model = await _datasource.loginWithAuthKey(posAuthKey: posAuthKey);
      await _sessionManager.auth.saveOutletToken(
        accessToken: model.accessToken,
        refreshToken: model.refreshToken ?? '',
        companyId: model.companyId ?? '',
        outletId: model.outletId ?? '',
        outletName: model.outletName ?? '',
      );
      return Right(_mapToEntity(model));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to select outlet'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  TokenEntity _mapToEntity(TokenResponseModel model) => TokenEntity(
        accessToken: model.accessToken,
        refreshToken: model.refreshToken,
        companyId: model.companyId,
        outletId: model.outletId,
        outletName: model.outletName,
        hasCompany: model.hasCompany,
      );

  OutletEntity _mapOutletToEntity(OutletModel model) => OutletEntity(
        outletId: model.outletId ?? '',
        outletName: model.outletName ?? '',
        companyName: model.companyName ?? '',
        posAuthKey: model.posAuthKey ?? '',
        outletPictureUrl: model.outletPicture?.largeUrl,
        subscriptionDueDate: model.subscriptionDueDate,
      );
}
