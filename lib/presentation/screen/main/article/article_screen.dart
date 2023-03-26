import 'package:bookand/core/app_strings.dart';
import 'package:bookand/presentation/provider/article_provider.dart';
import 'package:bookand/presentation/screen/main/article/component/article_app_bar.dart';
import 'package:bookand/presentation/screen/main/article/component/bookstore_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widget/base_layout.dart';
import '../../../../domain/model/bookstore/bookstore_model.dart';

class ArticleScreen extends ConsumerStatefulWidget {
  static String get routeName => 'article';
  final String id;

  const ArticleScreen({super.key, required this.id});

  @override
  ConsumerState<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends ConsumerState<ArticleScreen> {
  @override
  void initState() {
    ref.read(articleStateNotifierProvider.notifier).fetchArticleDetail(int.parse(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final articleProvider = ref.watch(articleStateNotifierProvider.notifier);
    final articleDetail = ref.watch(articleStateNotifierProvider);

    return BaseLayout(
      child: CustomScrollView(
        slivers: [
          ArticleAppBar.fromModel(
            articleDetail: articleDetail,
            changeHeight: 170,
            duration: const Duration(milliseconds: 200),
            onTapBookmark: () => articleProvider.updateArticleBookmark(),
            onTapShare: () => articleProvider.onTapArticleShare(),
          ),
          _articleBody(articleDetail.content ?? ''),
          _articleFooter(
            bookstoreList: articleDetail.bookstoreList ?? [],
            onTapBookmark: (index) => articleProvider.updateBookstoreBookmark(index),
            onTapBookstoreCard: (index) {
              final bookstoreId = articleDetail.bookstoreList?[index].id;
              if (bookstoreId != null) {
                // TODO: 서점 상세
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _articleBody(String content) => SliverToBoxAdapter(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: MarkdownBody(data: content),
            ),
          ],
        ),
      );

  Widget _articleFooter({
    required List<BookstoreContent> bookstoreList,
    required Function(int index) onTapBookmark,
    required Function(int index) onTapBookstoreCard,
  }) =>
      SliverToBoxAdapter(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              thickness: 8,
            ),
            const SizedBox(height: 32),
            const Padding(
                padding: EdgeInsets.only(left: 16, bottom: 24),
                child: Text(
                  AppStrings.articleRelatedBookstore,
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    letterSpacing: -0.02,
                  ),
                )),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 31),
              itemBuilder: (_, index) => BookstoreCard.fromModel(
                bookstoreContent: bookstoreList[index],
                onTapBookmark: () {
                  onTapBookmark(index);
                },
                onTapCard: () {
                  onTapBookstoreCard(index);
                },
              ),
              separatorBuilder: (_, __) {
                return const Divider(
                  thickness: 2,
                  height: 0,
                );
              },
              itemCount: bookstoreList.length,
            ),
          ],
        ),
      );
}
