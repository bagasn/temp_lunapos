import 'package:json_annotation/json_annotation.dart';

part 'initial_data_response.g.dart';

@JsonSerializable()
class InitialDataResponse {
  @JsonKey(name: 'outletSetting')
  final OutletSetting? outletSetting;
  @JsonKey(name: 'taxes')
  final List<Tax>? taxes;
  @JsonKey(name: 'users')
  final List<User>? users;
  @JsonKey(name: 'tables')
  final List<Table>? tables;
  @JsonKey(name: 'areas')
  final List<Area>? areas;
  @JsonKey(name: 'areaToUsers')
  final List<AreaToUser>? areaToUsers;
  @JsonKey(name: 'customers')
  final List<Customer>? customers;
  @JsonKey(name: 'salesTypes')
  final List<SalesType>? salesTypes;
  @JsonKey(name: 'discounts')
  final List<Discount>? discounts;
  @JsonKey(name: 'paymentMethods')
  final List<PaymentMethod>? paymentMethods;
  @JsonKey(name: 'serverTime')
  final String? serverTime;

  InitialDataResponse({
    this.outletSetting,
    this.taxes,
    this.users,
    this.tables,
    this.areas,
    this.areaToUsers,
    this.customers,
    this.salesTypes,
    this.discounts,
    this.paymentMethods,
    this.serverTime,
  });

  factory InitialDataResponse.fromJson(Map<String, dynamic> json) =>
      _$InitialDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InitialDataResponseToJson(this);
}

@JsonSerializable()
class OutletSetting {
  final String? name;
  final String? email;
  final String? fax;
  final String? phone;
  final String? website;
  final String? facebook;
  final String? instagram;
  final String? twitter;
  final String? note;
  final String? pictureUrl;
  final String? closingTime;
  final bool? allowCustomPriceOrDiscount;
  final bool? isSuspended;
  final bool? inactive;
  final String? address;
  final String? defaultSalesTaxId;
  final OutletAddress? outletAddress;
  final bool? serviceCharged;
  final num? serviceChargeRate;
  final String? serviceChargeTaxId;
  final num? serviceChargeTaxRate;
  final bool? serviceChargeBeforeDiscount;
  final bool? taxed;
  final OutletPicture? outletPicture;
  final bool? taxInclusive;
  final OutletPicture? picture;
  final bool? taxOnDiscount;
  final String? subscriptionDueDateUtc;
  final String? defaultWarehouseId;

  OutletSetting({
    this.name,
    this.email,
    this.fax,
    this.phone,
    this.website,
    this.facebook,
    this.instagram,
    this.twitter,
    this.note,
    this.pictureUrl,
    this.closingTime,
    this.allowCustomPriceOrDiscount,
    this.isSuspended,
    this.inactive,
    this.address,
    this.defaultSalesTaxId,
    this.outletAddress,
    this.serviceCharged,
    this.serviceChargeRate,
    this.serviceChargeTaxId,
    this.serviceChargeTaxRate,
    this.serviceChargeBeforeDiscount,
    this.taxed,
    this.outletPicture,
    this.taxInclusive,
    this.picture,
    this.taxOnDiscount,
    this.subscriptionDueDateUtc,
    this.defaultWarehouseId,
  });

  factory OutletSetting.fromJson(Map<String, dynamic> json) =>
      _$OutletSettingFromJson(json);

  Map<String, dynamic> toJson() => _$OutletSettingToJson(this);
}

@JsonSerializable()
class OutletAddress {
  final String? id;
  final String? street1;
  final String? street2;
  final String? subdistrict;
  final String? city;
  final String? stateProvince;
  final String? countryId;
  final String? postalCode;
  final num? longitude;
  final num? latitude;
  final String? googlePlaceId;
  final num? provinceId;
  final num? cityId;
  final num? districtId;
  final num? villageId;
  final Country? country;
  final LocationData? provinceData;
  final LocationData? cityData;
  final LocationData? districtData;
  final LocationData? villageData;
  final String? fullAddress;
  final String? fullAddressForPosOutlet;

  OutletAddress({
    this.id,
    this.street1,
    this.street2,
    this.subdistrict,
    this.city,
    this.stateProvince,
    this.countryId,
    this.postalCode,
    this.longitude,
    this.latitude,
    this.googlePlaceId,
    this.provinceId,
    this.cityId,
    this.districtId,
    this.villageId,
    this.country,
    this.provinceData,
    this.cityData,
    this.districtData,
    this.villageData,
    this.fullAddress,
    this.fullAddressForPosOutlet,
  });

  factory OutletAddress.fromJson(Map<String, dynamic> json) =>
      _$OutletAddressFromJson(json);

  Map<String, dynamic> toJson() => _$OutletAddressToJson(this);
}

@JsonSerializable()
class Country {
  final String? id;
  final String? name;
  final String? phoneCountryCode;

  Country({this.id, this.name, this.phoneCountryCode});

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}

@JsonSerializable()
class LocationData {
  final num? id;
  final String? description;

  LocationData({this.id, this.description});

  factory LocationData.fromJson(Map<String, dynamic> json) =>
      _$LocationDataFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDataToJson(this);
}

@JsonSerializable()
class OutletPicture {
  final String? id;
  final String? fileType;
  final String? fileName;
  final String? fileExt;
  final num? fileSize;
  final String? description;
  final String? uploadByUserId;
  final String? fileUrl;
  final String? thumbnailUrl;
  final String? smallUrl;
  final String? mediumUrl;
  final String? largeUrl;
  final String? tabletUrl;

  OutletPicture({
    this.id,
    this.fileType,
    this.fileName,
    this.fileExt,
    this.fileSize,
    this.description,
    this.uploadByUserId,
    this.fileUrl,
    this.thumbnailUrl,
    this.smallUrl,
    this.mediumUrl,
    this.largeUrl,
    this.tabletUrl,
  });

  factory OutletPicture.fromJson(Map<String, dynamic> json) =>
      _$OutletPictureFromJson(json);

  Map<String, dynamic> toJson() => _$OutletPictureToJson(this);
}

@JsonSerializable()
class Tax {
  final String? id;
  final String? code;
  final String? name;
  final num? rate;
  final bool? deleted;

  Tax({this.id, this.code, this.name, this.rate, this.deleted});

  factory Tax.fromJson(Map<String, dynamic> json) => _$TaxFromJson(json);

  Map<String, dynamic> toJson() => _$TaxToJson(this);
}

@JsonSerializable()
class User {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? pinNumber;
  final bool? permissionPay;
  final bool? allowToPay;
  final bool? permissionCancel;
  final bool? allowToCancel;
  final bool? permissionEdit;
  final bool? allowToEdit;
  final bool? permissionVoidOrder;
  final bool? permissionVoidItem;
  final bool? permissionDiscount;
  final bool? permissionReport;
  final bool? permissionCustomPrice;
  final bool? permissionAdmin;
  final bool? permissionCustomItem;
  final bool? permissionPrintBill;
  final bool? permissionSeeAllUserTransactions;
  final String? pictureUrl;
  final bool? deleted;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.pinNumber,
    this.permissionPay,
    this.allowToPay,
    this.permissionCancel,
    this.allowToCancel,
    this.permissionEdit,
    this.allowToEdit,
    this.permissionVoidOrder,
    this.permissionVoidItem,
    this.permissionDiscount,
    this.permissionReport,
    this.permissionCustomPrice,
    this.permissionAdmin,
    this.permissionCustomItem,
    this.permissionPrintBill,
    this.permissionSeeAllUserTransactions,
    this.pictureUrl,
    this.deleted,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Table {
  final String? id;
  final String? name;
  final num? absisStartingGrid;
  final num? ordinatStartingGrid;
  final num? absisAmountOfGrid;
  final num? ordinatAmountOfGrid;
  final String? tableType;
  final String? areaId;
  final bool? deleted;
  final bool? hasMaxOrderDuration;
  final num? maxOrderDurationMinutes;
  final bool? hasMinOrderAmount;
  final num? minOrderAmount;
  final num? minOrderAmountType;

  Table({
    this.id,
    this.name,
    this.absisStartingGrid,
    this.ordinatStartingGrid,
    this.absisAmountOfGrid,
    this.ordinatAmountOfGrid,
    this.tableType,
    this.areaId,
    this.deleted,
    this.hasMaxOrderDuration,
    this.maxOrderDurationMinutes,
    this.hasMinOrderAmount,
    this.minOrderAmount,
    this.minOrderAmountType,
  });

  factory Table.fromJson(Map<String, dynamic> json) => _$TableFromJson(json);

  Map<String, dynamic> toJson() => _$TableToJson(this);
}

@JsonSerializable()
class Area {
  final String? id;
  final String? name;
  final num? absisMaximumGrid;
  final num? ordinatMaximumGrid;
  final num? sortOrder;
  final bool? availableForAllPosUsers;
  final bool? deleted;

  Area({
    this.id,
    this.name,
    this.absisMaximumGrid,
    this.ordinatMaximumGrid,
    this.sortOrder,
    this.availableForAllPosUsers,
    this.deleted,
  });

  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);

  Map<String, dynamic> toJson() => _$AreaToJson(this);
}

@JsonSerializable()
class AreaToUser {
  final String? posAreaId;
  final String? userId;
  final num? sortOrder;

  AreaToUser({this.posAreaId, this.userId, this.sortOrder});

  factory AreaToUser.fromJson(Map<String, dynamic> json) =>
      _$AreaToUserFromJson(json);

  Map<String, dynamic> toJson() => _$AreaToUserToJson(this);
}

@JsonSerializable()
class Customer {
  final String? id;
  final String? displayName;
  final String? firstName;
  final String? lastName;
  final String? company;
  final String? phone;
  final String? email;
  final String? dateOfBirth;
  final String? gender;
  final String? address;
  final bool? isDeleted;
  final String? bankAccountId;
  final String? bankId;
  final String? bankName;
  final String? bankAccountNumber;
  final String? bankAccountName;
  final String? defaultSalesPriceLevelId;

  Customer({
    this.id,
    this.displayName,
    this.firstName,
    this.lastName,
    this.company,
    this.phone,
    this.email,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.isDeleted,
    this.bankAccountId,
    this.bankId,
    this.bankName,
    this.bankAccountNumber,
    this.bankAccountName,
    this.defaultSalesPriceLevelId,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}

@JsonSerializable()
class SalesType {
  final String? id;
  final String? name;
  final bool? isMaster;
  final bool? serviceCharged;
  final bool? taxed;
  final bool? deleted;
  final String? priceLevelId;

  SalesType({
    this.id,
    this.name,
    this.isMaster,
    this.serviceCharged,
    this.taxed,
    this.deleted,
    this.priceLevelId,
  });

  factory SalesType.fromJson(Map<String, dynamic> json) =>
      _$SalesTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SalesTypeToJson(this);
}

@JsonSerializable()
class Discount {
  final String? id;
  final String? name;
  final String? description;
  final String? discountMode;
  final num? discountValue;
  final num? minimumPurchaseAmount;
  final num? maximumDiscountAmount;

  Discount({
    this.id,
    this.name,
    this.description,
    this.discountMode,
    this.discountValue,
    this.minimumPurchaseAmount,
    this.maximumDiscountAmount,
  });

  factory Discount.fromJson(Map<String, dynamic> json) =>
      _$DiscountFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountToJson(this);
}

@JsonSerializable()
class PaymentMethod {
  final String? paymentMethodId;
  final String? paymentMethodName;
  final String? paymentMethodType;
  final String? paymentAccountId;
  final bool? isDefaultCash;
  final num? sortOrder;
  final bool? deleted;

  PaymentMethod({
    this.paymentMethodId,
    this.paymentMethodName,
    this.paymentMethodType,
    this.paymentAccountId,
    this.isDefaultCash,
    this.sortOrder,
    this.deleted,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);
}
