import 'package:bookand/core/theme/color_table.dart';
import 'package:bookand/presentation/provider/bookstore_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/widget/base_layout.dart';
import '../../../component/bookmark_button.dart';
import '../main_tab.dart';
import 'article_screen.dart';
import 'bookstore_map_screen.dart';

class BookstoreScreen extends ConsumerStatefulWidget {
  static String get routeName => 'bookstore';
  final String id;

  const BookstoreScreen({Key? key, required this.id}) : super(key: key);

  @override
  ConsumerState<BookstoreScreen> createState() => _BookstoreScreenState();
}

class _BookstoreScreenState extends ConsumerState<BookstoreScreen> {
  double topHeight = 0;
  double changeHeight = 170;
  Duration duration = const Duration(milliseconds: 200);

  @override
  void didChangeDependencies() {
    ref.read(bookstoreStateNotifierProvider.notifier).fetchBookstoreDetail(int.parse(widget.id));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bookstoreProvider = ref.watch(bookstoreStateNotifierProvider.notifier);
    final bookstoreDetail = ref.watch(bookstoreStateNotifierProvider);

    return BaseLayout(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle:
                topHeight <= changeHeight ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
            automaticallyImplyLeading: false,
            expandedHeight: 360,
            elevation: 0,
            scrolledUnderElevation: 0,
            pinned: true,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
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
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: InkWell(
                  onTap: () {
                    context.goNamed(MainTab.routeName);
                  },
                  child: SvgPicture.asset(
                    topHeight <= changeHeight
                        ? 'assets/images/home/ic_24_close_black.svg'
                        : 'assets/images/home/ic_24_close_white.svg',
                  ),
                ),
              ),
            ],
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    topHeight = constraints.biggest.height;
                  });
                });

                return FlexibleSpaceBar(
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
                    child: CachedNetworkImage(
                      imageUrl: bookstoreDetail.mainImage ?? '',
                      errorWidget: (_, __, ___) => Container(color: Colors.grey),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bookstoreDetail.name ?? '',
                            style: const TextStyle(
                              color: lightColorFF222222,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              letterSpacing: -0.02,
                            ),
                          ),
                          Text(
                            bookstoreDetail.introduction ?? '',
                            style: const TextStyle(
                              color: Color(0xFF666666),
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              letterSpacing: -0.02,
                            ),
                          ),
                        ],
                      ),
                      BookmarkButton(
                        isBookmark: bookstoreDetail.isBookmark ?? false,
                        onTapBookmark: () {
                          bookstoreProvider.updateBookstoreBookmark();
                        },
                        backgroundColor: const Color(0xFFF5F5F5),
                        radius: 20,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(
                      color: Color(0xFFF5F5F5),
                      thickness: 2,
                      height: 0,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/bookstore/ic_location_12.svg',
                      ),
                      const SizedBox(width: 4),
                      Text(
                        bookstoreDetail.info?.address ?? '',
                        style: const TextStyle(
                          color: lightColorFF222222,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          letterSpacing: -0.02,
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          final address = bookstoreDetail.info?.address;
                          if (address == null) return;
                          Clipboard.setData(ClipboardData(text: address));
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/bookstore/ic_copy_8.svg',
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '복사',
                              style: TextStyle(
                                color: Color(0xFF346FC9),
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                letterSpacing: -0.02,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/bookstore/ic_alarm_12.svg',
                      ),
                      const SizedBox(width: 4),
                      Text(
                        bookstoreDetail.info?.businessHours ?? '',
                        style: const TextStyle(
                          color: lightColorFF222222,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          letterSpacing: -0.02,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/bookstore/ic_call_12.svg',
                      ),
                      const SizedBox(width: 4),
                      Text(
                        bookstoreDetail.info?.contact ?? '',
                        style: const TextStyle(
                          color: lightColorFF222222,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          letterSpacing: -0.02,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/bookstore/ic_shop_12.svg',
                      ),
                      const SizedBox(width: 4),
                      Text(
                        bookstoreDetail.info?.facility ?? '',
                        style: const TextStyle(
                          color: lightColorFF222222,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          letterSpacing: -0.02,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/bookstore/ic_instar_12.svg',
                      ),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () async {
                          final uri = Uri.parse(bookstoreDetail.info?.sns ?? '');
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri, mode: LaunchMode.externalApplication);
                          }
                        },
                        child: Text(
                          bookstoreDetail.info?.sns ?? '',
                          style: const TextStyle(
                            color: Color(0xFF346FC9),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            letterSpacing: -0.02,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: bookstoreDetail.themeList?.isNotEmpty ?? false,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/bookstore/ic_label_12.svg',
                          ),
                          const SizedBox(width: 4),
                          ...List.generate(
                            bookstoreDetail.themeList?.length ?? 0,
                            (index) => Text(
                              '#${bookstoreDetail.themeList?[index]} ',
                              style: const TextStyle(
                                color: lightColorFF222222,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                letterSpacing: -0.02,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 160,
                      child: GoogleMap(
                        onTap: (latLon) {
                          context.pushNamed(BookstoreMapScreen.routeName, params: {
                            'latitude': latLon.latitude.toString(),
                            'longitude': latLon.longitude.toString(),
                          });
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            double.parse(bookstoreDetail.info?.latitude ?? '37.541'),
                            double.parse(bookstoreDetail.info?.longitude ?? '126.986'),
                          ),
                          zoom: 16,
                        ),
                        rotateGesturesEnabled: false,
                        scrollGesturesEnabled: false,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: false,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      MapsLauncher.launchQuery(bookstoreDetail.info?.address ?? '');
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xFF999999)),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      fixedSize: Size(MediaQuery.of(context).size.width, 44),
                    ),
                    child: const Text(
                      '지도 앱 열기',
                      style: TextStyle(
                        color: lightColorFF222222,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    '서점 관련 아티클',
                    style: TextStyle(
                      color: lightColorFF222222,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      letterSpacing: -0.02,
                    ),
                  ),
                  const SizedBox(height: 12),
                  bookstoreDetail.articleResponse?.isEmpty ?? true
                      ? const Text(
                          '앞으로 업로드 될 새로운 이야기를 기대해 주세요!',
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            letterSpacing: -0.02,
                          ),
                        )
                      : SizedBox(
                          height: 160,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index) {
                                return InkWell(
                                  onTap: () {
                                    final articleId = bookstoreDetail.articleResponse?[index].id;
                                    if (articleId == null) return;

                                    context.pushNamed(ArticleScreen.routeName, params: {
                                      'id': articleId.toString(),
                                      'isFirstScreen': 'false',
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          width: 128,
                                          height: 160,
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
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                bookstoreDetail.articleResponse?[index].mainImage ??
                                                    '',
                                            errorWidget: (_, __, ___) =>
                                                Container(color: Colors.grey),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: BookmarkButton(
                                          isBookmark:
                                              bookstoreDetail.articleResponse?[index].isBookmark ??
                                                  false,
                                          onTapBookmark: () {
                                            bookstoreProvider.updateArticleBookmark(index);
                                          },
                                          backgroundColor: const Color(0xFFF5F5F5),
                                          radius: 12,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        left: 12,
                                        right: 12,
                                        child: Text(
                                          bookstoreDetail.articleResponse?[index].title ?? '',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            letterSpacing: -0.02,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (_, __) => const SizedBox(width: 12),
                              itemCount: bookstoreDetail.articleResponse?.length ?? 0),
                        ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
