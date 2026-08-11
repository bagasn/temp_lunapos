import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/local_storage/session_manager.dart';

@lazySingleton
class LocaleInterceptor extends Interceptor {
  final SessionManager _sessionManager;

  const LocaleInterceptor(this._sessionManager);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String localeCode =
        (await _sessionManager.setting.getLocale()) ?? 'id';
    String languageId = localeCode == 'id' ? 'id-ID' : 'en-US';
    options.headers['Accept-Language'] = languageId;

    return handler.next(options);
  }
}
