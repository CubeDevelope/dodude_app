import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

enum FirebaseEndpoints {
  getUserByID,
}

enum FirestoreCollectionsEndpoints { user }

extension EndpointsExt on FirebaseEndpoints {
  String get toShortString => toString().split('.').last;
}

extension FirestoreCollectionsExt on FirestoreCollectionsEndpoints {
  String get toShortString => toString().split('.').last;
}

class FirestoreRepository {
  httpsCallable(FirebaseEndpoints endpoint, {dynamic data}) async {
    var result = await FirebaseFunctions.instance
        .httpsCallable(endpoint.toShortString)
        .call(data);
    return result.data;
  }

  DocumentReference getDocument(String uid,
      {CollectionReference? collection,
      FirestoreCollectionsEndpoints? collectionsEndpoint}) {
    assert(collection != null || collectionsEndpoint != null,
        "collection or collectionEndpoint must be not null");

    CollectionReference collectionReference =
        collection ?? getCollection(collectionsEndpoint!);

    return collectionReference.doc(uid);
  }

  CollectionReference getCollection(FirestoreCollectionsEndpoints collection) {
    return FirebaseFirestore.instance.collection(collection.toShortString);
  }

  Future<bool> docExists(DocumentReference doc) async {
    var docRef = await doc.get();
    return docRef.exists;
  }

  updateDocument({
    required DocumentReference doc,
    required Map<String, dynamic> data,
  }) async {
    return await doc.update(data);
  }

  createDocument({
    required DocumentReference doc,
    required Map<String, dynamic> data,
  }) async {
    return await doc.set(data);

  }
}
