import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum AppIcons {
  earth,
  bell,
  friends,
}

extension AppIconsExt on AppIcons {
  String get toAssetPath => "assets/icons/${toString().split('.').last}.svg";
}

class Keys {
  static GlobalKey<NavigatorState> internalNavigator =
      GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> masterNavigator =
      GlobalKey<NavigatorState>();
}

DateFormat dateFormat = DateFormat("dd/MM/yyyy");

class AppColors {
  static Color accentColor = const Color(0xffff7300);

  static ThemeData lightTheme = ThemeData.light();
  static ThemeData darkTheme = ThemeData.dark().copyWith(
      appBarTheme: ThemeData.dark().appBarTheme.copyWith(
          elevation: 0,
          color: ThemeData.dark().scaffoldBackgroundColor,
          centerTitle: true));
}
