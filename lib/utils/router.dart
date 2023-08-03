import 'package:app/views/actions.page.dart';
import 'package:app/views/discovery.page.dart';
import 'package:app/views/friends.page.dart';
import 'package:app/views/login.page.dart';
import 'package:app/views/notification.page.dart';
import 'package:app/views/profile.page.dart';
import 'package:app/views/settings.page.dart';
import 'package:flutter/material.dart';

enum PagesEnum {
  discovery,
  friends,
  newAction,
  notifications,
  profile,
  login,
  settings,
}

extension PagesEnumExt on PagesEnum {
  String get toPath => toString().split('.').last;

  static PagesEnum toPage(String? path) {
    if (path != null) {
      for (PagesEnum page in PagesEnum.values) {
        if (page.toPath == path) return page;
      }
    }
    return PagesEnum.discovery;
  }
}

class Router {
  static PageRoute generateRoute(RouteSettings settings) {
    Widget page = Container();
    switch (PagesEnumExt.toPage(settings.name)) {
      case PagesEnum.discovery:
        page = const DiscoveryPage();
        break;
      case PagesEnum.friends:
        page = const FriendsPage();
        break;
      case PagesEnum.newAction:
        page = const ActionsPage();
        break;
      case PagesEnum.notifications:
        page = const NotificationPage();
        break;
      case PagesEnum.profile:
        page = const ProfilePage();
        break;
      case PagesEnum.login:
        page = const LoginPage();
        break;
      case PagesEnum.settings:
        page = SettingsPage();
        break;
    }

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
    );
  }
}
