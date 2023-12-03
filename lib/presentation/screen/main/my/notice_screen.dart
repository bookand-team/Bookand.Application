import 'package:bookand/core/widget/base_app_bar.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/presentation/component/drawer_list_tile.dart';
import 'package:bookand/presentation/provider/notice_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/app_strings.dart';

class NoticeScreen extends ConsumerStatefulWidget {
  static String get routeName => 'notice';

  const NoticeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends ConsumerState<NoticeScreen> {
  final scrollController = ScrollController();

  void _loadMore() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      ref.read(noticeStateNotifierProvider.notifier).fetchNextNoticeList();
    }
  }

  @override
  void initState() {
    scrollController.addListener(_loadMore);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    ref.read(noticeStateNotifierProvider.notifier).fetchNoticeList();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noticeList = ref.watch(noticeStateNotifierProvider);
    final noticeProvider = ref.watch(noticeStateNotifierProvider.notifier);

    return BaseLayout(
      appBar: const BaseAppBar(title: AppStrings.notice),
      child: SafeArea(
        child: Scrollbar(
          controller: scrollController,
          child: ListView.separated(
            physics: const ClampingScrollPhysics(),
            controller: scrollController,
            itemBuilder: (context, index) {
              if (index < noticeList.length) {
                return DrawerListTile(
                  title: Text(
                    noticeList[index].title,
                    style: const TextStyle(
                      color: Color(0xFF222222),
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      letterSpacing: -0.02,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subTitle: Text(
                    DateFormat('yyyy-MM-dd').format(DateTime.parse(noticeList[index].createdAt)),
                    style: const TextStyle(
                      color: Color(0xFFACACAC),
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      letterSpacing: -0.02,
                    ),
                  ),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  drawerBackground: const Color(0xFFF5F5F7),
                  child: Markdown(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    data: noticeList[index].content,
                  ),
                );
              }

              if (!noticeProvider.isLoading && noticeProvider.isEnd) {
                return const SizedBox();
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
            separatorBuilder: (_, __) => const Divider(
              height: 0,
              thickness: 2,
              color: Color(0xFFF5F5F7),
            ),
            itemCount: noticeList.length + 1,
          ),
        ),
      ),
    );
  }
}
