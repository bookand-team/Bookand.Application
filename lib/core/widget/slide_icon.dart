import 'package:flutter/material.dart';

//slide icon
const Size _slideIconSize = Size(60, 4);
const Color _slideIconColor = Color(0xffd9d9d9);
const EdgeInsets _sideIconMargin = EdgeInsets.all(7);

Widget slideIcon = Container(
  decoration: const BoxDecoration(
      color: _slideIconColor,
      borderRadius: BorderRadius.all(Radius.circular(1000))),
  margin: _sideIconMargin,
  width: _slideIconSize.width,
  height: _slideIconSize.height,
);