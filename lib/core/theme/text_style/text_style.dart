import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme.dart';

class UiTextStyle {
  /// [fontSize: 56, FontWeight.w500, UiColors.textDarker, letterSpacing: 0]
  static TextStyle h1({
    Color? color,
    FontWeight fontWeight = FontWeight.w500,
    double letterSpacing = 0,
  }) => GoogleFonts.figtree(
    fontSize: 56,
    fontWeight: fontWeight,
    color: color ?? UiColors.textDarker,
    letterSpacing: letterSpacing,
  );

  /// [fontSize: 48, FontWeight.w500, UiColors.textDarker, letterSpacing: 0]
  static TextStyle h2({
    Color? color,
    FontWeight fontWeight = FontWeight.w500,
    double letterSpacing = 0,
  }) => GoogleFonts.figtree(
    fontSize: 48,
    fontWeight: fontWeight,
    color: color ?? UiColors.textDarker,
    letterSpacing: letterSpacing,
  );

  /// [fontSize: 40, FontWeight.w500, UiColors.textDarker, letterSpacing: 0]
  static TextStyle h3({
    Color? color,
    FontWeight fontWeight = FontWeight.w500,
    double letterSpacing = 0,
  }) => GoogleFonts.figtree(
    fontSize: 40,
    fontWeight: fontWeight,
    color: color ?? UiColors.textDarker,
    letterSpacing: letterSpacing,
  );

  /// [fontSize: 32, FontWeight.w500, PrimitiveColors.grey800, letterSpacing: 0]
  static TextStyle h4({
    Color? color,
    FontWeight fontWeight = FontWeight.w500,
    double letterSpacing = 0,
  }) => GoogleFonts.figtree(
    fontSize: 32,
    fontWeight: fontWeight,
    color: color ?? UiColors.textDarker,
    letterSpacing: letterSpacing,
  );

  /// [fontSize: 24, FontWeight.w500, PrimitiveColors.grey800, letterSpacing: 0]
  static TextStyle h5({
    Color? color,
    FontWeight fontWeight = FontWeight.w500,
    double letterSpacing = 0,
  }) => GoogleFonts.figtree(
    fontSize: 24,
    fontWeight: fontWeight,
    color: color ?? UiColors.textDarker,
    letterSpacing: letterSpacing,
  );

  /// [fontSize: 20, FontWeight.w500, PrimitiveColors.grey800, letterSpacing: 0]
  static TextStyle h6({
    Color? color,
    FontWeight fontWeight = FontWeight.w500,
    double letterSpacing = 0,
  }) => GoogleFonts.figtree(
    fontSize: 20,
    fontWeight: fontWeight,
    color: color ?? UiColors.textDarker,
    letterSpacing: letterSpacing,
  );

  /// [fontSize: 18, FontWeight.w500, PrimitiveColors.grey800, letterSpacing: 0]
  static TextStyle body18({
    Color? color,
    Color? backgroundColor,
    FontWeight fontWeight = FontWeight.w500,
    double letterSpacing = 0,
  }) => GoogleFonts.publicSans(
    fontSize: 18,
    fontWeight: fontWeight,
    color: color ?? PrimitiveColors.neutral700,
    backgroundColor: backgroundColor,
    letterSpacing: letterSpacing,
  );

  /// [fontSize: 16, FontWeight.w500, PrimitiveColors.grey800, letterSpacing: 0]
  static TextStyle body16({
    Color? color,
    Color? backgroundColor,
    FontWeight fontWeight = FontWeight.w400,
    double letterSpacing = 0,
    TextDecoration? decoration,
    Color? decorationColor,
    double? decorationThickness,
    TextDecorationStyle? decorationStyle,
  }) => GoogleFonts.publicSans(
    fontSize: 16,
    fontWeight: fontWeight,
    color: color ?? UiColors.textStrong,
    backgroundColor: backgroundColor,
    letterSpacing: letterSpacing,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationThickness: decorationThickness,
    decorationStyle: decorationStyle,
  );

  /// [fontSize: 14, FontWeight.w500, PrimitiveColors.grey800, letterSpacing: 0]
  static TextStyle body14({
    Color? color,
    FontWeight fontWeight = FontWeight.w500,
    double letterSpacing = 0,
  }) => GoogleFonts.publicSans(
    fontSize: 14,
    fontWeight: fontWeight,
    color: color ?? PrimitiveColors.neutral700,
    letterSpacing: letterSpacing,
  );

  /// [fontSize: 12, FontWeight.w500, PrimitiveColors.grey800, letterSpacing: 0]
  static TextStyle body12({
    Color? color,
    FontWeight fontWeight = FontWeight.w500,
    double letterSpacing = 0,
  }) => GoogleFonts.publicSans(
    fontSize: 12,
    fontWeight: fontWeight,
    color: color ?? PrimitiveColors.neutral700,
    letterSpacing: letterSpacing,
  );

  /// [fontSize: 10, FontWeight.w500, PrimitiveColors.grey800, letterSpacing: 0]
  static TextStyle overline10({
    Color? color,
    FontWeight fontWeight = FontWeight.w500,
    double letterSpacing = 0,
  }) => GoogleFonts.publicSans(
    fontSize: 10,
    fontWeight: fontWeight,
    color: color ?? PrimitiveColors.neutral700,
    letterSpacing: letterSpacing,
  );
}
