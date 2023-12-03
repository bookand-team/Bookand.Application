import 'package:flutter/material.dart';

final InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF222222)),
      borderRadius: BorderRadius.circular(8),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF222222)),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF222222)),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF222222)),
      borderRadius: BorderRadius.circular(8),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF222222)),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF222222)),
      borderRadius: BorderRadius.circular(8),
    ),
    hintStyle: const TextStyle(
      color: Color(0xFFACACAC),
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: -0.02,
    ),
);

final InputDecorationTheme darkInputDecorationTheme = lightInputDecorationTheme;
