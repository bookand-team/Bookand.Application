import 'package:bookand/core/const/asset_path.dart';
import 'package:bookand/presentation/component/map/book_mark_button.dart';
import 'package:flutter/material.dart';

class BookStoreTile extends StatelessWidget {
  // final BookstoreModel model;
  const BookStoreTile({
    Key? key,
    // required this.model
  }) : super(key: key);

  final EdgeInsets padding = const EdgeInsets.symmetric(vertical: 15);
  final Color borderColor = const Color(0xfff5f5f5);

  // tag 태그
  final double tagBraidus = 2;
  final Color tagBorderColor = const Color(0xffdddddd);
  final EdgeInsets tagMargin = const EdgeInsets.symmetric(horizontal: 7);
  //장소 아이콘
  final Size locaitonIconSize = const Size(10, 14);

//book mark 북마크
  final Color bookMarkColor = const Color(0xfff5f5f7);
  final Size bookMarkSize = const Size(40, 40);
  final Size bookMarkInnerSize = const Size(15, 21.5);

  //image
  final double imageBRaidus = 8;
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
        mainAxisSize: MainAxisSize.min,
        children: [
          //image, 이미지
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(imageBRaidus)),
            child: Image(
              image: const AssetImage('assets/images/map/book_tile_test.png'),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      // 제목
                      Text(
                        '사적인 서점',
                        style: titleStyle,
                      ),
                      //tag container 태그
                      Container(
                        margin: tagMargin,
                        decoration: BoxDecoration(
                            border: Border.all(color: tagBorderColor),
                            borderRadius: BorderRadius.circular(tagBraidus)),
                        child: Text(
                          '#음악',
                          style: tagStyle,
                        ),
                      ),
                      // bookmark button 북마크 버튼
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // 위치 표시
                  Row(
                    children: [
                      //아이콘
                      Image(
                          width: locaitonIconSize.width,
                          height: locaitonIconSize.height,
                          image: const AssetImage(locationIconPath)),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        '서울 마포구',
                        style: locationStyle,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        '300 m',
                        style: distanceStyle,
                      )
                    ],
                  )
                ],
              ),
              // book mark 북마크 버튼

              GestureDetector(
                onTap: () {},
                child: Container(
                  width: bookMarkSize.width,
                  height: bookMarkSize.height,
                  decoration: BoxDecoration(
                      color: bookMarkColor,
                      borderRadius: BorderRadius.circular(1000)),
                  child: BookMarkButton(),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
