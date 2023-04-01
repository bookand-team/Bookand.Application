import 'package:bookand/presentation/provider/home_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../component/article_card.dart';
import 'article_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with AutomaticKeepAliveClientMixin {
  final scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  void _loadMore() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      ref.read(homeStateNotifierProvider.notifier).fetchNextArticleList();
    }
  }

  @override
  void initState() {
    ref.read(homeStateNotifierProvider.notifier).fetchArticleList();
    scrollController.addListener(_loadMore);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final homeProvider = ref.watch(homeStateNotifierProvider.notifier);
    final articleList = ref.watch(homeStateNotifierProvider);

    if (articleList.isEmpty && homeProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
        shrinkWrap: true,
        itemCount: articleList.length + 1,
        itemBuilder: (context, index) {
          if (index < articleList.length) {
            return Padding(
              padding: EdgeInsets.only(bottom: index == 19 ? 48 : 20),
              child: GestureDetector(
                onTap: () {
                  context.pushNamed(ArticleScreen.routeName, params: {
                    'id': articleList[index].id.toString(),
                    'isFirstScreen': 'true',
                  });
                },
                child: ArticleCard(
                  image: CachedNetworkImage(
                    imageUrl: articleList[index].mainImage,
                    errorWidget: (_, __, ___) => Container(color: Colors.grey),
                    fit: BoxFit.cover,
                  ),
                  isBookmark: articleList[index].isBookmark,
                  onTapBookmark: () {
                    homeProvider.updateBookmarkState(index);
                  },
                  hashtagList: articleList[index].articleTagList,
                  title: articleList[index].title,
                  content: articleList[index].content,
                ),
              ),
            );
          }

          if (!homeProvider.isLoading && homeProvider.isEnd) {
            return const SizedBox();
          } else {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
