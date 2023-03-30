import 'package:bookand/domain/model/bookstore/bookstore_model.dart';
import 'package:flutter/material.dart';

class BookStoreSearchedTile extends StatelessWidget {
  // final BookstoreModel model;
  const BookStoreSearchedTile({
    Key? key,
    //  required this.model
  }) : super(key: key);

  final double height = 200;
  final Color borderColor = const Color(0xfff5f5f5);
  final Size imageSize = const Size(50, 50);

  final TextStyle titleStyle = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xff222222));
  final TextStyle locationStyle = const TextStyle(
      fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff565656));
  final TextStyle distanceStyle = const TextStyle(
      fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xffff4f4f));
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width * 9,
      height: height,
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: borderColor))),
      child: Row(
        children: [
          const Image(
              image: AssetImage('assets/images/map/book_searched_test.svg')),
          Column(
            children: [
              Text(
                '제목 test',
                style: titleStyle,
              ),
              Row(
                children: [
                  Text(
                    'test des',
                    style: locationStyle,
                  ),
                  Text(
                    'test 거리',
                    style: distanceStyle,
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
