import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/models/notification.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCubit extends Cubit<List<NotificationModel>> {
  NotificationCubit() : super([]);

  getNotifications() {
    AppProvider.instance.firestoreManager
        .getUserNotificationSnapshot(AppProvider.instance.currentUser.uid!)
        .listen((event) {
      if (state.isEmpty) {
        emit(event.docs.map((e) => NotificationModel.fromDocument(e)).toList());
      } else {
        for (var value in event.docChanges) {
          List<NotificationModel> list = state;
          var model = NotificationModel.fromDocument(value.doc);
          switch (value.type) {
            case DocumentChangeType.added:
              if (!list.contains(model)) list.add(model);
              break;
            case DocumentChangeType.modified:
              if (list.contains(model)) {
                list.remove(model);
                list.add(model);
              }

              break;
            case DocumentChangeType.removed:
              if (list.contains(model)) list.remove(model);

              break;
          }

          list.sort((a, b) {
            return a.createdAt?.compareTo(b.createdAt ?? Timestamp.now()) ?? 0;
          },);

          emit(list);
        }
      }
    });
  }
}
