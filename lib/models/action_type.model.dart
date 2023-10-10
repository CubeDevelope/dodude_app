import 'package:cloud_firestore/cloud_firestore.dart';

class ActionType {
  static String actionContextKey = "action_cotnext";
  static String actionCreatorSponsorKey = "action_creator_sponsor";
  static String actionCultureKey = "action_culture";
  static String actionDescriptionKey = "action_description";
  static String actionIdKey = "action_id";
  static String actionInfoKey = "action_info";
  static String actionMoodKey = "action_mood";
  static String actionTitleKey = "action_title";

  String actionContext;
  String actionCreatorSponsor;
  String actionCulture;
  String actionDescription;
  int actionId;
  String actionInfo;
  String actionMood;
  String actionTitle;

  factory ActionType.fromJson(Map<String, dynamic> map) {
    return ActionType(
      actionDescription: map[actionDescriptionKey] ?? "",
      actionCreatorSponsor: map[actionCreatorSponsorKey] ?? "",
      actionTitle: map[actionTitleKey] ?? "",
      actionContext: map[actionContextKey] ?? "",
      actionCulture: map[actionCultureKey] ?? "",
      actionId: map[actionIdKey] ?? 0,
      actionInfo: map[actionInfoKey] ?? "",
      actionMood: map[actionMoodKey] ?? "",
    );
  }

  factory ActionType.fromDocument(DocumentSnapshot document) {
    return ActionType.fromJson(document.data() as Map<String, dynamic>);
  }

  ActionType({
    this.actionDescription = "",
    this.actionTitle = "",
    this.actionContext = "",
    this.actionCreatorSponsor = "",
    this.actionCulture = "",
    this.actionId = 0,
    this.actionInfo = "",
    this.actionMood = "",
  });
}
