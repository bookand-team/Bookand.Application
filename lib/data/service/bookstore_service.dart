import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api_helper.dart';

part 'bookstore_service.chopper.dart';
part 'bookstore_service.g.dart';

@riverpod
BookstoreService bookstoreService(BookstoreServiceRef ref) =>
    BookstoreService.create(ApiHelper.client());

@ChopperApi(baseUrl: '/api/v1/bookstores')
abstract class BookstoreService extends ChopperService {
  static BookstoreService create([ChopperClient? client]) =>
      _$BookstoreService(client);

  @Post(path: '/report')
  Future<Response> bookstoreReport(
    @Header('Authorization') String accessToken,
    @Body() Map<String, dynamic> body,
  );

  @Get(path: '/{id}')
  Future<Response> getBookstoreDetail(
    @Header('Authorization') String accessToken,
    @Path('id') int id,
  );
}
