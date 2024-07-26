import 'package:flutter/material.dart';

import 'color_constant.dart';

class ConstantTheme {
  static ThemeData lightTheme = ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    colorScheme: const ColorScheme.light().copyWith(
      primary: ColorConstants.black,
      secondary: ColorConstants.white,
      shadow: const Color(0xffA69426),
      surface: ColorConstants.white, //card
        onPrimary: ColorConstants.whiteEf,
      onPrimaryContainer: const Color(0xFFE4E4E4),
      background: ColorConstants.white4d//border
    ),
    bottomSheetTheme: const BottomSheetThemeData(),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    colorScheme: const ColorScheme.dark().copyWith(
      background: ColorConstants.black28,
      secondary: ColorConstants.black,
      onPrimary: ColorConstants.black31,
      primary: ColorConstants.white,
      onPrimaryContainer: const Color(0xFF717171), //border
    ),
  );
}
