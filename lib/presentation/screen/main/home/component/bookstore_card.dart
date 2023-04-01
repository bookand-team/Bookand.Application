import 'package:bookand/domain/model/bookstore/bookstore_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../component/bookmark_button.dart';

class BookstoreCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String introduction;
  final List<String> themeList;
  final bool isBookmark;
  final Function() onTapBookmark;
  final Function() onTapCard;

  const BookstoreCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.introduction,
    required this.themeList,
    required this.isBookmark,
    required this.onTapBookmark,
    required this.onTapCard,
  }) : super(key: key);

  factory BookstoreCard.fromModel({
    required BookstoreContent bookstoreContent,
    required Function() onTapBookmark,
    required Function() onTapCard,
  }) {
    return BookstoreCard(
      imageUrl: bookstoreContent.mainImage,
      name: bookstoreContent.name,
      introduction: bookstoreContent.introduction,
      themeList: bookstoreContent.themeList,
      isBookmark: bookstoreContent.isBookmark,
      onTapBookmark: onTapBookmark,
      onTapCard: onTapCard,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTapCard,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 88,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              errorWidget: (_, __, ___) => Container(color: Colors.grey),
              width: 88,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Color(0xFF222222),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: -0.02,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      introduction,
                      style: const TextStyle(
                        color: Color(0xFF666666),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        letterSpacing: -0.02,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
                    const Spacer(),
                    Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, themeIdx) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFDDDDDD),
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Text(
                              themeList[themeIdx],
                              style: const TextStyle(
                                color: Color(0xFF666666),
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                letterSpacing: -0.02,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(width: 4),
                        itemCount: themeList.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BookmarkButton(
              isBookmark: isBookmark,
              onTapBookmark: onTapBookmark,
              backgroundColor: const Color(0xFFF5F5F5),
              radius: 16,
            ),
          ],
        ),
      ),
    );
  }
}
