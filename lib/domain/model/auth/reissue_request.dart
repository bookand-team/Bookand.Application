import 'package:json_annotation/json_annotation.dart';

part 'reissue_request.g.dart';

@JsonSerializable()
class ReissueRequest {
  final String refreshToken;

  ReissueRequest(this.refreshToken);

  factory ReissueRequest.fromJson(Map<String, dynamic> json) =>
      _$ReissueRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReissueRequestToJson(this);
}
