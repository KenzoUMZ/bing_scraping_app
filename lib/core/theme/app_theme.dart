import 'package:flutter/material.dart';

import 'theme.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    final base = ThemeData.light();
    return base.copyWith(
      useMaterial3: true,
      scaffoldBackgroundColor: UiColors.bgWhite,
      primaryColor: UiColors.primaryBase,
      colorScheme: ColorScheme.fromSeed(
        seedColor: UiColors.primaryBase,
        brightness: Brightness.light,
        primary: UiColors.primaryBase,
        onPrimary: UiColors.textWhite,
        secondary: UiColors.secondaryBase,
        onSecondary: UiColors.textWhite,
        error: UiColors.dangerMain,
        onError: UiColors.textWhite,
        background: UiColors.bgWhite,
        onBackground: UiColors.textDarker,
        surface: UiColors.bgWhite,
        onSurface: UiColors.textDark,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: UiColors.bgWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: UiColors.strokeStrong, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: UiColors.strokeStrong, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: UiColors.strokeStrong, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: UiColors.dangerMain, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: UiColors.dangerMain, width: 1.5),
        ),
        hintStyle: UiTextStyle.body16(color: UiColors.textMuted),
      ),
      textTheme: base.textTheme.copyWith(
        bodyMedium: UiTextStyle.body16(color: UiColors.textDarker),
      ),
    );
  }
}
