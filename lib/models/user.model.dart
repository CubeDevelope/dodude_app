import 'package:app/models/base.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends Model {
  static String userIdKey = "uid";

  static String nameKey = "name";
  static String surnameKey = "surname";
  static String usernameKey = "username";
  static String phoneNumberKey = "phone_number";
  static String emailKey = "email";
  static String friendsKey = "friends";
  static String activeNotificationsKey = "active_notifications";
  static String actionFinishedReviewedKey = "action_finished_reviewed";
  static String photoUrlKey = "photo_url";

  String? name;
  String? surname;
  String? username;
  String? phoneNumber;
  String? email;
  List<DocumentReference>? friends;
  List<DocumentReference>? activeNotifications;
  List<DocumentReference>? actionFinishedReviewed;
  String? photoUrl;

  UserModel(
      {String? uid,
      this.name,
      this.surname,
      this.username,
      this.phoneNumber,
      this.email,
      this.activeNotifications,
      this.actionFinishedReviewed,
      this.photoUrl,
      this.friends})
      : super(uid);

  String get fullName => "${name ?? ""} ${surname ?? ""}";

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      uid: map[userIdKey],
      name: map[nameKey],
      surname: map[surnameKey],
      username: map[usernameKey],
      phoneNumber: map[phoneNumberKey],
      email: map[emailKey],
      activeNotifications: map.containsKey(activeNotificationsKey)
          ? (map[activeNotificationsKey] as List)
              .map((e) => e as DocumentReference)
              .toList()
          : [],
      actionFinishedReviewed: map.containsKey(actionFinishedReviewedKey)
          ? (map[activeNotificationsKey] as List)
              .map((e) => e as DocumentReference)
              .toList()
          : [],
      photoUrl: map[photoUrlKey],
      friends: map.containsKey(friendsKey)
          ? (map[friendsKey] as List).cast<DocumentReference>()
          : [],
    );
  }

  factory UserModel.fromDocument(DocumentSnapshot snap) {
    var map = snap.data() as Map<String, dynamic>;
    UserModel model = UserModel.fromJson(map);
    model.uid = snap.id;
    return model;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      userIdKey: uid,
      nameKey: name,
      surnameKey: surname,
      usernameKey: username,
      phoneNumberKey: phoneNumber,
      activeNotificationsKey: activeNotifications ?? [],
      emailKey: email,
    };
  }

  UserModel copyWith({
    String? name,
    String? surname,
    String? username,
    String? phoneNumber,
    String? email,
  }) {
    return UserModel(
      uid: uid,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }
}
