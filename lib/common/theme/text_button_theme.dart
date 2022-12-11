import 'package:flutter/material.dart';

import 'color_table.dart';

const TextButtonThemeData lightTextButtonTheme = TextButtonThemeData(
  style: ButtonStyle(
    textStyle: MaterialStatePropertyAll(TextStyle(
      color: lightColorFFACACAC,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      letterSpacing: -0.04,
      decoration: TextDecoration.underline
    ))
  )
);

const TextButtonThemeData darkTextButtonTheme = lightTextButtonTheme;