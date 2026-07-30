import 'package:injectable/injectable.dart';
import 'package:pos/core/firestore/firestore_paths.dart';
import 'package:pos/core/firestore/firestore_service.dart';
import 'package:pos/core/local_storage/auth_preferences.dart';
import 'package:pos/core/local_storage/device_preferences.dart';
import 'package:pos/features/home/data/models/order_model.dart';

abstract class OrderLocalDatasource {
  Future<void> saveOrder(OrderModel order);
  Future<void> updateOrder(OrderModel order);
  Future<OrderModel?> getActiveOrder();
}

@LazySingleton(as: OrderLocalDatasource)
class OrderLocalDatasourceImpl implements OrderLocalDatasource {
  final FirestoreService _firestoreService;
  final AuthPreferences _authPrefs;
  final DevicePreferences _devicePrefs;

  OrderLocalDatasourceImpl(
    this._firestoreService,
    this._authPrefs,
    this._devicePrefs,
  );

  Future<(String outletId, String deviceId)> _getIds() async {
    final outletId = await _authPrefs.outletId() ?? '';
    final deviceId = await _devicePrefs.getOrCreateDeviceId();
    return (outletId, deviceId);
  }

  @override
  Future<void> saveOrder(OrderModel order) async {
    final (outletId, deviceId) = await _getIds();
    await _firestoreService.setDocument(
      FirestorePaths.orders(outletId, deviceId),
      order.id,
      order.toFirestore(),
    );
  }

  @override
  Future<void> updateOrder(OrderModel order) async {
    final (outletId, deviceId) = await _getIds();
    await _firestoreService.updateDocument(
      FirestorePaths.orders(outletId, deviceId),
      order.id,
      order.toFirestore(),
    );
  }

  @override
  Future<OrderModel?> getActiveOrder() async {
    final (outletId, deviceId) = await _getIds();
    final all = await _firestoreService.getAll(
      FirestorePaths.orders(outletId, deviceId),
    );
    final active = all.where((d) => d['status'] == 'active').toList();
    if (active.isEmpty) return null;
    return OrderModel.fromFirestore(active.first);
  }
}
