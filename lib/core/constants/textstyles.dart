import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class GLTextStyles {
  static poppinsStyle({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.poppins(
      fontSize: size ?? 30,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.white,
    );
  }

  static snackbartxt({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.poppins(
      fontSize: size ?? 16,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.black,
    );
  }
  static cabinStyle({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.cabin(
      fontSize: size ?? 22,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.black,
    );
  }

  static manropeStyle(
      {double? size, FontWeight? weight, Color? color, bool isItalic = false}) {
    return GoogleFonts.manrope(
      fontSize: size ?? 22,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.black,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
    );
  }

  static interStyle({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.inter(
      fontSize: size ?? 22,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.black,
    );
  }
}
