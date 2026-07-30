import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/features/sync/data/models/sync_data_model.dart';

abstract class SyncRemoteDatasource {
  Future<SyncDataModel> fetchInitialData({String? serverTime});
}

@LazySingleton(as: SyncRemoteDatasource)
class SyncRemoteDatasourceImpl implements SyncRemoteDatasource {
  final Dio _authDio;

  SyncRemoteDatasourceImpl(@Named('authDio') this._authDio);

  @override
  Future<SyncDataModel> fetchInitialData({String? serverTime}) async {
    final response = await _authDio.post(
      ApiEndpoints.baseUrlPos + ApiEndpoints.posInitialData,
      data: {
        'appVersion': ApiEndpoints.appVersion,
        'serverTime': serverTime,
      },
    );
    return SyncDataModel.fromJson(response.data as Map<String, dynamic>);
  }
}
