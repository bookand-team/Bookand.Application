import 'package:bookand/core/const/app_mode.dart';
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
  static Size size = const Size(156, 208);
  const BookmarkContainer(
      {Key? key,
      required this.model,
      required this.onTap,
      required this.settingMode})
      : super(key: key);
  @override
  _BookmarkContainerState createState() => _BookmarkContainerState();
}

class _BookmarkContainerState extends ConsumerState<BookmarkContainer> {
  final Size imageSize = const Size(156, 156);
  final Size iconSize = const Size(12, 12);

  final BorderRadius imageBr = const BorderRadius.all(Radius.circular(8));
  final locationAssetPath = 'assets/images/map/location_icon.png';

  final TextStyle titleStyle =
      const TextStyle(fontSize: 15, color: Color(0xff222222));
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
                      child: CAN_IMAGE
                          ? CachedNetworkImage(
                              imageUrl: widget.model.image!,
                              width: imageSize.width,
                              height: imageSize.height,
                            )
                          : Container(
                              color: Colors.grey.shade300,
                              width: imageSize.width,
                              height: imageSize.height,
                            ),
                    )),
                Row(
                  children: [
                    Text(
                      widget.model.title!,
                      textAlign: TextAlign.start,
                      style: titleStyle,
                    )
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(Assets.images.bookstore.icLocation12,
                        width: iconSize.width, height: iconSize.height),
                    Text(
                      widget.model.location!,
                      style: locationStyle,
                    )
                  ],
                )
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
                            color: Colors.white,
                            width: 18,
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
