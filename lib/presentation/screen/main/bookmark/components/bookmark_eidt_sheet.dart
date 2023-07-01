import 'package:bookand/core/const/bookmark_type.dart';
import 'package:bookand/core/widget/slide_icon.dart';
import 'package:bookand/domain/model/bookmark/bookmark_folder_model.dart';
import 'package:bookand/domain/usecase/bookmark_usercae.dart';
import 'package:bookand/gen/assets.gen.dart';
import 'package:bookand/presentation/component/bookmark_dialog.dart';
import 'package:bookand/presentation/component/bookstore_snackbar.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_ariticle_folders_provider.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_article_provider.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_edit_provider.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_eidt_list.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_scroller_provider.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_store_folders_provider.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_store_provider.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_type_provider.dart';
import 'package:bookand/presentation/provider/bookmark/main_ref_provider.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/dialogs/add_folder_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class BookmarkEidtSheet extends ConsumerWidget {
  const BookmarkEidtSheet({
    Key? key,
  }) : super(key: key);

  final Color backgroundColor = Colors.black;
  final Color contentColor = Colors.white;
  final TextStyle textStyle = const TextStyle(
    color: Colors.white,
    fontSize: 8,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
  );

  final double foldrSheetMaximumHeight = 560;
  final double elementHeight = 48;

  Widget createFolderElement(BookmarkFolderModel model, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        WidgetRef? baseRef = ref.read(mainRefNotifierProvider);
        ref.context.pop();
        await showDialog(
          context: ref.context,
          builder: (context) {
            return BookmarkDialog(
              title: '선택한 북마크를 폴더에 저장할까요?',
              description: null,
              leftButtonString: '아니오',
              rightButtonString: '저장',
              rightIsImportant: true,
              onLeftButtonTap: () {},
              onRightButtonTap: () {
                if (baseRef != null) {
                  bool isArticle = baseRef.read(bookmarkTypeNotifierProvider) ==
                      BookmarkType.article;
                  List<int> selectedList =
                      baseRef.read(bookmarkEditListNotifierProvider);

                  isArticle
                      ? baseRef
                          .read(bookmarkUsecaseProvider)
                          .addBookmarkArticleFolderContent(
                              folderId: model.bookmarkId!,
                              contentsIdList: selectedList)
                      : baseRef
                          .read(bookmarkUsecaseProvider)
                          .addBookmarkStoreFolderContent(
                              folderId: model.bookmarkId!,
                              contentsIdList: selectedList);

                  ScaffoldMessenger.of(baseRef.context)
                      .showSnackBar(createSnackBar(data: '북마크가 저장되었습니다.'));
                  baseRef.read(bookmarkEditNotifierProvider.notifier).editOff();
                  baseRef
                      .read(bookmarkEditNotifierProvider.notifier)
                      .closeBottomSheet();
                }
              },
            );
          },
        );
      },
      child: SizedBox(
        height: elementHeight + MediaQuery.of(ref.context).viewInsets.bottom,
        child: Row(
          children: [
            const SizedBox(
              width: 12,
            ),
            SvgPicture.asset(Assets.images.bookmark.icFolder),
            const SizedBox(
              width: 12,
            ),
            Text(
              model.folderName!,
              style: const TextStyle(
                color: Color(0xff222222),
                fontSize: 16,
                fontFamily: "Pretendard",
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget createFolderAddElement(WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        bool isArticle =
            ref.read(bookmarkTypeNotifierProvider) == BookmarkType.article;

        showModalBottomSheet(
          isScrollControlled: true,
          context: ref.context,
          builder: (context) => AddFolderDialog(
            onAdd: (name) {
              isArticle
                  ? ref
                      .read(bookmarkArticleFoldersNotifierProvider.notifier)
                      .addFolder(name)
                  : ref
                      .read(bookmarkStoreFoldersNotifierProvider.notifier)
                      .addFolder(name);
            },
          ),
        );
      },
      child: SizedBox(
        height: elementHeight,
        child: Row(
          children: [
            const SizedBox(
              width: 12,
            ),
            SvgPicture.asset(Assets.images.bookmark.icFolderAdd),
            const SizedBox(
              width: 12,
            ),
            const Text(
              "새폴더 추가",
              style: TextStyle(
                color: Color(0xff222222),
                fontSize: 16,
                fontFamily: "Pretendard",
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: backgroundColor,
      width: double.infinity,
      height: kBottomNavigationBarHeight,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                ref.read(bookmarkScrollControllerNotifierProvider).animateTo(0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.bounceIn);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.images.bookmark.ic24Up,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '맨 위로',
                    style: textStyle,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                final selectedModel =
                    ref.read(bookmarkEditListNotifierProvider);
                if (selectedModel.isNotEmpty) {
                  bool isArticle = ref.read(bookmarkTypeNotifierProvider) ==
                      BookmarkType.article;
                  List<BookmarkFolderModel> folderList = isArticle
                      ? ref.read(bookmarkArticleFoldersNotifierProvider)
                      : ref.read(bookmarkStoreFoldersNotifierProvider);

                  bool isOverflow = folderList.length > 8;
                  double maxHeight = 0.8;
                  // 폴더 추가 바텀 시트
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (context) {
                      return Consumer(
                        builder: (context, ref, child) {
                          bool isArticle =
                              ref.read(bookmarkTypeNotifierProvider) ==
                                  BookmarkType.article;
                          List<BookmarkFolderModel> models = isArticle
                              ? ref
                                  .watch(bookmarkArticleFoldersNotifierProvider)
                              : ref.watch(bookmarkStoreFoldersNotifierProvider);

                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(24))),
                            child: !isOverflow
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      slideIcon,
                                      const SizedBox(
                                        height: 34,
                                      ),
                                      createFolderAddElement(ref),
                                      ...models
                                          .map((e) =>
                                              createFolderElement(e, ref))
                                          .toList()
                                    ],
                                  )
                                : DraggableScrollableSheet(
                                    expand: false,
                                    initialChildSize: maxHeight,
                                    maxChildSize: maxHeight,
                                    minChildSize: 0,
                                    builder: (context, scrollController) {
                                      return SingleChildScrollView(
                                        controller: scrollController,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            slideIcon,
                                            const SizedBox(
                                              height: 34,
                                            ),
                                            createFolderAddElement(ref),
                                            ...models
                                                .map((e) =>
                                                    createFolderElement(e, ref))
                                                .toList()
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          );
                        },
                      );
                    },
                  );
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Assets.images.bookmark.ic24Foldersave),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '폴더에 저장',
                    style: textStyle,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (ref.read(bookmarkEditListNotifierProvider).isNotEmpty) {
                  showDialog(
                      context: context,
                      builder: (context) => BookmarkDialog(
                            title: '북마크를 삭제하시겠어요?',
                            description:
                                "'모아보기'에서 북마크를 삭제하면\n폴더에 저장된 북마크도 함께 삭제돼요.",
                            leftButtonString: '삭제할래요',
                            rightButtonString: '아니요',
                            rightIsImportant: false,
                            onLeftButtonTap: () {
                              List<int> bokmarkList =
                                  ref.read(bookmarkEditListNotifierProvider);
                              bool isArticle =
                                  ref.read(bookmarkTypeNotifierProvider) ==
                                      BookmarkType.article;

                              isArticle
                                  ? ref
                                      .read(bookmarkArticleNotifierProvider
                                          .notifier)
                                      .delete(bokmarkList)
                                  : ref
                                      .read(bookmarkStoreNotifierProvider
                                          .notifier)
                                      .delete(bokmarkList);
                              ref
                                  .read(bookmarkEditNotifierProvider.notifier)
                                  .editOff();
                              ref
                                  .read(bookmarkEditNotifierProvider.notifier)
                                  .closeBottomSheet();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  createSnackBar(data: '북마크가 삭제되었습니다.'));
                            },
                            onRightButtonTap: () {},
                          ));
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Assets.images.bookmark.ic24BookmarkX),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '북마크 삭제',
                    style: textStyle,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
