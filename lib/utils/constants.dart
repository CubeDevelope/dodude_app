import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum AppIcons {
  earth,
  bell,
  friends,
  send,
  settings,
  pin,
  chat,
  pasta,
  shuffle,
  back,
  tagSelected,
  tagUnselected,
  pinSelected,
  pinUnselected,
  gridSelected,
  gridUnselected,
  rainbow,
  handshake,
  pizza,
  dodude,
}

_toLowerCaseString(String text) {
  return text.replaceAllMapped(
    RegExp(r'[A-Z]'),
    (match) => '_${match.group(0)!.toLowerCase()}',
  );
}

enum ActionIcons {
  dream,
  fire,
}

extension AppIconsExt on AppIcons {
  String get toAssetPath {
    String path = _toLowerCaseString(toString().split('.').last);

    return "assets/icons/$path.svg";
  }
}

extension ActionIconsExt on ActionIcons {
  String get toAssetPath {
    String path = _toLowerCaseString(toString().split('.').last);

    return "assets/action_icons/$path.svg";
  }
}

class Keys {
  static GlobalKey<NavigatorState> internalNavigator =
      GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> masterNavigator =
      GlobalKey<NavigatorState>();
}

DateFormat dateFormat = DateFormat("dd/MM/yyyy");

class AppColors {
  static Color accentColor = const Color(0xffFFCC4D);

  static ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: ThemeData.light().colorScheme.copyWith(
          primary: Colors.black,
          secondary: const Color(0xffFFCC4D),
        ),
    floatingActionButtonTheme: ThemeData.light()
        .floatingActionButtonTheme
        .copyWith(backgroundColor: AppColors.accentColor),
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
          elevation: 0,
          titleTextStyle: ThemeData.light()
              .appBarTheme
              .titleTextStyle
              ?.copyWith(color: Colors.black),
          color: const Color(0xffFFCC4D),
          centerTitle: true,
        ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: ThemeData.dark().colorScheme.copyWith(
          primary: accentColor,
          secondary: Colors.black,
        ),
    floatingActionButtonTheme:
        ThemeData.dark().floatingActionButtonTheme.copyWith(
              backgroundColor: AppColors.accentColor,
            ),
    appBarTheme: ThemeData.dark().appBarTheme.copyWith(
        elevation: 0,
        titleTextStyle: ThemeData.dark()
            .appBarTheme
            .titleTextStyle
            ?.copyWith(color: Colors.white),
        color: ThemeData.dark().scaffoldBackgroundColor,
        centerTitle: true),
  );
}

extension ReferenceExt on Reference {
  String get storagePath {
    String basePath =
        "https://firebasestorage.googleapis.com/v0/b/moodmate-2d671.appspot.com/o/";
    String referencePath = fullPath.replaceAll('/', '%2F');
    return "$basePath$referencePath?alt=media&token=ff7b0725-3f9c-4159-be3c-ab075d3640bd";
  }
}
