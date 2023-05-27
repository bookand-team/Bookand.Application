import 'package:bookand/core/const/app_mode.dart';
import 'package:bookand/domain/model/bookmark/bookmark_folder_model.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/folder_page/folder_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//폴더의 이미지, 이름 출력하고, 탭하면 접근하는 위젯
class FolderContainer extends StatelessWidget {
  final BookmarkFolderModel folderModel;
  const FolderContainer({Key? key, required this.folderModel})
      : super(key: key);

  final Radius br = const Radius.circular(4);
  final double strokeWidth = 1;

  final Size conSize = const Size(80, 80);

  final EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 5);

  final TextStyle titleStyle = const TextStyle(fontSize: 10);
  final Color grey = const Color(0xff999999);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goNamed(FolderPage.routeName, pathParameters: {
          "id": folderModel.bookmarkId!.toString(),
          'name': folderModel.folderName!
        });
      },
      child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade200, borderRadius: BorderRadius.all(br)),
          margin: margin,
          width: conSize.width,
          height: conSize.height,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(br),
                child: CAN_IMAGE
                    ? Image.network(
                        '',
                        width: conSize.width,
                        height: conSize.height,
                      )
                    : SizedBox(),
              ),
              Align(
                alignment: const Alignment(0, 0.7),
                child: Text(
                  folderModel.folderName!,
                  style: titleStyle.copyWith(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              )
            ],
          )),
    );
  }
}
