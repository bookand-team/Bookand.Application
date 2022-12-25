import 'package:bookand/common/layout/common_layout.dart';
import 'package:bookand/common/theme/custom_text_style.dart';
import 'package:bookand/component/bookmark_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArticleScreen extends ConsumerStatefulWidget {
  static String get routeName => 'article';
  final String name;

  const ArticleScreen({super.key, required this.name});

  @override
  ConsumerState<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends ConsumerState<ArticleScreen> {
  final scrollController = ScrollController();

  int _bookmarkAnimDurationMilliseconds = 400;
  bool _bookmarkVisible = false;
  double _bookmarkWidth = 0.0;
  double _bookmarkHeight = 0.0;

  int _articleAnimDurationMilliseconds = 400;
  bool _articleVisible = false;
  double _articleTopPadding = 30.0;

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
          // SliverToBoxAdapter(
          //   child: _articleAppBar(),
          // ),
          _articleTop(),
          _articleBody(),
          _articleBottomTitle(),
          _articleBottom(),
        ],
      ),
    );
  }

  Widget _articleAppBar() {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: MediaQuery.of(context).size.width,
        height: kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset('assets/images/home/ic_24_back_white.svg'),
            ),
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset('assets/images/home/ic_24_share_white.svg'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _articleTop() {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 448,
        child: Stack(
          children: [
            Hero(
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
                        ]),
                  ),
                  child: Image.network(
                    'https://image.bookshopmap.com/600,fit,q60/venue/3.jpg?ver=1627280017',
                    fit: BoxFit.cover,
                  )),
            ),
            _articleAppBar(),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: _bookmarkAnimDurationMilliseconds),
                  opacity: _bookmarkVisible ? 1.0 : 0.0,
                  child: AnimatedSize(
                    duration: Duration(milliseconds: _bookmarkAnimDurationMilliseconds),
                    child: BookmarkButton(
                      width: _bookmarkWidth,
                      height: _bookmarkHeight,
                      isBookmark: false,
                      onTapBookmark: () {},
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                left: 24,
                bottom: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 210,
                      child: Text(
                        'title',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle().articleBoxTitleText(),
                      ),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 238,
                      child: Text(
                        'content',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle().articleBoxContentText(),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget _articleBody() {
    return SliverToBoxAdapter(
      child: AnimatedPadding(
        duration: Duration(milliseconds: _articleAnimDurationMilliseconds),
        padding: EdgeInsets.only(top: _articleTopPadding),
        child: AnimatedOpacity(
          duration: Duration(milliseconds: _articleAnimDurationMilliseconds),
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
