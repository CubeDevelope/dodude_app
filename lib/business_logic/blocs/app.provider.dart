import 'package:app/business_logic/blocs/auth.bloc.dart';
import 'package:app/business_logic/blocs/pages_bloc/action.bloc.dart';
import 'package:app/business_logic/blocs/pages_bloc/home.bloc.dart';
import 'package:app/business_logic/blocs/pages_bloc/notification.bloc.dart';
import 'package:app/business_logic/blocs/pages_bloc/settings.bloc.dart';
import 'package:app/business_logic/managers/firestore.manager.dart';
import 'package:app/business_logic/repositories/firestore.repositories.dart';
import 'package:app/enums/endpoint.dart';
import 'package:app/models/action_type.model.dart';
import 'package:app/models/user.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// In questa classe vengono salvate tutte le informazioni che devono viaggiare all'interno dell'app
class AppProvider {
  static final AppProvider _instance = AppProvider._();

  static AppProvider get instance => _instance;

  UserModel currentUser = UserModel();

  AppProvider._();

  HomeCubit homeCubit = HomeCubit();
  SettingCubit settingBloc = SettingCubit();
  AuthCubit authCubit = AuthCubit();
  ActionCubit actionCubit = ActionCubit();
  NotificationCubit notificationCubit = NotificationCubit();

  FirestoreManager firestoreManager = FirestoreManager();
  FirestoreRepository firestoreRepository = FirestoreRepository();

  getNotification() async {
    notificationCubit.getNotifications();
  }

  syncActions() {
    homeCubit.getAllActions();
    actionCubit.getThreeActions();
  }

  DocumentReference get userDocReference {
    return firestoreRepository.getDocumentReference(
        currentUser.uid!, FirestoreCollectionsNames.user);
  }
}
