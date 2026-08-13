import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/shared/data/response/token_response.dart';
import 'package:retrofit/retrofit.dart';

part 'token_service.g.dart';

@lazySingleton
@RestApi()
abstract class TokenService {
  @factoryMethod
  factory TokenService(@Named('basicDio') Dio dio) {
    return _TokenService(dio, baseUrl: ApiEndpoints.baseUrlAuth);
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
  Future<TokenResponse> refreshToken({
    @Field('grant_type') String grantType = 'refresh_token',
    @Field('client_id') String clientId = 'luna-main-web',
    @Field('refresh_token') required String refreshToken,
    @Field('company_id') required String companyId,
  });

  @POST('/token')
  @FormUrlEncoded()
  Future<TokenResponse> loginLongAuthKey({
    @Field('grant_type') String grantType = 'password',
    @Field('client_id') String clientId = 'luna-main-mobile',
    @Field('username') required String outletAuthKey,
  });
}
