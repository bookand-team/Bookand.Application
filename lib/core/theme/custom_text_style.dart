import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_table.dart';

extension CustomTextStyle on TextStyle {
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
      fontWeight: FontWeight.w400,
      fontSize: 16,
      letterSpacing: -0.02,
      color: lightColorFF222222);

  TextStyle unselectedBottomNavItemText() => const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 8,
    color: Colors.black
  );

  TextStyle selectedBottomNavItemText() => const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 8,
    color: Color(0xFF999999)
  );

  TextStyle hashtagText() => const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 10,
      letterSpacing: -0.02,
      color: Colors.black
  );

  TextStyle articleBoxTitleText() => const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 26,
    letterSpacing: -0.02,
    color: Colors.white,
    height: 1.2
  );

  TextStyle articleBoxContentText() => const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.02,
    color: Colors.white
  );
}
