import 'package:bookand/common/layout/common_layout.dart';
import 'package:bookand/common/theme/custom_text_style.dart';
import 'package:bookand/component/bookmark_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ArticleScreen extends ConsumerStatefulWidget {
  static String get routeName => 'article';
  final String name;

  const ArticleScreen({super.key, required this.name});

  @override
  ConsumerState<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends ConsumerState<ArticleScreen> {
  final scrollController = ScrollController();

  final defaultDurationMs = 500;

  bool _bookmarkVisible = false;
  double _bookmarkWidth = 0.0;
  double _bookmarkHeight = 0.0;

  bool _articleVisible = false;
  double _articleTopPadding = 30.0;

  double topHeight = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        _bookmarkVisible = true;
        _bookmarkWidth = 40.0;
        _bookmarkHeight = 40.0;
        _articleVisible = true;
        _articleTopPadding = 0.0;
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
    const durationMs = 300;

    return SliverAppBar(
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
                    AnimatedOpacity(
                      duration: Duration(milliseconds: defaultDurationMs),
                      opacity: _bookmarkVisible ? 1.0 : 0.5,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: defaultDurationMs),
                        width: _bookmarkVisible ? _bookmarkWidth : _bookmarkWidth / 2,
                        height: _bookmarkVisible ? _bookmarkHeight : _bookmarkWidth / 2,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: BookmarkButton(
                          isBookmark: false,
                          onTapBookmark: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            titlePadding: EdgeInsets.zero,
            centerTitle: false,
            expandedTitleScale: 1,
            background: Hero(
              tag: ObjectKey(widget.name),
              child: Container(
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
            ),
          );
        },
      ),
    );
  }

  Widget _articleBody() {
    return SliverToBoxAdapter(
      child: AnimatedPadding(
        duration: Duration(milliseconds: defaultDurationMs),
        padding: EdgeInsets.only(top: _articleTopPadding),
        child: AnimatedOpacity(
          duration: Duration(milliseconds: defaultDurationMs),
          opacity: _articleVisible ? 1.0 : 0.0,
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
        ),
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
          Padding(padding: EdgeInsets.only(left: 16, bottom: 24), child: Text('아티클 관련 서점')),
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
