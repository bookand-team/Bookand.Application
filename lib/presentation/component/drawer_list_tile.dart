import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final bool value;
  final Function(bool value) onChanged;
  final Widget title;
  final Widget? subTitle;
  final Widget? trailing;
  final Duration duration;
  final Curve curve;
  final double minHeight;
  final double maxHeight;
  final Color? drawerBackground;
  final Widget child;

  const DrawerListTile(
      {Key? key,
      required this.value,
      required this.onChanged,
      required this.title,
      this.subTitle,
      this.trailing,
      required this.duration,
      this.curve = Curves.linear,
      this.minHeight = 0,
      this.maxHeight = 400,
      this.drawerBackground,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => onChanged(!value),
          child: ListTile(
            title: title,
            subtitle: subTitle,
            trailing: trailing,
          ),
        ),
        AnimatedContainer(
          duration: duration,
          curve: Curves.easeInOut,
          height: value ? maxHeight : minHeight,
          color: drawerBackground,
          child: child,
        ),
      ],
    );
  }
}
