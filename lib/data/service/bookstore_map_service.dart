import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api_helper.dart';

part 'bookstore_map_service.chopper.dart';
part 'bookstore_map_service.g.dart';

@riverpod
BookstoreMapService bookstoreService(BookstoreServiceRef ref) =>
    BookstoreMapService.create(ApiHelper.client());

@ChopperApi(baseUrl: '/api/v1/bookstores/address')
abstract class BookstoreMapService extends ChopperService {
  static BookstoreMapService create([ChopperClient? client]) =>
      _$BookstoreMapService(client);

  @Get()
  Future<Response> getBookstoreMap(
    @Header('Authorization') String accessToken,
  );
}
