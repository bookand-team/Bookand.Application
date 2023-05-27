import 'package:bookand/core/app_strings.dart';
import 'package:bookand/presentation/provider/article_provider.dart';
import 'package:bookand/presentation/screen/main/home/component/article_app_bar.dart';
import 'package:bookand/presentation/screen/main/home/component/bookstore_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/widget/base_layout.dart';
import '../../../../domain/model/bookstore/bookstore_model.dart';
import 'bookstore_screen.dart';

class ArticleScreen extends ConsumerStatefulWidget {
  static String get routeName => 'article';
  final String id;
  final String isFirstScreen;

  const ArticleScreen({
    super.key,
    required this.id,
    required this.isFirstScreen,
  });

  @override
  ConsumerState<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends ConsumerState<ArticleScreen> {
  @override
  void didChangeDependencies() {
    ref.read(articleStateNotifierProvider.notifier).fetchArticleDetail(int.parse(widget.id));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final articleProvider = ref.watch(articleStateNotifierProvider.notifier);
    final articleDetail = ref.watch(articleStateNotifierProvider);

    return BaseLayout(
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          ArticleAppBar.fromModel(
            articleDetail: articleDetail,
            changeHeight: 170,
            duration: const Duration(milliseconds: 200),
            onTapBookmark: () => articleProvider.updateArticleBookmark(),
            onTapShare: () {
              // TODO: 임시
              Share.share('공유하기 테스트');
            },
            showCloseBtn: widget.isFirstScreen != 'true',
          ),
          _articleBody(articleDetail.content ?? ''),
          _articleFooter(
            bookstoreList: articleDetail.bookstoreList ?? [],
            onTapBookmark: (index) => articleProvider.updateBookstoreBookmark(index),
            onTapBookstoreCard: (index) {
              final bookstoreId = articleDetail.bookstoreList?[index].id;
              if (bookstoreId == null) return;

              context.pushNamed(BookstoreScreen.routeName, pathParameters: {'id': bookstoreId.toString()});
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
              height: 0,
              color: Color(0xFFF5F5F5),
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
