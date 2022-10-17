import 'package:bookand/app_config.dart';
import 'package:dio/dio.dart';

abstract class RemoteDataSource {
  final dio = Dio();

  RemoteDataSource() {
    dio.options.baseUrl = AppConfig.instance.baseUrl;
  }

}