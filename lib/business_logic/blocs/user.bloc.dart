import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/models/app_user.model.dart';
import 'package:app/models/completed_action.model.dart';
import 'package:app/models/notification.model.dart';
import 'package:app/models/user.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Cubit<AppUser> {
  UserBloc() : super(AppUser());

  login(UserModel model) {
    AppUser appUser = state;
    appUser.user = model;
    _setListeners();
    emit(appUser);
  }

  _setListeners() {
    AppProvider.instance.firestoreManager
        .getUserNotificationSnapshot(state.user!.uid!)
        .listen(_editNotifications);
    AppProvider.instance.firestoreManager
        .getUserInformationSnapshot(state.user!.uid!)
        .listen((event) {
      emit(state.copyWith(user: UserModel.fromDocument(event)));
    });
    AppProvider.instance.firestoreManager
        .getUserActionsSnapshot(state.user!.uid!)
        .listen(_editActions);
  }

  _editNotifications(QuerySnapshot event) {
    var stateNotifications = [...state.notifications];
    for (var element in event.docChanges) {
      final not = NotificationModel.fromDocument(element.doc);
      switch (element.type) {
        case DocumentChangeType.added:
          if (!stateNotifications.contains(not)) stateNotifications.add(not);
          break;
        case DocumentChangeType.modified:
          stateNotifications.remove(not);
          stateNotifications.add(not);
          break;
        case DocumentChangeType.removed:
          stateNotifications.remove(not);
          break;
      }
    }

    emit(state.copyWith(notifications: stateNotifications));
  }

  _editActions(QuerySnapshot event) {
    final stateActions = [...state.actions];
    for (var element in event.docChanges) {
      final action = CompletedAction.fromDocument(element.doc);
      switch (element.type) {
        case DocumentChangeType.added:
          if (!stateActions.contains(action)) stateActions.add(action);
          break;
        case DocumentChangeType.modified:
          stateActions.remove(action);
          stateActions.add(action);
          break;
        case DocumentChangeType.removed:
          stateActions.remove(action);
          break;
      }
    }

    emit(state.copyWith(actions: stateActions));
  }
}
