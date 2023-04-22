import 'package:bookand/presentation/screen/main/bookmark/components/folder_components/add_folder.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/folder_components/folder_con.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarkFolders extends ConsumerWidget {
  final List<dynamic> dataList;
  const BookmarkFolders({Key? key, required this.dataList}) : super(key: key);

  final double height = 112;
  final Color grey = const Color(0xffdddddd);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: grey,
      width: MediaQuery.of(context).size.width,
      height: height,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const AddFolder(),
            ...dataList
                .map((e) => FolderCon(
                      data: e,
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}
