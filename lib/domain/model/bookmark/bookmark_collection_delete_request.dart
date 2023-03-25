import 'package:json_annotation/json_annotation.dart';

import '../../../core/const/bookmark_type.dart';

part 'bookmark_collection_delete_request.g.dart';

@JsonSerializable()
class BookmarkCollectionDeleteRequest {
  final BookmarkType bookmarkType;
  final List<int> contentIdList;

  BookmarkCollectionDeleteRequest(this.bookmarkType, this.contentIdList);

  factory BookmarkCollectionDeleteRequest.fromJson(Map<String, dynamic> json) =>
      _$BookmarkCollectionDeleteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BookmarkCollectionDeleteRequestToJson(this);
}
