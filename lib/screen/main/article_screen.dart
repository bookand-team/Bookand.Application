import 'package:bookand/common/layout/common_layout.dart';
import 'package:bookand/common/theme/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class ArticleScreen extends ConsumerWidget {
  static String get routeName => 'article';
  final String name;
  final scrollController = ScrollController();

  ArticleScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonLayout(
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 448,
            elevation: 0,
            scrolledUnderElevation: 0,
            pinned: true,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 448,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://image.bookshopmap.com/600,fit,q60/venue/3.jpg?ver=1627280017'),
                          fit: BoxFit.cover)),
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.transparent,
                                Color.fromRGBO(0, 0, 0, 0.6),
                              ]),
                        ),
                      ),
                      Positioned(
                        right: 16,
                        bottom: 30,
                        child: GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset('assets/images/home/ic_40_bookmark_inactive.svg'),
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
                )),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  child: MarkdownBody(
                      data:
                          'dadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadatadadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatatadatadatadatadata'),
                ),
                Tooltip(
                  message: 'sddssdsd',
                  child: Divider(
                    thickness: 8,
                  ),
                ),
                SizedBox(height: 32),
                Padding(padding: EdgeInsets.only(left: 16, bottom: 24), child: Text('아티클 관련 서점'))
              ],
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return const ListTile(
              title: Text('서점서점서점') ,
            );
          }, childCount: 3))
        ],
      ),
    );
  }
}
