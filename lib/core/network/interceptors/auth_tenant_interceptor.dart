import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/local_storage/auth_preferences.dart';

@injectable
class AuthTenantInterceptor extends Interceptor {
  final AuthPreferences _authSession;

  AuthTenantInterceptor(this._authSession);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _authSession.userAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }
}
