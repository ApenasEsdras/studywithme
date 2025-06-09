// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'package:flutter/material.dart';

class ThemeConfig {
  ThemeConfig._();

  static String temaApp = 'light';

  static ThemeData get tema {
    switch (temaApp) {
      case 'light':
        return temalight;
      case 'dark':
        return temaDark;
      default:
        return temalight;
    }
  }

  static Color laranja = const Color(0xFFFF5722);
  static Color verde = const Color(0xFF7AC74F);
  static Color vermelho = const Color(0xFFE71D36);
  static Color vermelhoFortes = const Color(0xFFCE1719);

  static Color cinzaEscuro = const Color.fromRGBO(69, 69, 69, 1);
  static Color cinzaMedio = const Color.fromRGBO(205, 205, 205, 1);
  static Color cinzaMedio2 = const Color.fromRGBO(69, 69, 69, 0.7);
  static Color cinzaClaro = const Color.fromRGBO(69, 69, 69, 0.1);

  static Color branco = const Color(0xFFFDFDFD);
  static Color preto = const Color(0xFF454545);

  // Text styles centralizados no ThemeConfig
  static const String fontFamily = 'roboto';

  static TextStyle get textRegular =>
      const TextStyle(fontWeight: FontWeight.w400, fontFamily: fontFamily);
  static TextStyle get textMedium =>
      const TextStyle(fontWeight: FontWeight.w500, fontFamily: fontFamily);
  static TextStyle get textBold =>
      const TextStyle(fontWeight: FontWeight.w600, fontFamily: fontFamily);
  static TextStyle get textMedium16 => TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
    fontSize: 16,
  );
  static TextStyle get textMedium20 => TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
    fontSize: 20,
  );
  static TextStyle get textRegular12 => TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
    fontSize: 12,
  );
  static TextStyle get textBold36 => TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
    fontSize: 28,
  );

  static final temalight = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: ThemeConfig.branco,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: ThemeConfig.laranja,
      primary: ThemeConfig.laranja,
      background: ThemeConfig.branco,
      surface: ThemeConfig.branco,
      error: ThemeConfig.vermelho,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ThemeConfig.branco,
      foregroundColor: ThemeConfig.laranja,
      surfaceTintColor: ThemeConfig.branco,
      elevation: 0,
      iconTheme: IconThemeData(color: ThemeConfig.laranja, size: 35),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        backgroundColor: ThemeConfig.laranja,
        textStyle: ThemeConfig.textMedium20,
        foregroundColor: ThemeConfig.branco,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: ThemeConfig.branco,
      filled: true,
      isDense: true,
      iconColor: ThemeConfig.preto,
      contentPadding: const EdgeInsets.all(20),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: ThemeConfig.cinzaMedio),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: ThemeConfig.laranja),
      ),
      labelStyle: ThemeConfig.textMedium.copyWith(color: ThemeConfig.preto),
      floatingLabelStyle: MaterialStateTextStyle.resolveWith((
        Set<MaterialState> states,
      ) {
        final Color color =
            states.contains(MaterialState.focused)
                ? ThemeConfig.tema.colorScheme.primary
                : ThemeConfig.cinzaMedio2;
        return ThemeConfig.textMedium.copyWith(color: color);
      }),
      errorStyle: ThemeConfig.textRegular.copyWith(color: ThemeConfig.vermelho),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: ThemeConfig.branco,
      surfaceTintColor: ThemeConfig.branco,
    ),
    dialogTheme: DialogTheme(
      surfaceTintColor: ThemeConfig.branco,
      backgroundColor: ThemeConfig.branco,
    ),
    iconTheme: IconThemeData(color: ThemeConfig.preto),
  );

  static final temaDark = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: ThemeConfig.preto,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: ThemeConfig.laranja,
      primary: ThemeConfig.laranja,
      background: ThemeConfig.cinzaMedio2,
      surface: ThemeConfig.cinzaMedio2,
      error: ThemeConfig.vermelho,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ThemeConfig.cinzaMedio2,
      foregroundColor: ThemeConfig.laranja,
      surfaceTintColor: ThemeConfig.cinzaMedio2,
      elevation: 0,
      iconTheme: IconThemeData(color: ThemeConfig.laranja, size: 35),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        backgroundColor: ThemeConfig.laranja,
        textStyle: ThemeConfig.textMedium20,
        foregroundColor: ThemeConfig.cinzaMedio2,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: ThemeConfig.cinzaEscuro,
      filled: true,
      isDense: true,
      iconColor: ThemeConfig.branco,
      contentPadding: const EdgeInsets.all(20),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: ThemeConfig.cinzaMedio2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: ThemeConfig.laranja),
      ),
      labelStyle: ThemeConfig.textMedium.copyWith(color: ThemeConfig.branco),
      floatingLabelStyle: MaterialStateTextStyle.resolveWith((
        Set<MaterialState> states,
      ) {
        final Color color =
            states.contains(MaterialState.focused)
                ? ThemeConfig.laranja
                : ThemeConfig.cinzaMedio2;
        return ThemeConfig.textMedium.copyWith(color: color);
      }),
      errorStyle: ThemeConfig.textRegular.copyWith(color: ThemeConfig.vermelho),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: ThemeConfig.cinzaMedio2,
      surfaceTintColor: ThemeConfig.cinzaMedio2,
    ),
    dialogTheme: DialogTheme(
      surfaceTintColor: ThemeConfig.cinzaMedio2,
      backgroundColor: ThemeConfig.cinzaMedio2,
    ),
    iconTheme: IconThemeData(color: ThemeConfig.branco),
  );
}
