import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../main_tab.dart';

class BookstoreAppBar extends StatefulWidget {
  final double changeHeight;
  final Duration duration;
  final String imageUrl;
  final Function() onTapShare;

  const BookstoreAppBar(
      {Key? key,
      required this.changeHeight,
      required this.duration,
      required this.imageUrl,
      required this.onTapShare})
      : super(key: key);

  @override
  State<BookstoreAppBar> createState() => _BookstoreAppBarState();
}

class _BookstoreAppBarState extends State<BookstoreAppBar> {
  double topHeight = 0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      systemOverlayStyle:
          topHeight <= widget.changeHeight ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      automaticallyImplyLeading: false,
      expandedHeight: 360,
      elevation: 0,
      scrolledUnderElevation: 0,
      pinned: true,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      leadingWidth: 40,
      leading: InkWell(
        onTap: () {
          context.pop();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SvgPicture.asset(
            topHeight <= widget.changeHeight
                ? 'assets/images/home/ic_24_back_dark.svg'
                : 'assets/images/home/ic_24_back_white.svg',
            width: 24,
            height: 24,
          ),
        ),
      ),
      actions: [
        InkWell(
          onTap: widget.onTapShare,
          child: SvgPicture.asset(
            topHeight <= widget.changeHeight
                ? 'assets/images/home/ic_24_share_dark.svg'
                : 'assets/images/home/ic_24_share_white.svg',
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: InkWell(
            onTap: () {
              context.goNamed(MainTab.routeName);
            },
            child: SvgPicture.asset(
              topHeight <= widget.changeHeight
                  ? 'assets/images/home/ic_24_close_black.svg'
                  : 'assets/images/home/ic_24_close_white.svg',
            ),
          ),
        ),
      ],
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              topHeight = constraints.biggest.height;
            });
          });

          return FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,
            centerTitle: false,
            expandedTitleScale: 1,
            background: Container(
              width: MediaQuery.of(context).size.width,
              height: 448,
              foregroundDecoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.transparent,
                    Color.fromRGBO(0, 0, 0, 0.6),
                  ],
                ),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl,
                errorWidget: (_, __, ___) => Container(color: Colors.grey),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
