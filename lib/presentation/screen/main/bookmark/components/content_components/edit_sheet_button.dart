import 'package:bookand/presentation/provider/bookmark/bookmark_edit_provider.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_eidt_list.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/bookmark_eidt_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditSheetButton extends ConsumerWidget {
  const EditSheetButton({Key? key}) : super(key: key);
  final Size settingSize = const Size(56, 24);
  final double settingIconSize = 12;
  final Color grey = const Color(0xffacacac);
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
        decoration: BoxDecoration(
            border: Border.all(color: grey),
            borderRadius: BorderRadius.circular(32)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.settings_outlined,
              color: grey,
              size: settingIconSize,
            ),
            Text(
              active ? '취소' : '편집',
              style: settingStyle.copyWith(color: grey),
            )
          ],
        ),
      ),
    );
  }
}
