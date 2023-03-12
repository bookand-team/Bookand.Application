import 'package:json_annotation/json_annotation.dart';

enum SortType {
  @JsonValue('ASC') asc,
  @JsonValue('DESC') desc
}
