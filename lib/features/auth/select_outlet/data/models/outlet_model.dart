import 'package:json_annotation/json_annotation.dart';

part 'outlet_model.g.dart';

@JsonSerializable()
class OutletPictureModel {
  final String? id;
  final String? fileType;
  final String? fileName;
  final String? fileExt;
  final int? fileSize;
  final String? description;
  final String? uploadByUserId;
  final String? fileUrl;
  final String? thumbnailUrl;
  final String? smallUrl;
  final String? mediumUrl;
  final String? largeUrl;
  final String? tabletUrl;

  const OutletPictureModel({
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

  factory OutletPictureModel.fromJson(Map<String, dynamic> json) =>
      _$OutletPictureModelFromJson(json);

  Map<String, dynamic> toJson() => _$OutletPictureModelToJson(this);
}

@JsonSerializable()
class OutletModel {
  final int? outletId;
  final String? outletName;
  final String? companyName;
  final int? tenantId;
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
