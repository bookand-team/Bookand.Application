import 'dart:developer';

import 'package:bookand/core/const/bookmark_type.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/domain/model/bookmark/bookmark_folder_model.dart';
import 'package:bookand/domain/model/bookmark/bookmark_model.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_ariticle_folders_provider.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_article_provider.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_scroller_provider.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_store_folders_provider.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_store_provider.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_type_provider.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/bookmark_contents.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/bookmark_folders.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/bookmark_top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarkScreen extends ConsumerStatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends ConsumerState<BookmarkScreen>
    with TickerProviderStateMixin {
  //서점과 아티클 구별, false일 경우 아티클 화면
  late AnimationController aniCon;
  PersistentBottomSheetController? bottomSheetController;

  @override
  void initState() {
    aniCon = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    aniCon.stop();
    aniCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<BookmarkFolderModel> articleFolderList =
        ref.watch(bookmarkArticleFoldersNotifierProvider);
    List<BookmarkFolderModel> storeFolderList =
        ref.watch(bookmarkStoreFoldersNotifierProvider);
    List<BookmarkModel> articleList =
        ref.watch(bookmarkArticleNotifierProvider);
    List<BookmarkModel> storeList = ref.watch(bookmarkStoreNotifierProvider);
    log('bookmark book folder list =${storeFolderList.map((e) => e.folderName)}');
    log('bookmark book list =${storeList.map((e) => e.title)}');

    BookmarkType type = ref.watch(bookmarkTypeNotifierProvider);

    ScrollController scrollController =
        ref.read(bookmarkScrollControllerNotifierProvider);

    return BaseLayout(
        child: Column(
      children: [
        BookmarkTop(type: type),
        Expanded(
            child: ListView(
          controller: scrollController,
          children: [
            FutureBuilder(
              future: type == BookmarkType.article
                  ? ref
                      .read(bookmarkArticleFoldersNotifierProvider.notifier)
                      .init()
                  : ref
                      .read(bookmarkStoreFoldersNotifierProvider.notifier)
                      .init(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  aniCon.stop();

                  return BookmarkFolders(
                    folderList: type == BookmarkType.article
                        ? articleFolderList
                        : storeFolderList,
                  );
                } else if (snapshot.hasError) {
                  aniCon.stop();
                  return const Center(
                    child: Text('에러! 다시 시도해주세요'),
                  );
                } else {
                  aniCon.repeat(reverse: true);

                  return CircularProgressIndicator(
                    value: aniCon.value,
                  );
                }
              },
            ),
            FutureBuilder(
              future: type == BookmarkType.article
                  ? ref.read(bookmarkArticleNotifierProvider.notifier).init()
                  : ref.read(bookmarkStoreNotifierProvider.notifier).init(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  aniCon.stop();
                  return BookmarkContents(
                    scrollController: scrollController,
                    bookmarkList:
                        type == BookmarkType.article ? articleList : storeList,
                    type: type,
                  );
                } else if (snapshot.hasError) {
                  aniCon.stop();
                  return const Center(
                    child: Text('error! 다시 시도해주세요'),
                  );
                } else {
                  aniCon.repeat(reverse: true);
                  return CircularProgressIndicator(
                    value: aniCon.value,
                  );
                }
              },
            )
          ],
        ))
      ],
    ));
  }
}
