import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color scaffoldGrey = Color(0xFFF5F5F5);

  static const Color gainGreen = Color(0xFF3BAB6A);
  static const Color lossRed = Color(0xFFD94040);
  static const Color neutral = Color(0xFF888888);

  static const Color textPrimary = Color(0xFF111111);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textMuted = Color(0xFF999999);

  static const Color divider = Color(0xFFE8E8E8);
  static const Color border = Color(0xFFDDDDDD);
  static const Color dragHandleColor = Color(0xFFBBBBBB);
  static const Color tabActive = Color(0xFF111111);
  static const Color tabInactive = Color(0xFFAAAAAA);
  static const Color sortBtnBg = Color(0xFFF0F0F0);

  static const Color saveButtonBg = Color(0xFF111111);
  static const Color editButtonBorder = Color(0xFF111111);

  // ── Text Styles ───────────────────────────────────────────────────────────────
  static const TextStyle symbolStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: textPrimary,
    letterSpacing: 0.1,
  );

  static const TextStyle priceStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: textPrimary,
  );

  static const TextStyle subLabelStyle = TextStyle(
    fontSize: 12,
    color: textSecondary,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle changeStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle appBarTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static const TextStyle tabActiveStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: tabActive,
  );

  static const TextStyle tabInactiveStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: tabInactive,
  );

  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: background,
        colorScheme: const ColorScheme.light(
          background: background,
          surface: surface,
          primary: Color(0xFF111111),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: background,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: appBarTitle,
          iconTheme: IconThemeData(color: textPrimary),
          surfaceTintColor: Colors.transparent,
        ),
        dividerTheme: const DividerThemeData(
          color: divider,
          thickness: 0.8,
          space: 0,
        ),
        useMaterial3: true,
      );
}
