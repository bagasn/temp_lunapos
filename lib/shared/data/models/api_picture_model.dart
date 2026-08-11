import 'package:json_annotation/json_annotation.dart';

part 'api_picture_model.g.dart';

@JsonSerializable()
class ApiPictureModel {
  final String id;
  final String? fileType;
  final String? fileName;
  final String? fileExt;
  final int? fileSize;
  final String? description;
  final String? uploadByUserId;
  final String fileUrl;
  final String? thumbnailUrl;
  final String? smallUrl;
  final String? mediumUrl;
  final String? largeUrl;
  final String? tabletUrl;

  ApiPictureModel({
    required this.id,
    this.fileType,
    this.fileName,
    this.fileExt,
    this.fileSize,
    this.description,
    this.uploadByUserId,
    required this.fileUrl,
    this.thumbnailUrl,
    this.smallUrl,
    this.mediumUrl,
    this.largeUrl,
    this.tabletUrl,
  });

  factory ApiPictureModel.fromJson(Map<String, dynamic> json) =>
      _$ApiPictureModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiPictureModelToJson(this);
}
