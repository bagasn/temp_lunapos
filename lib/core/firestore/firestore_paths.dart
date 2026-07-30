class FirestorePaths {
  FirestorePaths._();

  static String _root(String outletId, String deviceId) =>
      'luna-pos-data/$outletId/$deviceId';

  static String syncInfo(String outletId, String deviceId) =>
      '${_root(outletId, deviceId)}/sync_info';

  static String products(String outletId, String deviceId) =>
      '${_root(outletId, deviceId)}/product';

  static String categories(String outletId, String deviceId) =>
      '${_root(outletId, deviceId)}/category';

  static String productToCategories(String outletId, String deviceId) =>
      '${_root(outletId, deviceId)}/product_to_category';

  static String modifiers(String outletId, String deviceId) =>
      '${_root(outletId, deviceId)}/modifier';

  static String modifierItems(String outletId, String deviceId) =>
      '${_root(outletId, deviceId)}/modifier_item';

  static String productToModifiers(String outletId, String deviceId) =>
      '${_root(outletId, deviceId)}/product_to_modifier';

  static String paymentMethods(String outletId, String deviceId) =>
      '${_root(outletId, deviceId)}/payment_method';

  static String salesTypes(String outletId, String deviceId) =>
      '${_root(outletId, deviceId)}/sales_type';

  static String taxes(String outletId, String deviceId) =>
      '${_root(outletId, deviceId)}/tax';

  static String discounts(String outletId, String deviceId) =>
      '${_root(outletId, deviceId)}/discount';

  static String customers(String outletId, String deviceId) =>
      '${_root(outletId, deviceId)}/customer';

  static String tables(String outletId, String deviceId) =>
      '${_root(outletId, deviceId)}/table';

  static String areas(String outletId, String deviceId) =>
      '${_root(outletId, deviceId)}/area';

  static String priceLists(String outletId, String deviceId) =>
      '${_root(outletId, deviceId)}/price_list';

  static String outletSetting(String outletId, String deviceId) =>
      '${_root(outletId, deviceId)}/outlet_setting';

  static String orders(String outletId, String deviceId) =>
      '${_root(outletId, deviceId)}/order';

  static String orderDoc(String outletId, String deviceId, String orderId) =>
      '${orders(outletId, deviceId)}/$orderId';
}
