import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/features/auth/select_outlet/data/models/outlet_response.dart';
import 'package:retrofit/retrofit.dart';

part 'select_outlet_service.g.dart';

@lazySingleton
@RestApi()
abstract class SelectOutletService {
  @factoryMethod
  factory SelectOutletService(@Named('basicDio') Dio dio) {
    return _SelectOutletService(dio, baseUrl: ApiEndpoints.baseUrlPos);
  }

  @GET('/outlet')
  Future<List<OutletResponse>> getOutlets({
    @Header('Authorization') required String tokenAuth,
  });
}
