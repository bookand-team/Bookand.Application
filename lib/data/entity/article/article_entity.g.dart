// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleEntity _$ArticleEntityFromJson(Map<String, dynamic> json) =>
    ArticleEntity(
      Article.fromJson(json['article'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ArticleEntityToJson(ArticleEntity instance) =>
    <String, dynamic>{
      'article': instance.article,
    };

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      json['totalPages'] as int,
      json['totalElements'] as int,
      json['last'] as bool,
      (json['content'] as List<dynamic>)
          .map((e) => Content.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'last': instance.last,
      'content': instance.content,
    };

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      json['id'] as int,
      json['title'] as String,
      json['content'] as String,
      json['category'] as String,
      json['writer'] as String,
      json['status'] as String,
      json['view'] as int,
      json['bookmark'] as int,
      json['createdDate'] as String,
      json['modifiedDate'] as String,
      json['visibility'] as bool,
      (json['bookStoreList'] as List<dynamic>)
          .map((e) => BookStoreList.fromJson(e as Map<String, dynamic>))
          .toList(),
      Filter.fromJson(json['filter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'category': instance.category,
      'writer': instance.writer,
      'status': instance.status,
      'view': instance.view,
      'bookmark': instance.bookmark,
      'createdDate': instance.createdDate,
      'modifiedDate': instance.modifiedDate,
      'visibility': instance.visibility,
      'bookStoreList': instance.bookStoreList,
      'filter': instance.filter,
    };

BookStoreList _$BookStoreListFromJson(Map<String, dynamic> json) =>
    BookStoreList(
      json['id'] as int,
      json['name'] as String,
      Info.fromJson(json['info'] as Map<String, dynamic>),
      json['theme'] as String,
      json['introduction'] as String,
      json['mainImage'] as String,
      (json['subImage'] as List<dynamic>)
          .map((e) => SubImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['status'] as String,
      json['view'] as int,
      json['bookmark'] as int,
      json['createdDate'] as String,
      json['modifiedDate'] as String,
      json['visibility'] as bool,
    );

Map<String, dynamic> _$BookStoreListToJson(BookStoreList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'info': instance.info,
      'theme': instance.theme,
      'introduction': instance.introduction,
      'mainImage': instance.mainImage,
      'subImage': instance.subImage,
      'status': instance.status,
      'view': instance.view,
      'bookmark': instance.bookmark,
      'createdDate': instance.createdDate,
      'modifiedDate': instance.modifiedDate,
      'visibility': instance.visibility,
    };

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      json['address'] as String,
      json['businessHours'] as String,
      json['contact'] as String,
      json['facility'] as String,
      json['sns'] as String,
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'address': instance.address,
      'businessHours': instance.businessHours,
      'contact': instance.contact,
      'facility': instance.facility,
      'sns': instance.sns,
    };

SubImage _$SubImageFromJson(Map<String, dynamic> json) => SubImage(
      json['id'] as int,
      json['bookStore'] as String,
      json['url'] as String,
    );

Map<String, dynamic> _$SubImageToJson(SubImage instance) => <String, dynamic>{
      'id': instance.id,
      'bookStore': instance.bookStore,
      'url': instance.url,
    };

Filter _$FilterFromJson(Map<String, dynamic> json) => Filter(
      json['deviceOS'] as String,
      json['memberId'] as String,
    );

Map<String, dynamic> _$FilterToJson(Filter instance) => <String, dynamic>{
      'deviceOS': instance.deviceOS,
      'memberId': instance.memberId,
    };
