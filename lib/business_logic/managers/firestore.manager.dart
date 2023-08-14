import 'package:app/business_logic/managers/base_manager.dart';
import 'package:app/business_logic/repositories/firestore.repositories.dart';
import 'package:app/models/user.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreManager extends BaseManager {
  static final FirestoreManager _instance = FirestoreManager._();

  DocumentSnapshot? usernameDoc;

  FirestoreManager() {
    _instance;
  }

  FirestoreManager._();

  Future<UserModel?> getUserData(String uid) async {
    Map<String, dynamic>? result = await firestoreRepository
        .httpsCallable(FirebaseEndpoints.getUserByID, data: <String, dynamic>{
      "userID": uid,
    });
    if (result != null) return UserModel.fromJson(result);
    return null;
  }

  updateUserInformation(UserModel user) async {
    DocumentReference userInfoDoc = firestoreRepository.getDocument(
      user.uid!,
      collectionsEndpoint: FirestoreCollectionsEndpoints.user,
    );

    try {
      if (await firestoreRepository.docExists(userInfoDoc)) {
        _addUsername(user.username!);
        await firestoreRepository.updateDocument(
            doc: userInfoDoc, data: user.toJson());
      } else {
        await firestoreRepository.createDocument(
            doc: userInfoDoc, data: user.toJson());
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  _getUsernameDocReference() {
    return firestoreRepository.getDocument("m9DcVqOYrzsPJ8yrrB4j",
        collectionsEndpoint: FirestoreCollectionsEndpoints.adminStuff);
  }

  _getUsernamesDoc() async {
    if (usernameDoc == null) {
      DocumentReference doc = _getUsernameDocReference();

      usernameDoc = await firestoreRepository.readDocument(doc: doc);
    }
    return usernameDoc;
  }

  Future<List<String>> _getUsernamesList() async {
    DocumentSnapshot docSnap = await _getUsernamesDoc();
    Map<String, dynamic> data = docSnap.data.call() as Map<String, dynamic>;
    List<String> usernames =
        (data["taken_usernames"] as List).map((e) => e.toString().toLowerCase()).toList();

    print(usernames.first);
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

  deleteUser() {}
}
