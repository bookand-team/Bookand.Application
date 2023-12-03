import 'package:flutter/material.dart';

import 'color_table.dart';

const ChipThemeData lightChipTheme = ChipThemeData(
  backgroundColor: Colors.white,
  checkmarkColor: lightColorFF222222,
  shape: RoundedRectangleBorder(
    side: BorderSide(color: lightColorFFDDDDDD),
    borderRadius: BorderRadius.all(Radius.circular(15))
  )
);

const ChipThemeData darkChipTheme = lightChipTheme;