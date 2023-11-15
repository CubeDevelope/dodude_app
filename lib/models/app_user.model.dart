import 'package:app/models/completed_action.model.dart';
import 'package:app/models/notification.model.dart';
import 'package:app/models/user.model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AppUser {
  UserModel? user;
  List<NotificationModel> notifications = [];
  List<CompletedAction> actions = [];

  Reference get storageUserRef {
    final ref = FirebaseStorage.instance.ref();
    return ref.child('users').child(user!.uid!).child('uploads');
  }

  copyWith({
    List<NotificationModel>? notifications,
    UserModel? user,
    List<CompletedAction>? actions,
  }) {
    final appUser = AppUser();
    appUser.user = user ?? this.user;
    appUser.notifications = notifications ?? this.notifications;
    appUser.actions = actions ?? this.actions;
    return appUser;
  }
}
