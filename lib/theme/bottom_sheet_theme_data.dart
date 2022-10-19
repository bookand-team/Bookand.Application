import 'package:flutter/material.dart';

const BottomSheetThemeData lightBottomSheetThemeData = BottomSheetThemeData(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24))));

const BottomSheetThemeData darkBottomSheetThemeData = lightBottomSheetThemeData;
