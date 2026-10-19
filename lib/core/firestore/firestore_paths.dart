class FirestorePaths {
  FirestorePaths._();

  static String _root(String outletId, String deviceId) =>
      'luna-pos-data/$outletId/$deviceId';

  static String syncInfo(String outletId, String deviceId) =>
      '${_root(outletId, deviceId)}/sync_info';

  static String orders(String outletId, String deviceId) =>
      '${_root(outletId, deviceId)}/order';

  static String orderDoc(String outletId, String deviceId, String orderId) =>
      '${orders(outletId, deviceId)}/$orderId';
}
