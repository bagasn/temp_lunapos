import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/features/auth/shared/data/models/token_response.dart';
import 'package:retrofit/retrofit.dart';

part 'login_service.g.dart';

@lazySingleton
@RestApi()
abstract class LoginService {
  @factoryMethod
  factory LoginService(@Named('basicDio') Dio dio) {
    return _LoginService(dio, baseUrl: ApiEndpoints.baseUrlAuth);
  }

  @POST('/token')
  @FormUrlEncoded()
  Future<TokenResponse> loginWithPassword({
    @Field('grant_type') String grantType = 'password',
    @Field('client_id') String clientId = 'luna-main-web',
    @Field('username') required String username,
    @Field('password') required String password,
  });

  @POST('/token')
  @FormUrlEncoded()
  Future<TokenResponse> loginLongAuthKey({
    @Field('grant_type') String grantType = 'password',
    @Field('client_id') String clientId = 'luna-main-mobile',
    @Field('username') required String outletAuthKey,
  });
}
