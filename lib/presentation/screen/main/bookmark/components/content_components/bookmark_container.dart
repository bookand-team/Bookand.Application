import 'package:bookand/core/const/bookmark_type.dart';
import 'package:bookand/domain/model/bookmark/bookmark_model.dart';
import 'package:bookand/gen/assets.gen.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_eidt_list.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_type_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class BookmarkContainer extends ConsumerStatefulWidget {
  final BookmarkModel model;
  final void Function() onTap;
  final bool settingMode;
  static Size size = const Size(156, 208 + 24);
  const BookmarkContainer(
      {Key? key,
      required this.model,
      required this.onTap,
      required this.settingMode})
      : super(key: key);
  @override
  ConsumerState<BookmarkContainer> createState() => _BookmarkContainerState();
}

class _BookmarkContainerState extends ConsumerState<BookmarkContainer> {
  final Size imageSize = const Size(156, 156);
  final Size iconSize = const Size(12, 12);

  final BorderRadius imageBr = const BorderRadius.all(Radius.circular(8));
  final locationAssetPath = 'assets/images/map/location_icon.png';

  final TextStyle titleStyle = const TextStyle(
    color: Color(0xff222222),
    fontSize: 15,
    fontFamily: "Pretendard",
    fontWeight: FontWeight.w500,
  );
  final TextStyle locationStyle =
      const TextStyle(fontSize: 12, color: Color(0xff666666));
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    if (!widget.settingMode) isSelected = false;
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        BookmarkType type = ref.read(bookmarkTypeNotifierProvider);
        widget.settingMode
            ? ref
                .read(bookmarkEditListNotifierProvider.notifier)
                .toggle(type, widget.model)
            : widget.onTap();
      },
      child: SizedBox(
        width: BookmarkContainer.size.width,
        height: BookmarkContainer.size.height,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: imageBr,
                    child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          isSelected
                              ? const Color(0xffff540b).withOpacity(0.4)
                              : Colors.transparent,
                          BlendMode.colorBurn,
                        ),
                        child: CachedNetworkImage(
                          errorWidget: (_, __, ___) =>
                              Container(color: Colors.grey),
                          imageUrl: widget.model.image ??
                              'https://as1.ftcdn.net/v2/jpg/03/92/26/10/1000_F_392261071_S2G0tB0EyERSAk79LG12JJXmvw8DLNCd.jpg',
                          width: imageSize.width,
                          height: imageSize.height,
                          fit: BoxFit.fill,
                        ))),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Text(
                      widget.model.title!,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 15,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.30,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                (widget.model.location != null &&
                        widget.model.location != 'location')
                    ? Row(
                        children: [
                          SvgPicture.asset(Assets.images.bookstore.icLocation12,
                              width: iconSize.width, height: iconSize.height),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            widget.model.location ?? '',
                            style: const TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.24,
                            ),
                          )
                        ],
                      )
                    : const SizedBox()
              ],
            ),
            widget.settingMode
                ? Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1000),
                            color: isSelected
                                ? const Color(0xffFF540B)
                                : const Color(0xffDDDDDD)),
                        child: Center(
                          child: SvgPicture.asset(
                            Assets.images.icCheckActive,
                            width: 18,
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                            height: 18,
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
