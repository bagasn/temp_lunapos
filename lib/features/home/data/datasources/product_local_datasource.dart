import 'package:injectable/injectable.dart';
import 'package:pos/core/firestore/firestore_service.dart';
import 'package:pos/core/local_storage/auth_preferences.dart';
import 'package:pos/core/local_storage/device_preferences.dart';
import 'package:pos/core/local_storage/outlet_preferences.dart';
import 'package:pos/features/home/data/models/product_model.dart';

abstract class ProductLocalDatasource {
  Future<List<ProductModel>> getProducts();
  Future<List<CategoryModel>> getCategories();
}

@LazySingleton(as: ProductLocalDatasource)
class ProductLocalDatasourceImpl implements ProductLocalDatasource {
  final FirestoreService _firestoreService;
  final ActiveOutletPreferences _outletPrefs;
  final AuthPreferences _authPrefs;
  final DevicePreferences _devicePrefs;

  ProductLocalDatasourceImpl(
    this._firestoreService,
    this._outletPrefs,
    this._authPrefs,
    this._devicePrefs,
  );

  Future<(String outletId, String deviceId)> _getIds() async {
    final outletId = await _outletPrefs.outletId() ?? 0;
    final deviceId = await _devicePrefs.getOrCreateDeviceId();
    return (outletId.toString(), deviceId);
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    return [];
    // final (outletId, deviceId) = await _getIds();
    // final data = await _firestoreService.getAll(
    //   FirestorePaths.products(outletId, deviceId),
    // );
    // return data
    //     .map((d) => ProductModel.fromJson(d))
    //     .where((p) => p.isActive != false)
    //     .toList();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    return [];
    // final (outletId, deviceId) = await _getIds();
    // final data = await _firestoreService.getAll(
    //   FirestorePaths.categories(outletId, deviceId),
    // );
    // return data.map((d) => CategoryModel.fromJson(d)).toList()
    //   ..sort((a, b) => (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0));
  }
}
