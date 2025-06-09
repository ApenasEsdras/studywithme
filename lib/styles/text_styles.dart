// ignore_for_file: require_trailing_commas

import 'package:flutter/material.dart';

import 'colors_app.dart';

class TextStyles {
  static TextStyles? _instance;

  TextStyles._();

  static TextStyles get instance {
    _instance ??= TextStyles._();
    return _instance!;
  }

  String get fontFamily => 'roboto';

  TextStyle get textRegular =>
      TextStyle(fontWeight: FontWeight.w400, fontFamily: fontFamily);

  TextStyle get textMedium => TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily,
      color: ColorsApp.instance.Preto);

  TextStyle get textBold => TextStyle(
      fontWeight: FontWeight.w600,
      fontFamily: fontFamily,
      color: ColorsApp.instance.Preto);

  TextStyle get textMedium16 => textMedium.copyWith(fontSize: 16);
  TextStyle get textMedium16Laranja =>
      textMedium.copyWith(fontSize: 16, color: ColorsApp.instance.Laranja);
  TextStyle get textMedium20Laranja =>
      textMedium.copyWith(fontSize: 20, color: ColorsApp.instance.Laranja);
  TextStyle get textMedium20 => textMedium.copyWith(fontSize: 20);
  TextStyle get textRegular12 => textRegular.copyWith(fontSize: 12);
  TextStyle get textBold36 => textBold.copyWith(fontSize: 28);
}

extension TextStylesExtensions on BuildContext {
  TextStyles get textStyles => TextStyles.instance;
}
