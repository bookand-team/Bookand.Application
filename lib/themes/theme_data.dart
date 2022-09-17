import 'package:bookand/themes/bottom_sheet_theme_data.dart';
import 'package:bookand/themes/button_theme_data.dart';
import 'package:bookand/themes/chip_theme_data.dart';
import 'package:bookand/themes/dialog_theme.dart';
import 'package:bookand/themes/text_button_theme.dart';
import 'package:bookand/themes/text_theme.dart';
import 'package:flutter/material.dart';

import 'color_table.dart';

final ThemeData lightThemeData = ThemeData(
  textTheme: lightTextTheme,
  backgroundColor: Colors.white,
  dialogBackgroundColor: Colors.white,
  bottomSheetTheme: lightBottomSheetThemeData,
  dialogTheme: lightDialogTheme,
  buttonTheme: lightButtonThemeData,
  chipTheme: lightChipTheme,
  textButtonTheme: lightTextButtonTheme,
  dividerColor: const Color(0xFFF5F5F5),
  errorColor: lightErrorColor,
  hintColor: lightColorFFACACAC,
  toggleableActiveColor: lightColorFF222222,
  unselectedWidgetColor: lightColorFFF5F5F7,
  useMaterial3: true
);

final ThemeData darkThemeData = lightThemeData;
