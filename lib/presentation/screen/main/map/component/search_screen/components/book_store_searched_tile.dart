import 'package:bookand/core/util/common_util.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/gen/assets.gen.dart';
import 'package:bookand/presentation/screen/main/home/bookstore_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookStoreSearchedTile extends StatelessWidget {
  final BookStoreMapModel model;
  const BookStoreSearchedTile({Key? key, required this.model})
      : super(key: key);

  final double height = 200;
  final Color borderColor = const Color(0xfff5f5f5);
  final EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 12);
  final EdgeInsets padding = const EdgeInsets.symmetric(vertical: 12);

  //image
  final double imageBRaidus = 4;
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
    return GestureDetector(
      onTap: () {
        context.pushNamed(BookstoreScreen.routeName,
            pathParameters: {'id': '${model.id}'});
      },
      child: Container(
        margin: margin,
        padding: padding,
        // width: screenSize.width * 9,
        // height: height,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: borderColor))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(imageBRaidus)),
                child: Assets.images.map.bookSearchedTest
                    .image(width: imageSize.width, height: imageSize.height)),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    style: titleStyle,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        '서울시 마포구',
                        style: locationStyle,
                      ),
                      Text(
                        CommonUtil.distance2TypedStr(model.userDistance!),
                        style: distanceStyle,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
