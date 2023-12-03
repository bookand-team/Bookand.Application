import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final Widget leading;
  final String title;
  final Function()? onTap;
  final Widget? trailing;

  const MenuItem({
    Key? key,
    required this.leading,
    required this.title,
    this.onTap,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF222222),
          fontWeight: FontWeight.w400,
          fontSize: 16,
          letterSpacing: -0.02,
        ),
      ),
      trailing: trailing,
      onTap: onTap ?? () {},
      minLeadingWidth: 12,
    );
  }
}
