// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$ArticleService extends ArticleService {
  _$ArticleService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ArticleService;

  @override
  Future<Response<dynamic>> getArticleList(int page) {
    final Uri $url = Uri.parse('/api/v1/articles');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getArticleDetail(int id) {
    final Uri $url = Uri.parse('/api/v1/articles/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
