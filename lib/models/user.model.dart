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
  static String actionPinnedKey = "action_pinned";
  static String photoUrlKey = "photo_url";
  static String bioKey = "bio";
  static String karmaPointKey = "karma_point";

  String? name;
  String? surname;
  String? username;
  String? phoneNumber;
  String? email;
  String? bio;
  List<DocumentReference>? friends;
  List<DocumentReference>? activeNotifications;
  List<DocumentReference>? actionFinishedReviewed;
  List<DocumentReference>? actionPinned;
  String? photoUrl;
  int karmaPoint;

  UserModel({
    String? uid,
    this.name,
    this.surname,
    this.username,
    this.phoneNumber = "",
    this.email = "",
    this.activeNotifications,
    this.actionFinishedReviewed,
    this.actionPinned,
    this.photoUrl = "",
    this.friends,
    this.bio = "",
    this.karmaPoint = 0,
  }) : super(uid);

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
      actionPinned: map.containsKey(actionPinnedKey)
          ? (map[actionPinnedKey] as List)
          .map((e) => e as DocumentReference)
          .toList()
          : [],
      photoUrl: map[photoUrlKey],
      karmaPoint: map[karmaPointKey] ?? 0,
      bio: map[bioKey],
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
      bioKey: bio,
      karmaPointKey : karmaPoint
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
    return toJson().toString();
  }
}
