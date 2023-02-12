import 'package:bookand/core/app_strings.dart';
import 'package:bookand/core/theme/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/layout/common_layout.dart';
import '../../component/bookmark_button.dart';

class ArticleScreen extends ConsumerStatefulWidget {
  static String get routeName => 'article';
  final String name;

  const ArticleScreen({super.key, required this.name});

  @override
  ConsumerState<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends ConsumerState<ArticleScreen> {
  final scrollController = ScrollController();

  bool _articleVisible = false;
  double topHeight = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        _articleVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          _articleAppBar(),
          _articleBody(),
          _articleBottomTitle(),
          _articleBottom(),
        ],
      ),
    );
  }

  Widget _articleAppBar() {
    const changeHeight = 170;
    const durationMs = 200;

    return SliverAppBar(
      systemOverlayStyle:
          topHeight <= changeHeight ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
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
            topHeight <= changeHeight
                ? 'assets/images/home/ic_24_back_dark.svg'
                : 'assets/images/home/ic_24_back_white.svg',
            width: 24,
            height: 24,
          ),
        ),
      ),
      actions: [
        InkWell(
          onTap: () {},
          child: SvgPicture.asset(
            topHeight <= changeHeight
                ? 'assets/images/home/ic_24_share_dark.svg'
                : 'assets/images/home/ic_24_share_white.svg',
          ),
        ),
        const SizedBox(
          width: 16,
        ),
      ],
      title: AnimatedOpacity(
        duration: const Duration(milliseconds: durationMs),
        opacity: topHeight <= changeHeight ? 1 : 0,
        child: const Text(
          'title',
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
              duration: const Duration(milliseconds: durationMs),
              opacity: topHeight <= changeHeight ? 0 : 1,
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
                      children: [
                        Text(
                          'title',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle().articleBoxTitleText(),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'content',
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
                        isBookmark: false,
                        onTapBookmark: () {},
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
              child: Image.network(
                'https://image.bookshopmap.com/600,fit,q60/venue/3.jpg?ver=1627280017',
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _articleBody() {
    return SliverToBoxAdapter(
      child: Column(
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: MarkdownBody(
                data:
                    'dadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadata'),
          ),
        ],
      ),
    );
  }

  Widget _articleBottomTitle() {
    return SliverToBoxAdapter(
      child: Column(
        children: const [
          Divider(
            thickness: 8,
          ),
          SizedBox(height: 32),
          Padding(
              padding: EdgeInsets.only(left: 16, bottom: 24),
              child: Text(AppStrings.articleRelatedBookstore)),
        ],
      ),
    );
  }

  Widget _articleBottom() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return const ListTile(
            title: Text('서점서점서점'),
          );
        },
        childCount: 3,
      ),
    );
  }
}
