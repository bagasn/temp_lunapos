import 'package:json_annotation/json_annotation.dart';

part 'sync_data_model.g.dart';

@JsonSerializable()
class SyncDataModel {
  final String? serverTime;
  final Map<String, dynamic>? outletSetting;
  final List<Map<String, dynamic>>? products;
  final List<Map<String, dynamic>>? variants;
  final List<Map<String, dynamic>>? categories;
  final List<Map<String, dynamic>>? modifiers;
  final List<Map<String, dynamic>>? modifierItems;
  final List<Map<String, dynamic>>? productToModifiers;
  final List<Map<String, dynamic>>? productToCategories;
  final List<Map<String, dynamic>>? paymentMethods;
  final List<Map<String, dynamic>>? salesTypes;
  final List<Map<String, dynamic>>? taxes;
  final List<Map<String, dynamic>>? discounts;
  final List<Map<String, dynamic>>? customers;
  final List<Map<String, dynamic>>? tables;
  final List<Map<String, dynamic>>? areas;
  final List<Map<String, dynamic>>? priceList;
  final List<Map<String, dynamic>>? priceLevels;
  final List<Map<String, dynamic>>? priceLevelItems;
  final List<Map<String, dynamic>>? users;
  final List<Map<String, dynamic>>? employees;
  final List<Map<String, dynamic>>? areaToUsers;
  final List<Map<String, dynamic>>? productToUsers;
  final List<Map<String, dynamic>>? commisionProductToEmployeeRels;

  const SyncDataModel({
    this.serverTime,
    this.outletSetting,
    this.products,
    this.variants,
    this.categories,
    this.modifiers,
    this.modifierItems,
    this.productToModifiers,
    this.productToCategories,
    this.paymentMethods,
    this.salesTypes,
    this.taxes,
    this.discounts,
    this.customers,
    this.tables,
    this.areas,
    this.priceList,
    this.priceLevels,
    this.priceLevelItems,
    this.users,
    this.employees,
    this.areaToUsers,
    this.productToUsers,
    this.commisionProductToEmployeeRels,
  });

  factory SyncDataModel.fromJson(Map<String, dynamic> json) =>
      _$SyncDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$SyncDataModelToJson(this);
}
