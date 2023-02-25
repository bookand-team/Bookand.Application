import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'policy_model.g.dart';

abstract class PolicyModelBase {}

class PolicyModelInit implements PolicyModelBase {}

class PolicyModelLoading implements PolicyModelBase {}

@JsonSerializable()
class PolicyModel implements PolicyModelBase {
  final int policyId;
  final String title;
  final String content;

  PolicyModel(this.policyId, this.title, this.content);

  factory PolicyModel.fromJson(Map<String, dynamic> json) => _$PolicyModelFromJson(json);

  Map<String, dynamic> toJson() => _$PolicyModelToJson(this);

  factory PolicyModel.convertUtf8({required PolicyModel model}) {
    final content = const Utf8Decoder().convert(model.content.codeUnits);

    return PolicyModel(
      model.policyId,
      model.title,
      content,
    );
  }
}
