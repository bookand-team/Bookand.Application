import 'package:bookand/core/util/common_util.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/screen/main/home/bookstore_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookStoreSearchedTile extends StatelessWidget {
  final BookStoreMapModel model;
  const BookStoreSearchedTile({Key? key, required this.model})
      : super(key: key);

  static const double height = 50 + 16;
  final Color borderColor = const Color(0xfff5f5f5);

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
    return GestureDetector(
      onTap: () {
        context.pushNamed(BookstoreScreen.routeName,
            pathParameters: {'id': '${model.id}'});
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        width: MediaQuery.of(context).size.width * .9,
        height: height,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: borderColor))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                width: imageSize.width,
                height: imageSize.height,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(imageBRaidus)),
                child: CachedNetworkImage(
                  errorWidget: (_, __, ___) => Container(color: Colors.grey),
                  imageUrl: model.mainImage ??
                      'https://as1.ftcdn.net/v2/jpg/03/92/26/10/1000_F_392261071_S2G0tB0EyERSAk79LG12JJXmvw8DLNCd.jpg',
                  width: imageSize.width,
                  height: imageSize.height,
                  fit: BoxFit.fill,
                )),
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
                        model.address ?? '',
                        style: locationStyle,
                      ),
                      Text(
                        model.userDistance == null
                            ? ''
                            : CommonUtil.distance2TypedStr(model.userDistance!),
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
