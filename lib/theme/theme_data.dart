import 'package:bookand/theme/text_button_theme.dart';
import 'package:flutter/material.dart';

import 'bottom_sheet_theme_data.dart';
import 'chip_theme_data.dart';
import 'color_table.dart';
import 'dialog_theme.dart';

const String pretendard = "Pretendard";

final ThemeData lightThemeData = ThemeData(
  fontFamily: pretendard,
  backgroundColor: Colors.white,
  dialogBackgroundColor: Colors.white,
  bottomSheetTheme: lightBottomSheetThemeData,
  dialogTheme: lightDialogTheme,
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
