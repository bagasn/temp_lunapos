import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/local_storage/session_manager.dart';
import 'package:pos/features/auth/select_outlet/data/datasources/select_outlet_service.dart';
import 'package:pos/features/auth/select_outlet/domain/entities/auth_outlet_entity.dart';
import 'package:pos/features/auth/select_outlet/domain/repositories/auth_outlet_repository.dart';
import 'package:pos/shared/data/datasources/token_service.dart';
import 'package:pos/shared/data/response/token_response.dart';
import 'package:pos/shared/domain/entities/failure.dart';

@LazySingleton(as: AuthOutletRepository)
class AuthOutletRepositoryImpl extends AuthOutletRepository {
  final SelectOutletService _outletService;
  final TokenService _tokenService;
  final SessionManager _session;

  AuthOutletRepositoryImpl(
    this._outletService,
    this._tokenService,
    this._session,
  );

  @override
  Future<Either<Failure, List<AuthOutletEntity>>> getOutlets({
    required String tokenAuth,
  }) async {
    try {
      final response = await _outletService.getOutlets(
        tokenAuth: 'Bearer $tokenAuth',
      );
      return right(
        response
            .map(
              (outlet) => AuthOutletEntity(
                outletId: outlet.outletId,
                outletName: outlet.outletName,
                companyId: outlet.tenantId,
                companyName: outlet.companyName,
                posAuthKey: outlet.posAuthKey,
                outletPictureUrl: outlet.outletPicture?.fileUrl,
                subscriptionDueDate: outlet.subscriptionDueDate,
              ),
            )
            .toList(),
      );
    } catch (error, stackTrace) {
      return left(NetworkFailure.error(error, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, TokenResponse>> loginOutlet({
    required AuthOutletEntity outlet,
  }) async {
    try {
      final response = await _tokenService.loginLongAuthKey(
        outletAuthKey: outlet.posAuthKey,
      );
    } catch (error, stackTrace) {
      return left(NetworkFailure.error(error, stackTrace: stackTrace));
    }

    // TODO: implement loginOutlet
    throw UnimplementedError();
  }
}
