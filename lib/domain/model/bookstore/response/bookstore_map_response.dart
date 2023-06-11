import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';

class BookStoreGetAllResponse {
  List<BookStoreMapModel>? bookStoreAddressListResponse;

  BookStoreGetAllResponse({this.bookStoreAddressListResponse});

  BookStoreGetAllResponse.fromJson(Map<String, dynamic> json) {
    if (json['bookStoreAddressListResponse'] != null) {
      bookStoreAddressListResponse = <BookStoreMapModel>[];
      json['bookStoreAddressListResponse'].forEach((v) {
        bookStoreAddressListResponse!.add(BookStoreMapModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bookStoreAddressListResponse != null) {
      data['bookStoreAddressListResponse'] =
          bookStoreAddressListResponse!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
