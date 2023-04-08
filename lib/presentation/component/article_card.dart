import 'package:bookand/core/theme/custom_text_style.dart';
import 'package:flutter/material.dart';

import 'bookmark_button.dart';
import 'hashtag_box.dart';

class ArticleCard extends StatelessWidget {
  final Widget image;
  final bool isBookmark;
  final Function() onTapBookmark;
  final List<String> hashtagList;
  final String title;
  final String content;

  const ArticleCard({
    super.key,
    required this.image,
    required this.isBookmark,
    required this.onTapBookmark,
    required this.hashtagList,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: const [
        BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.3), offset: Offset(0, 4), blurRadius: 20)
      ]),
      child: Stack(
        children: [
          Container(
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.transparent,
                    Color.fromRGBO(0, 0, 0, 0.6),
                  ]),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: OverflowBox(
                minWidth: 0,
                minHeight: 0,
                maxWidth: double.infinity,
                child: image,
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 16,
            child: BookmarkButton(
              isBookmark: isBookmark,
              onTapBookmark: onTapBookmark,
            ),
          ),
          Positioned(
              left: 24,
              bottom: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 20,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: hashtagList
                          .map((tag) => Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: HashtagBox(tag: tag),
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 210,
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle().articleBoxTitleText(),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 238,
                    child: Text(
                      content,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle().articleBoxContentText(),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
