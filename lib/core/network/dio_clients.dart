import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/local_storage/auth_preferences.dart';
import 'package:pos/core/network/interceptors/auth_interceptor.dart';
import 'package:pos/core/network/interceptors/auth_lunaone_interceptor.dart';
import 'package:pos/core/network/interceptors/locale_interceptor.dart';
import 'package:pos/core/network/interceptors/refresh_token_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final _dioLogger = PrettyDioLogger(
  requestBody: true,
  maxWidth: 90,
  enabled: kDebugMode,
  filter: (options, args) {
    // if (options.path.startsWith('/dashboard')) return false;

    return true;
  },
);

@module
abstract class DioModule {
  BaseOptions _options() => BaseOptions(
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    responseType: ResponseType.json,
    sendTimeout: const Duration(minutes: 2),
    receiveTimeout: const Duration(minutes: 2),
  );

  @Named('basicDio')
  @singleton
  Dio basicDio(LocaleInterceptor localeInterceptor) {
    final dio = Dio(_options());
    dio.interceptors.add(localeInterceptor);
    dio.interceptors.add(_dioLogger);
    return dio;
  }

  @Named('authDio')
  @singleton
  Dio authDio(
    AuthPreferences authSession,
    LocaleInterceptor localeInterceptor,
    RefreshTokenInterceptor refreshTokenInterceptor,
  ) {
    final dio = Dio(_options());
    dio.interceptors.add(localeInterceptor);
    dio.interceptors.add(AuthInterceptor(authSession));
    dio.interceptors.add(refreshTokenInterceptor);
    dio.interceptors.add(_dioLogger);
    return dio;
  }

  @Named('lunaoneDio')
  @singleton
  Dio lunaoneDio(
    AuthPreferences authSession,
    LocaleInterceptor localeInterceptor,
    RefreshTokenInterceptor refreshTokenInterceptor,
  ) {
    final dio = Dio(_options());
    dio.interceptors.add(localeInterceptor);
    dio.interceptors.add(AuthLunaoneInterceptor(authSession));
    dio.interceptors.add(refreshTokenInterceptor);
    dio.interceptors.add(_dioLogger);
    return dio;
  }
}
