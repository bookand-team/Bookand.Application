import 'package:bookand/presentation/screen/main/bookmark/components/folder_components/add_folder_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

//북마크 페이지에서 새폴더 추가 버튼
class AddFolder extends StatelessWidget {
  const AddFolder({Key? key}) : super(key: key);

  final Radius br = const Radius.circular(4);
  final double strokeWidth = 1;

  final Size folderSize = const Size(80, 80);
  final Size addIconSize = const Size(32, 32);

  final TextStyle addFolderStyel = const TextStyle(fontSize: 10);
  final Color greyThine = const Color(0xffdddddd);
  final Color grey = const Color(0xff999999);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AddFolderDialog();
          },
        );
      },
      child: SizedBox(
        width: folderSize.width,
        height: folderSize.height,
        child: DottedBorder(
          color: greyThine,
          strokeWidth: strokeWidth,
          radius: br,
          dashPattern: const [3, 1],
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  SvgPicture.asset(
                    'assets/images/bookstore/ic_add_folder_icon.svg',
                    width: addIconSize.width,
                    height: addIconSize.height,
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Text(
                    '새폴더 추가',
                    style: addFolderStyel.copyWith(color: grey),
                  ),
                  const Spacer(
                    flex: 1,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
