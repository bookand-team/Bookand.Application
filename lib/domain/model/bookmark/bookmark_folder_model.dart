// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

import '../../../core/const/bookmark_type.dart';

part 'bookmark_folder_model.g.dart';

@JsonSerializable()
class BookmarkFolderModel {
  int? bookmarkId;
  String? bookmarkImage;
  BookmarkType? bookmarkType;
  String? folderName;

  BookmarkFolderModel(
      {this.bookmarkId,
      this.bookmarkImage,
      this.bookmarkType,
      this.folderName});

  factory BookmarkFolderModel.fromJson(Map<String, dynamic> json) =>
      _$BookmarkFolderModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookmarkFolderModelToJson(this);
}
