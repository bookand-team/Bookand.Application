import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  final List<NotificationContent> content;
  final bool last;
  final int totalElements;
  final int totalPages;

  NotificationModel(this.content, this.last, this.totalElements, this.totalPages);

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}

@JsonSerializable()
class NotificationContent {
  final int id;
  final String title;
  final String content;
  final String createdAt;

  NotificationContent(this.id, this.title, this.content, this.createdAt);

  factory NotificationContent.fromJson(Map<String, dynamic> json) =>
      _$NotificationContentFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationContentToJson(this);
}
