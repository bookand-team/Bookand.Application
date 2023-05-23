import 'package:bookand/core/theme/color_table.dart';
import 'package:bookand/domain/model/bookstore/bookstore_detail.dart';
import 'package:bookand/presentation/provider/bookstore_provider.dart';
import 'package:bookand/presentation/screen/main/home/component/bookstore_app_bar.dart';
import 'package:bookand/presentation/screen/main/home/component/bookstore_articles_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/widget/base_layout.dart';
import '../../../../domain/model/article/article_model.dart';
import '../../../component/bookmark_button.dart';
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
        physics: const ClampingScrollPhysics(),
        slivers: [
          BookstoreAppBar(
            changeHeight: 170,
            duration: const Duration(milliseconds: 200),
            imageUrl: bookstoreDetail.mainImage ?? '',
            onTapShare: () {
              // TODO: 임시
              Share.share('공유하기 테스트');
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  _bookstoreInfo(
                    bookstoreDetail: bookstoreDetail,
                    onTapBookmark: () {
                      bookstoreProvider.updateBookstoreBookmark();
                    },
                  ),
                  const SizedBox(height: 16),
                  _bookstoreMap(bookstoreDetail.info),
                  const SizedBox(height: 40),
                  _bookstoreArticles(
                    articles: bookstoreDetail.articleResponse,
                    onTapBookmark: (index) {
                      bookstoreProvider.updateArticleBookmark(index);
                    },
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

  Widget _bookstoreInfo({
    required BookstoreDetail bookstoreDetail,
    required Function() onTapBookmark,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                onTapBookmark: onTapBookmark,
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
        ],
      );

  Widget _bookstoreMap(BookstoreInfo? info) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 160,
              child: GoogleMap(
                onTap: (latLon) {
                  context.pushNamed(BookstoreMapScreen.routeName, queryParameters: {
                    'latitude': latLon.latitude.toString(),
                    'longitude': latLon.longitude.toString(),
                  });
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    double.parse(info?.latitude ?? '37.541'),
                    double.parse(info?.longitude ?? '126.986'),
                  ),
                  zoom: 16,
                ),
                rotateGesturesEnabled: false,
                scrollGesturesEnabled: false,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: false,
                myLocationButtonEnabled: false,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              MapsLauncher.launchQuery(info?.address ?? '');
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
        ],
      );

  Widget _bookstoreArticles({
    List<ArticleContent>? articles,
    required Function(int) onTapBookmark,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          articles?.isEmpty ?? true
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
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        return BookstoreArticlesCard.fromModel(
                          model: articles?[index],
                          width: 128,
                          height: 160,
                          onTap: () {
                            final articleId = articles?[index].id;
                            if (articleId == null) return;

                            context.pushNamed(ArticleScreen.routeName, queryParameters: {
                              'id': articleId.toString(),
                              'isFirstScreen': 'false',
                            });
                          },
                          onTapBookmark: () {
                            onTapBookmark(index);
                          },
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemCount: articles?.length ?? 0),
                )
        ],
      );
}
