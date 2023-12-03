import 'package:json_annotation/json_annotation.dart';

part 'bookstore_report_request.g.dart';

@JsonSerializable()
class BookstoreReportRequest {
  final String address;
  final String name;

  BookstoreReportRequest(this.address, this.name);

  factory BookstoreReportRequest.fromJson(Map<String, dynamic> json) =>
      _$BookstoreReportRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BookstoreReportRequestToJson(this);
}
