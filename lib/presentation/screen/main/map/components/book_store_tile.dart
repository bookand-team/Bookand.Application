import 'package:bookand/domain/model/bookstore/bookstore_model.dart';
import 'package:flutter/material.dart';

class BookStoreTile extends StatelessWidget {
  // final BookstoreModel model;
  const BookStoreTile({
    Key? key,
    // required this.model
  }) : super(key: key);

  final EdgeInsets padding = const EdgeInsets.all(5);
  final Color borderColor = const Color(0xfff5f5f5);

// sub styles
  final double tagBraidus = 2;
  final Color tagBorderColor = const Color(0xffdddddd);
  final Color bookMarkColor = const Color(0xfff5f5f7);

  final Size imageSize = const Size(328, 170);

//texts tyles
  final TextStyle titleStyle = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff222222));
  final TextStyle tagStyle = const TextStyle(
      fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xff222222));
  final TextStyle locationStyle = const TextStyle(
      fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff565656));
  final TextStyle distanceStyle = const TextStyle(
      fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xffff4f4f));
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: borderColor))),
      padding: padding,
      child: Column(
        children: [
          //image
          Image(
            image: const AssetImage('assets/images/map/book_tile_test.png'),
            width: imageSize.width,
            height: imageSize.height,
          ),
          Row(
            children: [
              // 제목
              Text(
                '제목 테스트',
                style: titleStyle,
              ),
              //tag container
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: tagBorderColor),
                    borderRadius: BorderRadius.circular(tagBraidus)),
                child: Text(
                  'tag테스트',
                  style: tagStyle,
                ),
              ),
              // bookmark button 북마크 버튼
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      color: bookMarkColor,
                      borderRadius: BorderRadius.circular(1000)),
                  child: const Image(
                      image:
                          AssetImage('assets/images/map/book_mark_test.png')),
                ),
              )
            ],
          ),
          // 위치 표시
          Row(
            children: [
              const Image(
                  image:
                      AssetImage('assets/images/map/location_icon_test.png')),
              Text(
                '거리 테스트',
                style: locationStyle,
              ),
              Text(
                '거리 m',
                style: distanceStyle,
              )
            ],
          )
        ],
      ),
    );
  }
}
