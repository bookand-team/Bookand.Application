import 'package:bookand/core/const/bookmark_type.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/domain/model/bookmark/bookmark_model.dart';
import 'package:bookand/domain/usecase/bookmark_usercae.dart';
import 'package:bookand/gen/assets.gen.dart';
import 'package:bookand/presentation/component/bookmark_dialog.dart';
import 'package:bookand/presentation/component/bookstore_snackbar.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_ariticle_folders_provider.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_eidt_list.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_store_folders_provider.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_type_provider.dart';
import 'package:bookand/presentation/provider/bookmark/main_context_provider.dart';
import 'package:bookand/presentation/screen/main/bookmark/bottom_sheet/input_bottom_sheet.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/content_components/bookmark_container.dart';
import 'package:bookand/presentation/screen/main/home/article_screen.dart';
import 'package:bookand/presentation/screen/main/home/bookstore_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class FolderPage extends ConsumerStatefulWidget {
  final String id;
  final String name;
  static const routeName = 'folderPage';
  const FolderPage({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  _FolderPageState createState() => _FolderPageState();
}

class _FolderPageState extends ConsumerState<FolderPage> {
  bool editMode = false;

  bool showMore = false;

  List<BookmarkModel> modelList = [];

  late String name;

  final Size menuSize = Size(224, 45);

  @override
  void initState() {
    name = widget.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    showMore = modelList.isNotEmpty;
    return BaseLayout(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          name,
          style: const TextStyle(
            color: Color(0xff222222),
            fontSize: 18,
            fontFamily: "Pretendard",
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: SvgPicture.asset(
              Assets.images.icArrowBack,
              width: 24,
              height: 24,
              fit: BoxFit.scaleDown,
            )),
        actions: [
          if (modelList.isNotEmpty)
            PopupMenuButton(
              constraints: BoxConstraints(minWidth: menuSize.width),
              surfaceTintColor: Colors.white,
              position: PopupMenuPosition.under,
              padding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              shadowColor: Colors.white,
              color: Colors.white,
              icon: SvgPicture.asset(
                Assets.images.bookmark.ic24More,
                width: 24,
                height: 24,
              ),
              itemBuilder: (menuContext) {
                return createMenuItem();
              },
            ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      child: Stack(children: [
        FutureBuilder(
          future: ref.read(bookmarkUsecaseProvider).initBookmarkFolderContents(
              folderId: int.parse(widget.id), page: 0, cursorId: 0, size: 1),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                !snapshot.hasError &&
                snapshot.data == null) {
              return createEmptyLog();
            }

            if (snapshot.hasData) {
              modelList = snapshot.data as List<BookmarkModel>;
              // 데이터가 있는데 more이 출력되지 않으면 setstate로 출력
              if (!showMore && modelList.isNotEmpty) {
                Future.delayed(
                  const Duration(milliseconds: 300),
                  () {
                    setState(() {});
                  },
                );
              }
              if (modelList.isEmpty) {
                return createEmptyLog();
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.count(
                      childAspectRatio: BookmarkContainer.size.width /
                          BookmarkContainer.size.height,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: modelList
                          .map((e) => BookmarkContainer(
                              key: Key(e.title!),
                              model: e,
                              onTap: () {
                                ref.read(bookmarkTypeNotifierProvider) ==
                                        BookmarkType.article
                                    ? context.pushNamed(ArticleScreen.routeName,
                                        pathParameters: {
                                            'id': e.bookmarkId.toString(),
                                            'isFirstScreen': 'false',
                                          })
                                    : context.goNamed(BookstoreScreen.routeName,
                                        pathParameters: {
                                            'id': e.bookmarkId.toString()
                                          });
                              },
                              settingMode: editMode))
                          .toList()),
                );
              }
            } else if (snapshot.hasError) {
              return createEmptyLog();
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        if (editMode)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white.withOpacity(0.9),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        editMode = false;
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xffdddddd),
                        ),
                        width: 160,
                        height: 40,
                        child: const Center(
                          child: Text(
                            "취소",
                            style: TextStyle(
                              color: Color(0xff222222),
                              fontSize: 15,
                              fontFamily: "Pretendard",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  //북마크 삭제
                  GestureDetector(
                    onTap: () {
                      bool isArticle = ref.read(bookmarkTypeNotifierProvider) ==
                          BookmarkType.article;
                      final selectedList =
                          ref.read(bookmarkEditListNotifierProvider);
                      isArticle
                          ? ref
                              .read(bookmarkUsecaseProvider)
                              .delBookmarkArticleFolderContent(
                                  folderId: int.parse(widget.id),
                                  contentsIdList: selectedList)
                          : ref
                              .read(bookmarkUsecaseProvider)
                              .delBookmarkStoreFolderContent(
                                  folderId: int.parse(widget.id),
                                  contentsIdList: selectedList);
                      setState(() {
                        selectedList.forEach((id) {
                          modelList.removeWhere(
                              (element) => element.bookmarkId == id);
                        });
                        editMode = false;
                      });
                      showConfirmSnackBar(context, '북마크가 삭제되었습니다.');
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff222222),
                        ),
                        width: 160,
                        height: 40,
                        child: const Center(
                          child: Text(
                            "삭제",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "Pretendard",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
          )
      ]),
    );
  }

  Widget createItemContainer(
    String data,
    Widget icon,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          data,
          style: const TextStyle(
            color: Color(0xff222222),
            fontSize: 18,
            fontFamily: "Pretendard",
            fontWeight: FontWeight.w500,
          ),
        ),
        icon
      ],
    );
  }

  List<PopupMenuEntry> createMenuItem() {
    return [
      PopupMenuItem(
        onTap: () {
          Future.delayed(
            const Duration(milliseconds: 300),
            () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (sheetContext) => InputFolderDialog(
                    title: '폴더명 수정',
                    buttonText: '수정',
                    hintText: '수정할 폴더명',
                    onAdd: (newName) {
                      setState(() {
                        name = newName;
                      });
                      bool isArticle = ref.read(bookmarkTypeNotifierProvider) ==
                          BookmarkType.article;
                      isArticle
                          ? ref
                              .read(bookmarkArticleFoldersNotifierProvider
                                  .notifier)
                              .updateName(int.parse(widget.id), newName)
                          : ref
                              .read(
                                  bookmarkStoreFoldersNotifierProvider.notifier)
                              .updateName(int.parse(widget.id), newName);

                      showConfirmSnackBar(sheetContext, '폴더 이름이 수정되었습니다.');
                    },
                    initialText: widget.name),
              );
            },
          );
        },
        child: Center(
            child: createItemContainer(
                "폴더명 수정",
                SvgPicture.asset(
                  Assets.images.bookmark.ic24Edit,
                  width: 24,
                  height: 24,
                ))),
      ),
      const CustomPopupMenuDivider(
        color: Color(0xfff5f5f5),
      ),
      PopupMenuItem(
          onTap: () {
            ref.read(bookmarkEditListNotifierProvider.notifier).clear();
            setState(() {
              editMode = !editMode;
            });
          },
          child: createItemContainer(
              "북마크 삭제",
              SvgPicture.asset(
                Assets.images.bookmark.ic16BookmarkX,
                width: 24,
                height: 24,
              ))),
      const CustomPopupMenuDivider(
        color: Color(0xfff5f5f5),
      ),
      PopupMenuItem(
          onTap: () async {
            Future.delayed(
              const Duration(milliseconds: 200),
              () {
                showDialog(
                  context: context,
                  builder: (context) => BookmarkDialog(
                    title: '폴더를 삭제하시겠어요?',
                    description: "폴더에 저장했던 북마크는 '모아보기'에서 다시 볼 수 있어요",
                    leftButtonString: '삭제 할래요',
                    rightButtonString: '아니요',
                    rightIsImportant: false,
                    onLeftButtonTap: () {
                      bool isArticle = ref.read(bookmarkTypeNotifierProvider) ==
                          BookmarkType.article;
                      isArticle
                          ? ref
                              .read(bookmarkArticleFoldersNotifierProvider
                                  .notifier)
                              .delete(int.parse(widget.id))
                          : ref
                              .read(
                                  bookmarkStoreFoldersNotifierProvider.notifier)
                              .delete(int.parse(widget.id));
                      Future.delayed(
                        const Duration(milliseconds: 200),
                        () {
                          showConfirmSnackBar(
                              ref
                                  .read(mainContextNotifierProvider)
                                  .currentState!
                                  .context,
                              '폴더가 삭제되었습니다.');
                        },
                      );
                      ref.context.pop();
                    },
                    onRightButtonTap: () {},
                  ),
                );
              },
            );
          },
          child: createItemContainer(
            "폴더 삭제",
            SvgPicture.asset(
              Assets.images.bookmark.ic24FolderX,
              width: 24,
              height: 24,
            ),
          )),
    ];
  }

  Widget createEmptyLog() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 127,
            ),
            SvgPicture.asset(
              Assets.images.icWarning,
              width: 36,
              height: 36,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "폴더에 저장한 서점이 없어요",
              style: TextStyle(
                color: Color(0xff666666),
                fontSize: 18,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class CustomPopupMenuDivider extends PopupMenuEntry<Never> {
  /// Creates a horizontal divider for a popup menu.
  ///
  /// By default, the divider has a height of 16 logical pixels.
  const CustomPopupMenuDivider(
      {super.key, this.height = 16, required this.color});

  /// The height of the divider entry.
  ///
  /// Defaults to 16 pixels.
  ///
  @override
  final double height;

  final Color color;

  @override
  bool represents(void value) => false;

  @override
  State<CustomPopupMenuDivider> createState() => _PopupMenuDividerState();
}

class _PopupMenuDividerState extends State<CustomPopupMenuDivider> {
  @override
  Widget build(BuildContext context) => Divider(
        height: widget.height,
        color: widget.color,
      );
}
