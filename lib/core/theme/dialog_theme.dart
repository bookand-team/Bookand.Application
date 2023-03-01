import 'package:flutter/material.dart';

const DialogTheme lightDialogTheme = DialogTheme(
  backgroundColor: Colors.white,
  surfaceTintColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(16),
    ),
  ),
  contentTextStyle: TextStyle(
    color: Color(0xFf222222),
    fontWeight: FontWeight.w600,
    fontSize: 18,
    letterSpacing: -0.02,
  ),
);

const DialogTheme darkDialogTheme = lightDialogTheme;
