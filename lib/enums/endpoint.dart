enum FirebaseFunctionEndpoints {
  getUserByID,
  getThreeLittleActions,
  getAllActions,
}

enum FirestoreCollectionsNames {
  user,
  adminStuff,
  actionFinished,
  activeNotifications,
  actionType
}

extension EndpointsExt on FirebaseFunctionEndpoints {
  String get toShortString => toString().split('.').last;
}

extension FirestoreCollectionsExt on FirestoreCollectionsNames {
  String get toShortString {
    String shortString = toString().split('.').last;
    switch (this) {
      case FirestoreCollectionsNames.adminStuff:
        shortString = "admin_stuff";
        break;
      case FirestoreCollectionsNames.actionFinished:
        shortString = "action_finished";
        break;
      case FirestoreCollectionsNames.activeNotifications:
        shortString = "notification";
        break;
      case FirestoreCollectionsNames.actionType:
        shortString = "action_type";
        break;
      default:
    }
    return shortString;
  }
}
