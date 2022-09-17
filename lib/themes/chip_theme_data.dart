import 'package:bookand/themes/color_table.dart';
import 'package:flutter/material.dart';

const ChipThemeData lightChipTheme = ChipThemeData(
  backgroundColor: Colors.white,
  checkmarkColor: lightColorFF222222,
  shape: RoundedRectangleBorder(
    side: BorderSide(color: lightColorFFDDDDDD),
    borderRadius: BorderRadius.all(Radius.circular(15))
  )
);

const ChipThemeData darkChipTheme = lightChipTheme;