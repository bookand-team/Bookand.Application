import 'package:json_annotation/json_annotation.dart';

part 'notification_detail_model.g.dart';

@JsonSerializable()
class NotificationDetailModel {
  final int id;
  final String title;
  final String content;
  final String createdAt;

  NotificationDetailModel(this.id, this.title, this.content, this.createdAt);

  factory NotificationDetailModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDetailModelToJson(this);
}
