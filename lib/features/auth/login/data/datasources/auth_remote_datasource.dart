import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/features/auth/login/data/models/token_response_model.dart';
import 'package:pos/features/auth/select_outlet/data/models/outlet_model.dart';

abstract class AuthRemoteDatasource {
  Future<TokenResponseModel> loginWithPassword({
    required String username,
    required String password,
  });

  Future<TokenResponseModel> loginWithAuthKey({
    required String posAuthKey,
  });

  Future<List<OutletModel>> getOutlets(String accessToken);
}

@LazySingleton(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio _basicDio;
  final Dio _authDio;

  AuthRemoteDatasourceImpl(
    @Named('basicDio') this._basicDio,
    @Named('authDio') this._authDio,
  );

  @override
  Future<TokenResponseModel> loginWithPassword({
    required String username,
    required String password,
  }) async {
    final body =
        'grant_type=password&username=$username&password=$password&client_id=luna-main-web&client_secret=';
    final response = await _basicDio.post(
      ApiEndpoints.baseUrlAuth + ApiEndpoints.token,
      data: body,
      options: Options(
        contentType: 'application/x-www-form-urlencoded',
      ),
    );
    return TokenResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<TokenResponseModel> loginWithAuthKey({
    required String posAuthKey,
  }) async {
    final body =
        'grant_type=password&username=$posAuthKey&password=password-authKey-web&client_id=luna-main-web&client_secret=';
    final response = await _basicDio.post(
      ApiEndpoints.baseUrlAuth + ApiEndpoints.token,
      data: body,
      options: Options(
        contentType: 'application/x-www-form-urlencoded',
      ),
    );
    return TokenResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<OutletModel>> getOutlets(String accessToken) async {
    final response = await _authDio.get(
      ApiEndpoints.baseUrlPos + ApiEndpoints.outlet,
      options: Options(
        headers: {'Authorization': 'Bearer $accessToken'},
      ),
    );
    final list = response.data as List;
    return list
        .map((e) => OutletModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
