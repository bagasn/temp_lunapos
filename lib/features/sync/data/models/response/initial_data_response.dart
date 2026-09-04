import 'package:json_annotation/json_annotation.dart';

part 'initial_data_response.g.dart';

@JsonSerializable()
class InitialDataResponse {
  final OutletSetting outletSetting;
  final List<Tax> taxes;
  final List<User> users;
  final List<Table> tables;
  final List<Area> areas;
  final List<AreaToUser> areaToUsers;
  final List<Customer> customers;
  final List<SalesType> salesTypes;
  final List<Discount> discounts;
  final List<PaymentMethod> paymentMethods;
  final String serverTime;

  InitialDataResponse({
    required this.outletSetting,
    required this.taxes,
    required this.users,
    required this.tables,
    required this.areas,
    required this.areaToUsers,
    required this.customers,
    required this.salesTypes,
    required this.discounts,
    required this.paymentMethods,
    required this.serverTime,
  });

  factory InitialDataResponse.fromJson(Map<String, dynamic> json) =>
      _$InitialDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InitialDataResponseToJson(this);
}

@JsonSerializable()
class OutletSetting {
  final String name;
  final String? email; // null when not configured
  final String? fax; // null when not configured
  final String? phone; // null when not configured
  final String? website; // null when not configured
  final String? facebook; // null when not configured
  final String? instagram; // null when not configured
  final String? twitter; // null when not configured
  final String? note; // null when not configured
  final String? pictureUrl;
  final String? closingTime; // null when not configured
  final bool allowCustomPriceOrDiscount;
  final bool isSuspended;
  final bool inactive;
  final String address;
  final String defaultSalesTaxId;
  final OutletAddress outletAddress;
  final bool serviceCharged;
  final double serviceChargeRate;
  final String? serviceChargeTaxId; // null when serviceCharged = false
  final double? serviceChargeTaxRate; // null when serviceCharged = false
  final bool serviceChargeBeforeDiscount;
  final bool taxed;
  final OutletPicture outletPicture;
  final bool taxInclusive;
  final OutletPicture picture;
  final bool taxOnDiscount;
  final String subscriptionDueDateUtc;
  final String defaultWarehouseId;

  OutletSetting({
    required this.name,
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
    required this.allowCustomPriceOrDiscount,
    required this.isSuspended,
    required this.inactive,
    required this.address,
    required this.defaultSalesTaxId,
    required this.outletAddress,
    required this.serviceCharged,
    required this.serviceChargeRate,
    this.serviceChargeTaxId,
    this.serviceChargeTaxRate,
    required this.serviceChargeBeforeDiscount,
    required this.taxed,
    required this.outletPicture,
    required this.taxInclusive,
    required this.picture,
    required this.taxOnDiscount,
    required this.subscriptionDueDateUtc,
    required this.defaultWarehouseId,
  });

  factory OutletSetting.fromJson(Map<String, dynamic> json) =>
      _$OutletSettingFromJson(json);

  Map<String, dynamic> toJson() => _$OutletSettingToJson(this);
}

@JsonSerializable()
class OutletAddress {
  final String id;
  final String? street1; // null when address not configured
  final String? street2;
  final String? subdistrict;
  final String? city;
  final String? stateProvince;
  final String? countryId; // null when address not configured
  final String? postalCode; // null when address not configured
  final double? longitude; // null when address not configured
  final double? latitude; // null when address not configured
  final String? googlePlaceId; // null when address not configured
  final int? provinceId; // null when address not configured
  final int? cityId; // null when address not configured
  final int? districtId; // null when address not configured
  final int? villageId; // null when address not configured
  final Country? country; // null when address not configured
  final LocationData? provinceData; // null when address not configured
  final LocationData? cityData; // null when address not configured
  final LocationData? districtData; // null when address not configured
  final LocationData? villageData; // null when address not configured
  final String fullAddress;
  final String fullAddressForPosOutlet;

  OutletAddress({
    required this.id,
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
    required this.fullAddress,
    required this.fullAddressForPosOutlet,
  });

  factory OutletAddress.fromJson(Map<String, dynamic> json) =>
      _$OutletAddressFromJson(json);

  Map<String, dynamic> toJson() => _$OutletAddressToJson(this);
}

@JsonSerializable()
class Country {
  final String id;
  final String name;
  final String phoneCountryCode;

  Country({
    required this.id,
    required this.name,
    required this.phoneCountryCode,
  });

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}

@JsonSerializable()
class LocationData {
  final int id;
  final String description;

  LocationData({required this.id, required this.description});

  factory LocationData.fromJson(Map<String, dynamic> json) =>
      _$LocationDataFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDataToJson(this);
}

@JsonSerializable()
class OutletPicture {
  final String id;
  final String fileType;
  final String fileName;
  final String fileExt;
  final int fileSize;
  final String? description; // null in real data
  final String uploadByUserId;
  final String fileUrl;
  final String thumbnailUrl;
  final String smallUrl;
  final String mediumUrl;
  final String largeUrl;
  final String tabletUrl;

  OutletPicture({
    required this.id,
    required this.fileType,
    required this.fileName,
    required this.fileExt,
    required this.fileSize,
    this.description,
    required this.uploadByUserId,
    required this.fileUrl,
    required this.thumbnailUrl,
    required this.smallUrl,
    required this.mediumUrl,
    required this.largeUrl,
    required this.tabletUrl,
  });

  factory OutletPicture.fromJson(Map<String, dynamic> json) =>
      _$OutletPictureFromJson(json);

  Map<String, dynamic> toJson() => _$OutletPictureToJson(this);
}

@JsonSerializable()
class Tax {
  final String id;
  final String code;
  final String name;
  final double rate;
  final bool deleted;

  Tax({
    required this.id,
    required this.code,
    required this.name,
    required this.rate,
    required this.deleted,
  });

  factory Tax.fromJson(Map<String, dynamic> json) => _$TaxFromJson(json);

  Map<String, dynamic> toJson() => _$TaxToJson(this);
}

@JsonSerializable()
class User {
  final String id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String pinNumber;
  final bool permissionPay;
  final bool allowToPay;
  final bool permissionCancel;
  final bool allowToCancel;
  final bool permissionEdit;
  final bool allowToEdit;
  final bool permissionVoidOrder;
  final bool permissionVoidItem;
  final bool permissionDiscount;
  final bool permissionReport;
  final bool permissionCustomPrice;
  final bool permissionAdmin;
  final bool permissionCustomItem;
  final bool permissionPrintBill;
  final bool permissionSeeAllUserTransactions;
  final String? pictureUrl; // null when user has no photo
  final bool deleted;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.pinNumber,
    required this.permissionPay,
    required this.allowToPay,
    required this.permissionCancel,
    required this.allowToCancel,
    required this.permissionEdit,
    required this.allowToEdit,
    required this.permissionVoidOrder,
    required this.permissionVoidItem,
    required this.permissionDiscount,
    required this.permissionReport,
    required this.permissionCustomPrice,
    required this.permissionAdmin,
    required this.permissionCustomItem,
    required this.permissionPrintBill,
    required this.permissionSeeAllUserTransactions,
    this.pictureUrl,
    required this.deleted,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Table {
  final String id;
  final String name;
  final int absisStartingGrid;
  final int ordinatStartingGrid;
  final int absisAmountOfGrid;
  final int ordinatAmountOfGrid;
  final String tableType;
  final String areaId;
  final bool deleted;
  final bool hasMaxOrderDuration;
  final int? maxOrderDurationMinutes; // null when hasMaxOrderDuration = false
  final bool hasMinOrderAmount;
  final num? minOrderAmount; // null when hasMinOrderAmount = false
  final int? minOrderAmountType; // null in some records

  Table({
    required this.id,
    required this.name,
    required this.absisStartingGrid,
    required this.ordinatStartingGrid,
    required this.absisAmountOfGrid,
    required this.ordinatAmountOfGrid,
    required this.tableType,
    required this.areaId,
    required this.deleted,
    required this.hasMaxOrderDuration,
    this.maxOrderDurationMinutes,
    required this.hasMinOrderAmount,
    this.minOrderAmount,
    this.minOrderAmountType,
  });

  factory Table.fromJson(Map<String, dynamic> json) => _$TableFromJson(json);

  Map<String, dynamic> toJson() => _$TableToJson(this);
}

@JsonSerializable()
class Area {
  final String id;
  final String name;
  final int absisMaximumGrid;
  final int ordinatMaximumGrid;
  final int sortOrder;
  final bool availableForAllPosUsers;
  final bool deleted;

  Area({
    required this.id,
    required this.name,
    required this.absisMaximumGrid,
    required this.ordinatMaximumGrid,
    required this.sortOrder,
    required this.availableForAllPosUsers,
    required this.deleted,
  });

  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);

  Map<String, dynamic> toJson() => _$AreaToJson(this);
}

@JsonSerializable()
class AreaToUser {
  final String posAreaId;
  final String userId;
  final int sortOrder;

  AreaToUser({
    required this.posAreaId,
    required this.userId,
    required this.sortOrder,
  });

  factory AreaToUser.fromJson(Map<String, dynamic> json) =>
      _$AreaToUserFromJson(json);

  Map<String, dynamic> toJson() => _$AreaToUserToJson(this);
}

@JsonSerializable()
class Customer {
  final String id;
  final String displayName;
  final String? firstName; // null for "Default Customer" entries
  final String? lastName; // null in real data
  final String? company; // null in real data
  final String? phone; // null in real data
  final String? email; // null in real data
  final String? dateOfBirth; // null in real data
  final String gender;
  final String address;
  final bool isDeleted;
  final String? bankAccountId; // null in real data
  final String? bankId; // null in real data
  final String? bankName; // null in real data
  final String? bankAccountNumber; // null in real data
  final String? bankAccountName; // null in real data
  final String defaultSalesPriceLevelId;

  Customer({
    required this.id,
    required this.displayName,
    this.firstName,
    this.lastName,
    this.company,
    this.phone,
    this.email,
    this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.isDeleted,
    this.bankAccountId,
    this.bankId,
    this.bankName,
    this.bankAccountNumber,
    this.bankAccountName,
    required this.defaultSalesPriceLevelId,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}

@JsonSerializable()
class SalesType {
  final String id;
  final String name;
  final bool isMaster;
  final bool serviceCharged;
  final bool taxed;
  final bool deleted;
  final String priceLevelId;

  SalesType({
    required this.id,
    required this.name,
    required this.isMaster,
    required this.serviceCharged,
    required this.taxed,
    required this.deleted,
    required this.priceLevelId,
  });

  factory SalesType.fromJson(Map<String, dynamic> json) =>
      _$SalesTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SalesTypeToJson(this);
}

@JsonSerializable()
class Discount {
  final String id;
  final String name;
  final String? description; // null in real data
  final String discountMode;
  final double discountValue;
  final double? minimumPurchaseAmount; // null when no minimum
  final double? maximumDiscountAmount; // null when no maximum

  Discount({
    required this.id,
    required this.name,
    this.description,
    required this.discountMode,
    required this.discountValue,
    this.minimumPurchaseAmount,
    this.maximumDiscountAmount,
  });

  factory Discount.fromJson(Map<String, dynamic> json) =>
      _$DiscountFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountToJson(this);
}

@JsonSerializable()
class PaymentMethod {
  final String paymentMethodId;
  final String paymentMethodName;
  final String paymentMethodType;
  final String paymentAccountId;
  final bool isDefaultCash;
  final int sortOrder;
  final bool deleted;

  PaymentMethod({
    required this.paymentMethodId,
    required this.paymentMethodName,
    required this.paymentMethodType,
    required this.paymentAccountId,
    required this.isDefaultCash,
    required this.sortOrder,
    required this.deleted,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);
}
