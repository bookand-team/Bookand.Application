import 'package:bookand/gen/assets.gen.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_edit_provider.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_eidt_list.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/bookmark_eidt_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditSheetButton extends ConsumerWidget {
  const EditSheetButton({Key? key}) : super(key: key);
  final Size settingSize = const Size(56, 24);
  final double settingIconSize = 12;
  final Color grey = const Color(0xffdddddd);
  final TextStyle settingStyle = const TextStyle(
    fontSize: 12,
  );
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool active = ref.watch(bookmarkEditNotifierProvider);
    return GestureDetector(
      onTap: () {
        ref.read(bookmarkEditNotifierProvider.notifier).toggle();
        if (active) {
          ref.read(bookmarkEditNotifierProvider.notifier).closeBottomSheet();
          ref.read(bookmarkEditListNotifierProvider.notifier).clear();
        } else {
          ref
              .read(bookmarkEditNotifierProvider.notifier)
              .showEditBottomSheet(context, const BookmarkEidtSheet());
        }
      },
      child: Container(
        width: settingSize.width,
        height: settingSize.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: grey),
            borderRadius: BorderRadius.circular(32)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              active
                  ? Assets.images.bookmark.icReset
                  : Assets.images.bookmark.ic12Edit,
              width: 12,
              height: 12,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              active ? '취소' : '편집',
              style: const TextStyle(
                color: Color(0xFF666666),
                fontSize: 12,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.72,
              ),
            )
          ],
        ),
      ),
    );
  }
}
