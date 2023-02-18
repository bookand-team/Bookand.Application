import 'package:json_annotation/json_annotation.dart';

part 'result_response.g.dart';

@JsonSerializable()
class ResultResponse {
  final String result;

  ResultResponse(this.result);

  factory ResultResponse.fromJson(Map<String, dynamic> json) => _$ResultResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResultResponseToJson(this);
}
