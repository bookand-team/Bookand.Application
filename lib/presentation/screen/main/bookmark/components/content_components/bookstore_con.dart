import 'package:bookand/domain/model/bookstore/bookstore_detail.dart';
import 'package:flutter/material.dart';

// 북마크 페이지에서 북마크한 서점을 출력하기 위한 위젯
class BookstoreCon extends StatelessWidget {
  final BookstoreDetail bookstore;
  const BookstoreCon({Key? key, required this.bookstore}) : super(key: key);

  final Size size = const Size(156, 208);
  final Size imageSize = const Size(156, 156);
  final Size iconSize = const Size(12, 12);
  final BorderRadius imageBr = const BorderRadius.all(Radius.circular(8));
  final locationAssetPath = 'assets/images/map/location_icon.png';

  final TextStyle titleStyle =
      const TextStyle(fontSize: 15, color: Color(0xff222222));
  final TextStyle locationStyle =
      const TextStyle(fontSize: 12, color: Color(0xff666666));
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
            borderRadius: imageBr,
            child: Image.network(
              '',
              width: imageSize.width,
              height: imageSize.height,
            )),
        Text(
          bookstore.name!,
          style: titleStyle,
        ),
        Row(
          children: [
            Image.asset(
              locationAssetPath,
              width: iconSize.width,
              height: iconSize.height,
            ),
            Text(
              'test',
              style: locationStyle,
            )
          ],
        )
      ],
    );
  }
}
