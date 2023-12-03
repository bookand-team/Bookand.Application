import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DrawerListTile extends StatefulWidget {
  final Widget title;
  final Widget? subTitle;
  final Widget? trailing;
  final Duration duration;
  final Curve curve;
  final double minHeight;
  final double? maxHeight;
  final Color? drawerBackground;
  final Widget child;
  final Function()? onTap;
  final bool? isOpen;

  const DrawerListTile(
      {Key? key,
      required this.title,
      this.subTitle,
      this.trailing,
      required this.duration,
      this.curve = Curves.linear,
      this.minHeight = 0,
      this.maxHeight,
      this.drawerBackground,
      required this.child,
      this.onTap,
      this.isOpen})
      : super(key: key);

  @override
  State<DrawerListTile> createState() => _DrawerListTileState();
}

class _DrawerListTileState extends State<DrawerListTile> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: widget.onTap ??
              () {
                setState(() {
                  isOpen = !isOpen;
                });
              },
          child: ListTile(
            title: widget.title,
            subtitle: widget.subTitle,
            trailing: widget.trailing ??
                SvgPicture.asset(
                  widget.isOpen ?? isOpen
                      ? 'assets/images/my/ic_drawer_close.svg'
                      : 'assets/images/my/ic_drawer_open.svg',
                ),
          ),
        ),
        AnimatedContainer(
          duration: widget.duration,
          curve: Curves.easeInOut,
          height: widget.isOpen ?? isOpen ? widget.maxHeight : widget.minHeight,
          color: widget.drawerBackground,
          child: widget.child,
        ),
      ],
    );
  }
}
