import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors/app_colors.dart';
import '../constants/font_weight.dart';

/// light theme configuration.
appLightTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    primarySwatch: createMaterialColor(whiteFFFFFFColor),
    // backgroundColor: whiteFFFFFFColor,
    scaffoldBackgroundColor: whiteFFFFFFColor,

    appBarTheme: Theme.of(context).appBarTheme.copyWith(
        color: whiteFFFFFFColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: whiteFFFFFFColor,
            statusBarIconBrightness: Brightness.dark),
        iconTheme: const IconThemeData(color: black101010Color, size: 28),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 19,
          fontWeight: normal,
        )),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
