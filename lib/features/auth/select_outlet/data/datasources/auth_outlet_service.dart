import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/features/auth/select_outlet/data/models/auth_outlet_response.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_outlet_service.g.dart';

@lazySingleton
@RestApi()
abstract class AuthOutletService {
  @factoryMethod
  factory AuthOutletService(@Named('basicDio') Dio dio) {
    return _AuthOutletService(dio, baseUrl: ApiEndpoints.baseUrlPos);
  }

  @GET('/outlet')
  Future<List<AuthOutletResponse>> getOutlets({
    @Header('Authorization') required String tokenAuth,
  });
}
