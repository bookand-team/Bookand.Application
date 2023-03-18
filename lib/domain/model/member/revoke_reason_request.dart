import 'package:json_annotation/json_annotation.dart';

import '../../../core/const/revoke_type.dart';

part 'revoke_reason_request.g.dart';

@JsonSerializable()
class RevokeReasonRequest {
  final String? reason;
  final RevokeType revokeType;
  final String socialAccessToken;

  RevokeReasonRequest(this.reason, this.revokeType, this.socialAccessToken);

  factory RevokeReasonRequest.fromJson(Map<String, dynamic> json) =>
      _$RevokeReasonRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RevokeReasonRequestToJson(this);
}
