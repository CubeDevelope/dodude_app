import 'dart:io';

import 'package:app/views/actions.page.dart';
import 'package:app/views/auth/auth_manger.page.dart';
import 'package:app/views/auth/login.page.dart';
import 'package:app/views/discovery.page.dart';
import 'package:app/views/friend_profile.page.dart';
import 'package:app/views/friends.page.dart';
import 'package:app/views/friendship_requests.page.dart';
import 'package:app/views/home.page.dart';
import 'package:app/views/notification.page.dart';
import 'package:app/views/profile.page.dart';
import 'package:app/views/settings/personal_data.page.dart';
import 'package:app/views/settings/privacy.settings.page.dart';
import 'package:app/views/settings/settings.page.dart';
import 'package:flutter/cupertino.dart';

enum PagesEnum {
  discovery,
  friends,
  notifications,
  profile,
  login,
}

enum MasterPages {
  auth,
  home,
  personalData,
  settings,
  newAction,
  privacy,
  friendProfile,
  friendshipRequest,
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

extension MasterPagesExt on MasterPages {
  String get toPath => toString().split('.').last;

  static MasterPages toPage(String? path) {
    if (path != null) {
      for (MasterPages page in MasterPages.values) {
        if (page.toPath == path) return page;
      }
    }
    return MasterPages.auth;
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

      case PagesEnum.notifications:
        page = const NotificationPage();
        break;
      case PagesEnum.profile:
        page = const ProfilePage();
        break;
      case PagesEnum.login:
        page = const LoginPage();
        break;
    }

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: page,
        );
      },
    );
  }

  static PageRoute masterGenerateRoute(RouteSettings settings) {
    Widget page = Container();
    switch (MasterPagesExt.toPage(settings.name)) {
      case MasterPages.personalData:
        page = const PersonalDataPage();
        break;
      case MasterPages.auth:
        page = const AuthManagerPage();
        break;
      case MasterPages.home:
        page = const HomePage();
        break;
      case MasterPages.settings:
        page = const SettingsPage();
        break;
      case MasterPages.privacy:
        page = const PrivacySettingPage();
        break;
      case MasterPages.newAction:
        page = const ActionsPage();
        break;
      case MasterPages.friendProfile:
        page = const FriendProfilePage();
        break;
      case MasterPages.friendshipRequest:
        page = const FriendshipRequestsPage();
        break;
    }

    if (Platform.isIOS) {
      return CupertinoPageRoute(
        builder: (context) {
          return page;
        },
      );
    }

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
        /*return FadeTransition(
            opacity: animation,
            child:,
          );*/
      },
    );
  }
}
