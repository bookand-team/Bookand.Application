import 'package:bookand/domain/model/bookmark/bookmark_folder_model.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/folder_page/folder_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          margin: const EdgeInsets.only(right: 12),
          width: conSize.width,
          height: conSize.height,
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.all(br),
                  child: CachedNetworkImage(
                    errorWidget: (_, __, ___) => Container(color: Colors.grey),
                    imageUrl: folderModel.bookmarkImage ??
                        'https://as1.ftcdn.net/v2/jpg/03/92/26/10/1000_F_392261071_S2G0tB0EyERSAk79LG12JJXmvw8DLNCd.jpg',
                    width: conSize.width,
                    height: conSize.height,
                    fit: BoxFit.fill,
                  )),
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
