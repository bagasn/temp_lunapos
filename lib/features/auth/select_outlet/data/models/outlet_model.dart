import 'package:json_annotation/json_annotation.dart';

part 'outlet_model.g.dart';

@JsonSerializable()
class OutletPictureModel {
  final String? id;
  final String? largeUrl;
  final String? smallUrl;

  const OutletPictureModel({this.id, this.largeUrl, this.smallUrl});

  factory OutletPictureModel.fromJson(Map<String, dynamic> json) =>
      _$OutletPictureModelFromJson(json);

  Map<String, dynamic> toJson() => _$OutletPictureModelToJson(this);
}

@JsonSerializable()
class OutletModel {
  final String? outletId;
  final String? outletName;
  final String? companyName;
  final String? tenantId;
  final String? posAuthKey;
  final OutletPictureModel? outletPicture;
  final String? subscriptionDueDate;

  const OutletModel({
    this.outletId,
    this.outletName,
    this.companyName,
    this.tenantId,
    this.posAuthKey,
    this.outletPicture,
    this.subscriptionDueDate,
  });

  factory OutletModel.fromJson(Map<String, dynamic> json) =>
      _$OutletModelFromJson(json);

  Map<String, dynamic> toJson() => _$OutletModelToJson(this);
}
