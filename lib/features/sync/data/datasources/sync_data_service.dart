import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:retrofit/retrofit.dart';

import 'package:pos/features/sync/data/models/initial_data_response.dart';
import 'package:pos/features/sync/data/models/initial_data_promo_response.dart';
import 'package:pos/features/sync/data/models/initial_data_product_response.dart';

part 'sync_data_service.g.dart';

@singleton
@RestApi()
abstract class SyncDataService {
  @factoryMethod
  factory SyncDataService(@Named('authDio') Dio dio) {
    return _SyncDataService(dio, baseUrl: ApiEndpoints.baseUrlPos);
  }

  @POST('/pos/initial-data/v2')
  Future<InitialDataResponse> getInitialData();

  @POST('/pos/initial-data/promo')
  Future<InitialDataPromoResponse> getInitialPromo();

  @POST('/pos/initial-data/product')
  Future<InitialDataProductResponse> getInitialProduct();
}
