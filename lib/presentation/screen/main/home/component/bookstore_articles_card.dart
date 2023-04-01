import 'package:bookand/domain/model/article/article_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../component/bookmark_button.dart';

class BookstoreArticlesCard extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final String imageUrl;
  final bool isBookmark;
  final Function() onTap;
  final Function() onTapBookmark;

  const BookstoreArticlesCard(
      {Key? key, required this.width, required this.height, required this.title, required this.imageUrl, required this.isBookmark, required this.onTap, required this.onTapBookmark})
      : super(key: key);

  factory BookstoreArticlesCard.fromModel({
    required ArticleContent? model,
    required double width,
    required double height,
    required Function() onTap,
    required Function() onTapBookmark,
  }) {
    return BookstoreArticlesCard(
        width: width,
        height: height,
        title: model?.title ?? '',
        imageUrl: model?.mainImage ?? '',
        isBookmark: model?.isBookmark ?? false,
        onTap: onTap,
        onTapBookmark: onTapBookmark);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: width,
              height: height,
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
                imageUrl: imageUrl,
                errorWidget: (_, __, ___) =>
                    Container(color: Colors.grey),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: BookmarkButton(
              isBookmark: isBookmark,
              onTapBookmark: onTapBookmark,
              backgroundColor: const Color(0xFFF5F5F5),
              radius: 12,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 12,
            right: 12,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
                letterSpacing: -0.02,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
