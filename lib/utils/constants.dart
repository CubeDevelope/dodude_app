import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Keys {
  static GlobalKey<NavigatorState> internalNavigator = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> masterNavigator = GlobalKey<NavigatorState>();
}

DateFormat dateFormat = DateFormat("dd/MM/yyyy");
class AppColors {
  static Color accentColor = const Color(0xffff7300);
}