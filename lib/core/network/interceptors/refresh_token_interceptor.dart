import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/local_storage/session_manager.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/features/auth/login/data/datasources/login_service.dart';
import 'package:pos/features/auth/shared/data/models/token_response.dart';
import 'package:pos/shared/utilities/log_util.dart';

@lazySingleton
class RefreshTokenInterceptor extends Interceptor {
  Completer<bool>? _refreshCompleter;

  final Dio basicDio;
  final SessionManager sessionManager;

  RefreshTokenInterceptor({
    @Named('basicDio') required this.basicDio,
    required this.sessionManager,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final String? posAuthKey = await sessionManager.activeOutlet
          .outletPosAuthKey();
      if (posAuthKey == null) {
        // TODO: put auto logout function here.
        return handler.reject(err);
      }

      bool isRefreshTokenSuccess = true;
      //* Check if refresh token already running
      if (_refreshCompleter != null) {
        isRefreshTokenSuccess = await _refreshCompleter!.future;
      } else {
        _refreshCompleter = Completer();
        try {
          final tokenResponse = await _requestRefreshToken(posAuthKey);

          await sessionManager.auth.saveOutletToken(
            accessToken: tokenResponse.accessToken,
            refreshToken: tokenResponse.refreshToken,
            lunaoneToken: tokenResponse.tokenLunaone,
            lunaoneRefreshToken: tokenResponse.refreshTokenLunaone,
          );

          _refreshCompleter?.complete(true);
        } on DioException catch (error, stackTrace) {
          LogUtil.e(error.toString(), error: error, stackTrace: stackTrace);
          isRefreshTokenSuccess = false;
          _refreshCompleter?.complete(false);

          if (error.response?.statusCode == 400) {
            // TODO: put auto logout function here too.
          }
          _refreshCompleter = null;
          return handler.reject(error);
        } finally {
          _refreshCompleter = null;
        }
      }

      //* Set new token and try again.
      if (isRefreshTokenSuccess) {
        final newToken = await sessionManager.auth.accesToken();
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
        return handler.resolve(await basicDio.fetch(err.requestOptions));
      } else {
        return handler.next(err);
      }
    }

    //* When status code not 401. Do Nothing / Reject.
    return handler.reject(err);
  }

  Future<TokenResponse> _requestRefreshToken(String posAuthKey) async {
    final response = await basicDio.post(
      '${ApiEndpoints.baseUrlAuth}/token',
      options: Options(
        contentType: 'application/x-www-form-urlencoded',
        responseType: ResponseType.json,
        sendTimeout: const Duration(minutes: 2),
        receiveTimeout: const Duration(minutes: 2),
      ),
      data:
          'grant_type:password&'
          'username:$posAuthKey&'
          'client_id:luna-main-mobile',
    );

    return TokenResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
