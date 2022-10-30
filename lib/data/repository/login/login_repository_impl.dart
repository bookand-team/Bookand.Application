import 'dart:io';

import 'package:bookand/data/model/token.dart';
import 'package:dio/dio.dart';

import '../../../../app_config.dart';
import '../../../../util/logger.dart';
import 'login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final _dio = Dio();

  LoginRepositoryImpl() {
    _dio.options.baseUrl = AppConfig.instance.baseUrl;
  }

  @override
  Future<Token> fetchLogin(Map<String, dynamic> query) async {
    final response = await _dio.get('api/v1/auth/login', queryParameters: query);

    switch (response.statusCode) {
      case HttpStatus.ok:
        logger.i(response.data);
        final token = Token.fromJson(response.data['data']);
        return token;
      default:
        final message = '''
        uri:${response.realUri}
        statusCode:${response.statusCode}
        data:${response.data}
        ''';
        throw (message);
    }
  }
}
