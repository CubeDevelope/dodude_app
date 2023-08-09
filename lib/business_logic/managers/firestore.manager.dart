import 'package:app/business_logic/managers/base_manager.dart';
import 'package:app/business_logic/repositories/firestore.repositories.dart';
import 'package:app/models/user.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreManager extends BaseManager {
  static final FirestoreManager _instance = FirestoreManager._();

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
    DocumentReference doc = firestoreRepository.getDocument(user.uid!,
        collectionsEndpoint: FirestoreCollectionsEndpoints.user);

    try {
      if (await firestoreRepository.docExists(doc)) {
        await firestoreRepository.updateDocument(doc: doc, data: user.toJson());
      } else {
        await firestoreRepository.createDocument(doc: doc, data: user.toJson());
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}
