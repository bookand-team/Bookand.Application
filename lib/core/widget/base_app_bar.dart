import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? titleStyle;
  final bool? automaticallyImplyLeading;
  final bool? centerTitle;
  final double? leadingWidth;
  final Widget? leading;

  const BaseAppBar(
      {Key? key,
      required this.title,
      this.titleStyle,
      this.automaticallyImplyLeading,
      this.centerTitle,
      this.leadingWidth,
      this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: titleStyle ??
            const TextStyle(
              color: Color(0xFF222222),
              fontWeight: FontWeight.w400,
              fontSize: 15,
              letterSpacing: -0.02,
            ),
      ),
      automaticallyImplyLeading: automaticallyImplyLeading ?? false,
      centerTitle: centerTitle ?? true,
      backgroundColor: Theme.of(context).colorScheme.background,
      surfaceTintColor: Theme.of(context).colorScheme.background,
      leadingWidth: leadingWidth ?? 40,
      leading: leading ??
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: context.pop,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SvgPicture.asset(
                'assets/images/home/ic_24_back_dark.svg',
              ),
            ),
          ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
