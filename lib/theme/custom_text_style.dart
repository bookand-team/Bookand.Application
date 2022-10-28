import 'package:bookand/theme/color_table.dart';
import 'package:bookand/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension CustomTextStyle on TextStyle {
  TextStyle logoText() => const TextStyle(
    fontFamily: gMarketSansTTF,
    fontSize: 18,
    letterSpacing: -0.03,
    color: Colors.white
  );

  TextStyle roundRectButtonText({bool enabled = true}) => TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 15,
      letterSpacing: -0.04,
      color: enabled ? Colors.white : lightColorFF222222);

  TextStyle termsOfServicePageTitle() => const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 24,
      letterSpacing: -0.04,
      color: lightColorFF222222);

  TextStyle termsOfServiceAllAgreeText() => const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      letterSpacing: -0.04,
      color: lightColorFF222222);

  TextStyle termsOfServiceItemText() => const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: -0.04,
      color: lightColorFF222222);

  TextStyle termsOfServiceContentsScreenTitle() => const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20,
      letterSpacing: -0.04,
      color: Colors.black);

  TextStyle termsOfServiceContentText() => const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      letterSpacing: -0.04,
      color: lightColorFFACACAC);

  TextStyle googleLoginText() => GoogleFonts.roboto(
      fontWeight: FontWeight.w500, fontSize: 16, letterSpacing: -0.04, color: lightColorFF222222);

  TextStyle appleLoginText() => const TextStyle(
      fontFamily: pretendard,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      letterSpacing: -0.02,
      color: lightColorFF222222);
}
