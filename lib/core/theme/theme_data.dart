import 'package:bookand/core/theme/input_decoration_theme.dart';
import 'package:bookand/core/theme/progress_indicator_theme_data.dart';
import 'package:bookand/core/theme/text_button_theme.dart';
import 'package:flutter/material.dart';

import 'bottom_sheet_theme_data.dart';
import 'chip_theme_data.dart';
import 'color_table.dart';
import 'dialog_theme.dart';

const String pretendard = "Pretendard";

final ThemeData lightThemeData = ThemeData(
    fontFamily: pretendard,
    dialogBackgroundColor: Colors.white,
    bottomSheetTheme: lightBottomSheetThemeData,
    dialogTheme: lightDialogTheme,
    chipTheme: lightChipTheme,
    textButtonTheme: lightTextButtonTheme,
    progressIndicatorTheme: lightProgressIndicatorTheme,
    colorScheme: ColorScheme.fromSeed(
      seedColor: lightColorFF222222,
      background: Colors.white,
      error: lightErrorColor,
    ),
    dividerColor: const Color(0xFFF5F5F5),
    hintColor: lightColorFFACACAC,
    inputDecorationTheme: lightInputDecorationTheme,
    unselectedWidgetColor: lightColorFFF5F5F7,
    useMaterial3: true);

final ThemeData darkThemeData = lightThemeData;
