import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';
import 'package:pos/core/di/injection_container.dart';

abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  final int code;
  const NetworkFailure(this.code, super.message);

  factory NetworkFailure.error(Object error, {StackTrace? stackTrace}) {
    locator<Logger>().e(
      '--- NetworkError ---',
      error: error,
      stackTrace: stackTrace,
    );
    switch (error) {
      case FirebaseException _:
        return NetworkFailure(494, '${error.message} (${error.plugin})');
      case DioException _:
        final response = error.response;
        final data = response?.data;
        final statusCode = response?.statusCode ?? 491;
        final statusMessage = response?.statusMessage;

        Map<String, dynamic>? errorMap;
        if (data is Map) {
          errorMap = data as Map<String, dynamic>;
        } else if (data is List) {
          errorMap = data[0] as Map<String, dynamic>;
        }

        String? errorMessage;
        if (errorMap != null) {
          if (errorMap.containsKey('error_description')) {
            errorMessage = errorMap['error_description'];
          } else if (errorMap.containsKey('errorMessage')) {
            errorMessage = errorMap['errorMessage'];
          }
        }

        errorMessage ??= statusMessage ?? 'Connection Error';

        return NetworkFailure(statusCode, errorMessage);
      case CheckedFromJsonException _:
        return NetworkFailure.message(
          error.message ?? error.runtimeType.toString(),
        );
      case FormatException _:
        return NetworkFailure.message(error.message);
      case Exception _:
        final fixMessage = error.toString().replaceAll('Exception: ', '');
        return NetworkFailure(492, fixMessage);
      case TypeError _:
        return NetworkFailure.message(error.toString());
      case StateError _:
        return NetworkFailure.message(error.toString());
      default:
        locator<Logger>().e(
          'Unhandled Exception\n'
          'Exception Type: ${error.runtimeType}',
          error: error,
        );
        return const NetworkFailure(490, 'Unknown Network Error');
    }
  }

  factory NetworkFailure.message(String message) {
    return NetworkFailure(-1, message);
  }
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
