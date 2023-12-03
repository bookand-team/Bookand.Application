import 'package:json_annotation/json_annotation.dart';

enum PlatformType {
  @JsonValue('ALL')
  none,
  @JsonValue('ANDROID')
  android,
  @JsonValue('IOS')
  ios
}
