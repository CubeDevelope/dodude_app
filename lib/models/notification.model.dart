import 'package:app/enums/endpoint.dart';
import 'package:app/models/base.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel extends Model {
  static String createdAtKey = "created_at";
  static String uidKey = "uid";
  static String notificationDescriptionKey = "notification_description";
  static String notificationTitleKey = "notification_title";
  static String notificationTypeKey = "notification_type";

  final Timestamp? createdAt;
  final String notificationDescription;
  final String notificationTitle;
  final NotificationType notificationType;

  NotificationModel(
      {this.createdAt,
      String uid = "",
      this.notificationDescription = "",
      this.notificationTitle = "",
      this.notificationType = NotificationType.follow})
      : super(uid);

  factory NotificationModel.fromJson(Map<String, dynamic> map) {
    return NotificationModel(
      createdAt: map[createdAtKey],
      notificationDescription: map[notificationDescriptionKey] ?? "",
      notificationTitle: map[notificationTitleKey] ?? "",
      notificationType: NotificationType.follow,
    );
  }

  factory NotificationModel.fromDocument(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    NotificationModel model = NotificationModel.fromJson(map);
    model.uid = snapshot.id;
    return model;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      uidKey: uid,
      createdAtKey: createdAt,
      notificationDescriptionKey: notificationDescription,
      notificationTitleKey: notificationTitle,
      notificationTypeKey: notificationType
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid;

  @override
  int get hashCode => createdAt.hashCode;
}
