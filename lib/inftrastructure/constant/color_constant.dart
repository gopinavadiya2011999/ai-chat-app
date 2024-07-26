import 'package:flutter/material.dart';

class ColorConstants {
  static const Color transparent = Colors.transparent;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color black28 = Color(0xff0a1628);
  static const Color white4d = Color(0xfff0f4fd);
  static const Color black31 = Color(0xff172031);
  static const Color whiteEf = Color(0xffe7eaef);
  static const Color grey8B = Color(0xff8B8B8B);
  static const Color blueDd = Color(0xff3C61DD);
}

class ThemeColors {
  static Color greyColor = ColorConstants.grey8B;
  static Color blueDd = ColorConstants.blueDd;
  static Color primary(BuildContext context) => Theme.of(context).colorScheme.primary;
  static Color secondary(BuildContext context) => Theme.of(context).colorScheme.secondary;
  static Color onPrimary(BuildContext context) => Theme.of(context).colorScheme.onPrimary;
  static Color background(BuildContext context) => Theme.of(context).colorScheme.background;
}
