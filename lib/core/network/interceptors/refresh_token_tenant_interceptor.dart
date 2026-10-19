import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/local_storage/session_manager.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/shared/data/response/token_response.dart';
import 'package:pos/shared/utilities/log_util.dart';

@lazySingleton
class RefreshTokenTenantInterceptor extends Interceptor {
  Completer<bool>? _refreshCompleter;

  final Dio basicDio;
  final SessionManager sessionManager;

  RefreshTokenTenantInterceptor({
    @Named('basicDio') required this.basicDio,
    required this.sessionManager,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final String? refreshToken = await sessionManager.auth.refreshToken();
      final int? companyId = await sessionManager.activeOutlet.companyId();

      if (refreshToken == null || companyId == null) {
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
          final tokenResponse = await _requestRefreshToken(
            refreshToken,
            companyId,
          );

          await sessionManager.auth.saveUserToken(
            accessToken: tokenResponse.accessToken,
            refreshToken: tokenResponse.refreshToken,
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
        final newToken = await sessionManager.auth.userAccessToken();
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
        return handler.resolve(await basicDio.fetch(err.requestOptions));
      } else {
        return handler.next(err);
      }
    }

    //* When status code not 401. Do Nothing / Reject.
    return handler.reject(err);
  }

  Future<TokenResponse> _requestRefreshToken(
    String refreshToken,
    int companyId,
  ) async {
    final response = await basicDio.post(
      '${ApiEndpoints.baseUrlAuth}/token',
      options: Options(
        contentType: 'application/x-www-form-urlencoded',
        responseType: ResponseType.json,
        sendTimeout: const Duration(minutes: 2),
        receiveTimeout: const Duration(minutes: 2),
      ),
      data:
          'grant_type:refresh_token&'
          'refresh_token:$refreshToken&'
          'company_id:$companyId&'
          'client_id:luna-main-mobile',
    );

    return TokenResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
