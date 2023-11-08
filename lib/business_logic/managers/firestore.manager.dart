import 'dart:io';
import 'dart:math';

import 'package:app/business_logic/managers/base_manager.dart';
import 'package:app/enums/endpoint.dart';
import 'package:app/models/action_type.model.dart';
import 'package:app/models/completed_action.model.dart';
import 'package:app/models/notification.model.dart';
import 'package:app/models/user.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreManager extends BaseManager {
  DocumentSnapshot? usernameDoc;
  Random random = Random();

  Future<UserModel?> getUserData(String uid) async {
    var docRef = firestoreRepository.getDocumentReference(uid,
        collectionsEndpoint: FirestoreCollectionsNames.user);

    var data =
        await firestoreRepository.readDocument(documentReference: docRef);

    if (data.data() == null) return null;

    return UserModel.fromDocument(data);
  }

  Future<List<CompletedAction>> getAllActions() async {
    QuerySnapshot actions =
        await firestoreRepository.getAllDocumentsFromCollection(
      collection: firestoreRepository.getCollectionReference(
        FirestoreCollectionsNames.actionFinished,
      ),
      field: "created_at",
      isGreaterThanOrEqualTo:
          Timestamp.fromDate(DateTime(DateTime.now().year - 1)),
    );

    List<CompletedAction> completedActions = [];

    for (var doc in actions.docs) {
      var action = CompletedAction.fromDocument(doc);

      if (action.creatorImage.isNotEmpty) completedActions.add(action);
    }

    completedActions.sort(
      (a, b) {
        if (a.createdAt == null || b.createdAt == null) return 0;
        return a.createdAt!.compareTo(b.createdAt!) * -1;
      },
    );

    return completedActions;
  }

  updateUserInformation(UserModel user) async {
    DocumentReference userInfoDoc = firestoreRepository.getDocumentReference(
      user.uid!,
      collectionsEndpoint: FirestoreCollectionsNames.user,
    );

    try {
      if (await firestoreRepository.docExists(userInfoDoc)) {
        _addUsername(user.username!);
        await firestoreRepository.updateDocument(
            doc: userInfoDoc, data: user.toJson());
      } else {
        await firestoreRepository.createDocument(
            documentReference: userInfoDoc, data: user.toJson());
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<DocumentSnapshot> getNotificationInfo(String uid) async {
    return await firestoreRepository.readDocument(
        documentReference: firestoreRepository.getDocumentReference(
      uid,
      collectionsEndpoint: FirestoreCollectionsNames.activeNotifications,
    ));
  }

  Future<List<NotificationModel>> getUserNotification(String uid) async {
    QuerySnapshot snap =
        await firestoreRepository.getAllDocumentsFromCollection(
      collection: firestoreRepository.getCollectionReference(
        FirestoreCollectionsNames.activeNotifications,
      ),
      field: "recipient",
      isEqualTo: firestoreRepository.getDocumentReference(uid,
          collectionsEndpoint: FirestoreCollectionsNames.user),
    );

    List<NotificationModel> notifications =
        snap.docs.map((e) => NotificationModel.fromDocument(e)).toList();
    notifications.sort(
      (a, b) {
        return a.createdAt!.compareTo(b.createdAt!);
      },
    );

    return notifications;
  }

  Stream<QuerySnapshot> getUserNotificationSnapshot(String uid) {
    return firestoreRepository.getAllDocumentFromCollectionSnapshot(
      collection: firestoreRepository.getCollectionReference(
        FirestoreCollectionsNames.activeNotifications,
      ),
      field: "recipient",
      isEqualTo: firestoreRepository.getDocumentReference(uid,
          collectionsEndpoint: FirestoreCollectionsNames.user),
    );
  }

  voteAction(
    CompletedAction post,
  ) {
    firestoreRepository.updateDocument(
      doc: firestoreRepository.getDocumentReference(post.uid!,
          collectionsEndpoint: FirestoreCollectionsNames.actionFinished),
      data: post.toJson(),
    );
  }

  Stream<DocumentSnapshot<Object?>> getCompletedActionSnapshot(
      CompletedAction action) {
    return firestoreRepository.getDocumentSnapshot(
        documentReference: firestoreRepository.getDocumentReference(action.uid!,
            collectionsEndpoint: FirestoreCollectionsNames.actionFinished));
  }

  uploadImage(File file) {
    firestoreRepository.uploadFile(file);
  }

  _getUsernameDocReference() {
    return firestoreRepository.getDocumentReference("m9DcVqOYrzsPJ8yrrB4j",
        collectionsEndpoint: FirestoreCollectionsNames.adminStuff);
  }

  _getUsernamesDoc() async {
    if (usernameDoc == null) {
      DocumentReference doc = _getUsernameDocReference();

      usernameDoc =
          await firestoreRepository.readDocument(documentReference: doc);
    }
    return usernameDoc;
  }

  Future<List<String>> _getUsernamesList() async {
    DocumentSnapshot docSnap = await _getUsernamesDoc();
    Map<String, dynamic> data = docSnap.data.call() as Map<String, dynamic>;
    List<String> usernames = (data["taken_usernames"] as List)
        .map((e) => e.toString().toLowerCase())
        .toList();

    return usernames;
  }

  _addUsername(String username) async {
    List<String> usernamesList = await _getUsernamesList();
    usernamesList.add(username);
    Map<String, dynamic> usernameDocMap = {
      "taken_usernames": usernamesList,
    };

    firestoreRepository.updateDocument(
        doc: _getUsernameDocReference(), data: usernameDocMap);
  }

  checkUsername(String username) async {
    List<String> usernames = await _getUsernamesList();
    return !usernames.contains(username.toLowerCase());
  }

  getThreeActions() async {
    List<ActionType> actions = [];
    QuerySnapshot docs =
        await firestoreRepository.getAllDocumentsFromCollection(
      collection: firestoreRepository
          .getCollectionReference(FirestoreCollectionsNames.actionType),
    );

    for (int i = 0; i < 12; i++) {
      DocumentSnapshot snap = docs.docs.elementAt(random.nextInt(docs.size));
      actions.add(ActionType.fromDocument(snap));
    }

    return actions;
  }

  deleteUser() {}

  // Actions

  createNewAction(CompletedAction action) async {
    firestoreRepository
        .createDocument(
            collectionReference: firestoreRepository.getCollectionReference(
                FirestoreCollectionsNames.actionFinished),
            data: action.toJson())
        .then((value) => print(value));
  }

  // Streams Snapshot

  Stream<DocumentSnapshot> getUserInformation(String userId) {
    return firestoreRepository.getDocumentSnapshot(
        documentReference: firestoreRepository.getDocumentReference(userId,
            collectionsEndpoint: FirestoreCollectionsNames.user));
  }

  Stream<QuerySnapshot> getUserActions(String userId) {
    return firestoreRepository.getAllDocumentFromCollectionSnapshot(
      collection: firestoreRepository
          .getCollectionReference(FirestoreCollectionsNames.actionFinished),
      field: "created_by",
      isEqualTo: firestoreRepository.getDocumentReference(userId,
          collectionsEndpoint: FirestoreCollectionsNames.user),
    );
  }
}
