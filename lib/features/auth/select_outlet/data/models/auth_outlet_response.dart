// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:pos/shared/data/models/api_picture_model.dart';

part 'auth_outlet_response.g.dart';

@JsonSerializable()
class AuthOutletResponse {
  final int outletId;
  final String outletName;
  final String companyName;
  final int tenantId;
  final String posAuthKey;
  final String subscriptionDueDate;
  final ApiPictureModel? outletPicture;

  AuthOutletResponse({
    required this.outletId,
    required this.outletName,
    required this.companyName,
    required this.tenantId,
    required this.posAuthKey,
    required this.subscriptionDueDate,
    this.outletPicture,
  });

  factory AuthOutletResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthOutletResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthOutletResponseToJson(this);
}
