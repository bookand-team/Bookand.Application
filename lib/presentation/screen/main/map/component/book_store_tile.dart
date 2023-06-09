import 'package:bookand/core/util/common_util.dart';
import 'package:bookand/domain/model/bookmark/bookmark_model.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/gen/assets.gen.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_store_provider.dart';
import 'package:bookand/presentation/screen/main/home/bookstore_screen.dart';
import 'package:bookand/presentation/screen/main/map/component/book_mark_button.dart';
import 'package:bookand/presentation/screen/main/map/component/theme_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class BookStoreTile extends ConsumerWidget {
  final BookStoreMapModel store;
  const BookStoreTile({Key? key, required this.store}) : super(key: key);

  static const double height = 260;

  final EdgeInsets padding = const EdgeInsets.only(top: 15, bottom: 5);
  final Color borderColor = const Color(0xfff5f5f5);

  // tag 태그
  final double tagBraidus = 2;
  final Color tagBorderColor = const Color(0xffdddddd);
  final EdgeInsets tagMargin = const EdgeInsets.symmetric(horizontal: 3);
  final EdgeInsets tagPadding =
      const EdgeInsets.symmetric(horizontal: 3, vertical: 2);
  //장소 아이콘
  final Size locaitonIconSize = const Size(16, 16);

//book mark 북마크
  final Color bookMarkColor = const Color(0xfff5f5f7);
  final Size bookMarkSize = const Size(40, 40);
  final Size bookMarkInnerSize = const Size(15, 21.5);

  //image
  final double imageBRaidus = 8;
  final Size imageSize = const Size(328, 170);

//texts tyles
  final TextStyle titleStyle = const TextStyle(
      fontFamily: "Pretendard",
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color(0xff222222));
  final TextStyle tagStyle = const TextStyle(
      fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xff222222));
  final TextStyle locationStyle = const TextStyle(
      fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff565656));
  final TextStyle distanceStyle = const TextStyle(
      fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xffff4f4f));

  Widget themeText(Themes theme) {
    return Container(
      margin: tagMargin,
      padding: tagPadding,
      decoration: BoxDecoration(
          border: Border.all(color: tagBorderColor),
          borderRadius: BorderRadius.circular(tagBraidus)),
      child: Text(
        '#' + ThemeUtils.theme2Str(theme)!,
        style: tagStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: height,
      // decoration:
      //     BoxDecoration(border: Border(bottom: BorderSide(color: borderColor))),
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //image, 이미지
          GestureDetector(
            onTap: () {
              context.goNamed(BookstoreScreen.routeName,
                  pathParameters: {'id': store.id.toString()});
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 170,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(imageBRaidus)),
              child: CachedNetworkImage(
                errorWidget: (_, __, ___) => Container(color: Colors.grey),
                imageUrl: store.mainImage ??
                    'https://as1.ftcdn.net/v2/jpg/03/92/26/10/1000_F_392261071_S2G0tB0EyERSAk79LG12JJXmvw8DLNCd.jpg',
                width: MediaQuery.of(context).size.width,
                height: 170,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      // 제목
                      Text(
                        store.name ?? '',
                        style: titleStyle,
                      ),
                      const SizedBox(width: 8),
                      //tag container 태그
                      ...store.theme!.map((e) => themeText(e))
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
                      SvgPicture.asset(Assets.images.map.bookstoreTilePosition,
                          width: locaitonIconSize.width,
                          height: locaitonIconSize.height),

                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        store.address ?? '',
                        style: const TextStyle(
                          color: Color(0xff565656),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        store.userDistance == null
                            ? ''
                            : CommonUtil.distance2TypedStr(store.userDistance!),
                        style: distanceStyle,
                      )
                    ],
                  )
                ],
              ),
              // book mark 북마크 버튼

              BookMarkButton(
                acitve: store.isBookmark!,
                onAcive: () {
                  store.isBookmark = true;
                  ref.read(bookmarkStoreNotifierProvider.notifier).add(
                      BookmarkModel(
                          bookmarkId: store.id,
                          image: store.mainImage,
                          location: store.address,
                          title: store.name));
                },
                onDisactive: () {
                  store.isBookmark = false;
                  ref
                      .read(bookmarkStoreNotifierProvider.notifier)
                      .delete([store.id!]);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
