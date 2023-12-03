import 'package:bookand/core/const/bookmark_type.dart';
import 'package:bookand/domain/model/bookmark/bookmark_folder_model.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_ariticle_folders_provider.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_store_folders_provider.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_type_provider.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/dialogs/add_folder_dialog.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/folder_components/add_folder.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/folder_components/folder_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarkFolders extends ConsumerWidget {
  final List<BookmarkFolderModel> folderList;
  const BookmarkFolders({Key? key, required this.folderList}) : super(key: key);

  final double height = 112;
  final Color grey = const Color(0xfff9f9f9);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: grey,
      width: MediaQuery.of(context).size.width,
      height: height,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AddFolder(onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return AddFolderDialog(
                    onAdd: (name) {
                      BookmarkType type =
                          ref.read(bookmarkTypeNotifierProvider);
                      type == BookmarkType.article
                          ? ref
                              .read(bookmarkArticleFoldersNotifierProvider
                                  .notifier)
                              .addFolder(name)
                          : ref
                              .read(
                                  bookmarkStoreFoldersNotifierProvider.notifier)
                              .addFolder(name);
                    },
                  );
                },
              );
            }),
            const SizedBox(
              width: 12,
            ),
            ...folderList
                .map((e) => FolderContainer(
                      folderModel: e,
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}
