import 'package:flutter/material.dart';

const String pretendard = "Pretendard";

const TextTheme lightTextTheme = TextTheme(
  /// Headline1
  displayLarge: TextStyle(
      fontFamily: pretendard,
      fontWeight: FontWeight.w600,
      fontSize: 26,
      letterSpacing: -0.04),
  /// Headline2
  displayMedium: TextStyle(
      fontFamily: pretendard,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      letterSpacing: -0.04),
  /// Subtitle1
  titleMedium: TextStyle(
      fontFamily: pretendard,
      fontWeight: FontWeight.w600,
      fontSize: 14,
      letterSpacing: -0.04),
  /// Body1
  bodyLarge: TextStyle(
      fontFamily: pretendard,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: -0.04),
  /// Body2
  bodyMedium: TextStyle(
      fontFamily: pretendard,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      letterSpacing: -0.04),
  /// Body3
  /// fontSize: 12, 16
  bodySmall: TextStyle(
      fontFamily: pretendard,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.04),
  /// Button
  /// fontSize: 14, 15, 16
  labelLarge: TextStyle(
      fontFamily: pretendard,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.04),
  /// Label1
  labelMedium: TextStyle(
      fontFamily: pretendard,
      fontWeight: FontWeight.w400,
      fontSize: 10,
      letterSpacing: -0.04),
);

const TextTheme darkTextTheme = lightTextTheme;
