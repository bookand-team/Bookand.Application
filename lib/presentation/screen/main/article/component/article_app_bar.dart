import 'package:bookand/core/theme/custom_text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../domain/model/article/article_detail.dart';
import '../../../../component/bookmark_button.dart';

class ArticleAppBar extends StatefulWidget {
  final double changeHeight;
  final Duration duration;
  final String title;
  final String subTitle;
  final String imageUrl;
  final bool isBookmark;
  final Function() onTapBookmark;
  final Function() onTapShare;

  const ArticleAppBar({
    Key? key,
    required this.changeHeight,
    required this.duration,
    required this.title,
    required this.subTitle,
    required this.imageUrl,
    required this.isBookmark,
    required this.onTapBookmark,
    required this.onTapShare,
  }) : super(key: key);

  factory ArticleAppBar.fromModel({
    required ArticleDetail articleDetail,
    required double changeHeight,
    required Duration duration,
    required Function() onTapBookmark,
    required Function() onTapShare,
  }) {
    return ArticleAppBar(
      changeHeight: changeHeight,
      duration: duration,
      title: articleDetail.title ?? '',
      // TODO: api 변경되면 수정
      // subTitle: articleDetail.subTitle ?? '',
      subTitle: '부제목',
      imageUrl: articleDetail.mainImage ?? '',
      isBookmark: articleDetail.bookmark ?? false,
      onTapBookmark: onTapBookmark,
      onTapShare: onTapShare,
    );
  }

  @override
  State<ArticleAppBar> createState() => _ArticleAppBarState();
}

class _ArticleAppBarState extends State<ArticleAppBar> {
  double topHeight = 0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      systemOverlayStyle:
          topHeight <= widget.changeHeight ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      automaticallyImplyLeading: false,
      expandedHeight: 448,
      elevation: 0,
      scrolledUnderElevation: 0,
      pinned: true,
      centerTitle: true,
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
      ],
      title: AnimatedOpacity(
        duration: widget.duration,
        opacity: topHeight <= widget.changeHeight ? 1 : 0,
        child: Text(
          widget.title,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              topHeight = constraints.biggest.height;
            });
          });

          return FlexibleSpaceBar(
            title: AnimatedOpacity(
              duration: widget.duration,
              opacity: topHeight <= widget.changeHeight ? 0 : 1,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 25,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle().articleBoxTitleText(),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.subTitle,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle().articleBoxContentText(),
                        ),
                      ],
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: BookmarkButton(
                        isBookmark: widget.isBookmark,
                        onTapBookmark: widget.onTapBookmark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
