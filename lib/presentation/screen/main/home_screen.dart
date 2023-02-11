import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../component/article_card.dart';
import 'article_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
        shrinkWrap: true,
        itemCount: 20,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: index == 19 ? 48 : 20),
            child: GestureDetector(
              onTap: () {
                context.pushNamed(ArticleScreen.routeName, params: {'id': index.toString()});
              },
              child: ArticleCard(
                image: Image.network(
                  'https://image.bookshopmap.com/600,fit,q60/venue/3.jpg?ver=1627280017',
                  fit: BoxFit.cover,
                ),
                isBookmark: false,
                onTapBookmark: () {},
                hashtagList: const ['#여행', '#가을', '#친구랑'],
                title: '제목제목제목제목제목제목제목제목$index',
                content: '내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용$index',
                heroKey: index.toString(),
              ),
            ),
          );
        });
  }
}
