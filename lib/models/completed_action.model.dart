import 'package:app/models/base.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompletedAction extends Model {
  static String actionTitleKey = "action_title";
  static String actionDescriptionKey = "action_description";
  static String totalViewsKey = "total_views";
  static String angelsNegativeKey = "angels_negative";
  static String angelsPositiveKey = "angels_positive";
  static String actionImageKey = "action_image";
  static String createdByKey = "created_by";
  static String creatorImageKey = "creator_image";
  static String creatorUsernameKey = "creator_username";
  static String createdAtKey = "created_at";
  static String actionKey = "action";

  CompletedAction({
    String uid = "",
    this.actionDescription = "",
    this.actionTitle = "",
    this.totalViews = 0,
    this.actionImage = "",
    this.angelsNegative,
    this.angelsPositive,
    this.creatorImage = "",
    this.creatorUsername = "",
    this.createdBy,
    this.createdAt,
    this.action,
  }) : super(uid);

  String actionDescription;
  String actionTitle;
  String creatorImage;
  String actionImage;
  int totalViews;
  List<DocumentReference>? angelsNegative;
  List<DocumentReference>? angelsPositive;
  DocumentReference? createdBy;
  String creatorUsername;
  Timestamp? createdAt;
  DocumentReference? action;

  factory CompletedAction.fromJson(Map<String, dynamic> json) {
    var completeAction = CompletedAction(
        actionDescription: json[actionDescriptionKey] ?? "",
        actionTitle: json[actionTitleKey] ?? "Nessun titolo",
        actionImage: json[actionImageKey] ?? "",
        totalViews: json[totalViewsKey] ?? 0,
        creatorImage: json[creatorImageKey] ?? "",
        angelsNegative: json.containsKey(angelsNegativeKey)
            ? (json[angelsNegativeKey] as List).cast<DocumentReference>()
            : [],
        angelsPositive: json.containsKey(angelsPositiveKey)
            ? (json[angelsPositiveKey] as List).cast<DocumentReference>()
            : [],
        creatorUsername: json[creatorUsernameKey] ?? "Non presente",
        createdAt: json[createdAtKey] ?? Timestamp.now(),
        createdBy: json[createdByKey],
        action: json[actionKey]);

    return completeAction;
  }

  factory CompletedAction.fromDocument(DocumentSnapshot document) {
    var completeAction =
        CompletedAction.fromJson(document.data() as Map<String, dynamic>);

    completeAction.uid = document.id;

    return completeAction;
  }

  Map<String, dynamic> toUpdateAngels() {
    return {
      angelsPositiveKey: angelsPositive,
      angelsNegativeKey: angelsNegative,
    };
  }

  CompletedAction copyWith({
    List<DocumentReference>? angelsPositive,
    List<DocumentReference>? angelsNegative,
    DocumentReference? action,
  }) {
    return CompletedAction(
        uid: uid!,
        createdBy: createdBy,
        createdAt: createdAt,
        angelsPositive: angelsPositive ?? this.angelsPositive,
        angelsNegative: angelsNegative ?? this.angelsNegative,
        totalViews: totalViews,
        actionTitle: actionTitle,
        actionDescription: actionDescription,
        actionImage: actionImage,
        creatorImage: creatorImage,
        creatorUsername: creatorUsername,
        action: action ?? this.action);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      actionTitleKey: actionTitle,
      actionDescriptionKey: actionDescription,
      angelsPositiveKey: angelsPositive ?? [],
      angelsNegativeKey: angelsNegative ?? [],
      createdByKey: createdBy,
      actionKey: action,
      actionImageKey: actionImage,
      createdAtKey: createdAt,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
