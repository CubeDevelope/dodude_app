import 'package:app/business_logic/blocs/auth.bloc.dart';
import 'package:app/business_logic/blocs/pages_bloc/action.bloc.dart';
import 'package:app/business_logic/blocs/pages_bloc/home.bloc.dart';
import 'package:app/business_logic/blocs/pages_bloc/notification.bloc.dart';
import 'package:app/business_logic/blocs/pages_bloc/profile.bloc.page.dart';
import 'package:app/business_logic/blocs/pages_bloc/settings.bloc.dart';
import 'package:app/business_logic/managers/firestore.manager.dart';
import 'package:app/business_logic/repositories/firestore.repositories.dart';
import 'package:app/enums/endpoint.dart';
import 'package:app/models/user.model.dart';
import 'package:app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// In questa classe vengono salvate tutte le informazioni che devono viaggiare all'interno dell'app
class AppProvider {
  static final AppProvider _instance = AppProvider._();

  static AppProvider get instance => _instance;

  PermissionStatus cameraPermission = PermissionStatus.denied;

  UserModel currentUser = UserModel();

  AppProvider._();

  HomeCubit homeCubit = HomeCubit();
  SettingCubit settingBloc = SettingCubit();
  AuthCubit authCubit = AuthCubit();
  ActionCubit actionCubit = ActionCubit();
  NotificationCubit notificationCubit = NotificationCubit();
  ProfileCubit profileCubit = ProfileCubit();

  FirestoreManager firestoreManager = FirestoreManager();
  FirestoreRepository firestoreRepository = FirestoreRepository();

  getNotification() async {
    notificationCubit.getNotifications();
  }

  showSheet(Widget message) {
    BuildContext? context = Keys.masterNavigator.currentContext;
    Text? messageText;
    if (message is Text) {
      messageText = Text(
        message.data ?? "",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      );
    }
    if (context != null) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 54,
            alignment: Alignment.center,
            child: messageText ?? message,
          );
        },
      );
    }
  }

  syncActions() async {
    homeCubit.getAllActions();
    actionCubit.getThreeActions();
  }

  DocumentReference get userDocReference {
    return firestoreRepository.getDocumentReference(
      currentUser.uid!,
      collectionsEndpoint: FirestoreCollectionsNames.user,
    );
  }
}
