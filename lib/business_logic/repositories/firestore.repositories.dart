import 'package:app/enums/endpoint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  DocumentReference getDocumentReference(
      String documentId, FirestoreCollectionsNames collectionsEndpoint) {
    CollectionReference collectionReference =
        getCollectionReference(collectionsEndpoint);

    return collectionReference.doc(documentId);
  }

  CollectionReference getCollectionReference(
      FirestoreCollectionsNames collectionsName) {
    return FirebaseFirestore.instance.collection(collectionsName.toShortString);
  }

  Future<bool> docExists(DocumentReference documentReference) async {
    var docRef = await documentReference.get();
    return docRef.exists;
  }

  getAllDocumentsFromCollection(
      {required CollectionReference collection,
      int limit = 100,
      String? field,
      Object? isLessThanOrEqualTo,
      Object? isGreaterThanOrEqualTo,
      Object? isEqualTo}) async {
    Query queryCollection = collection.limit(limit);
    if (field != null) {
      queryCollection = queryCollection.where(
        field,
        isEqualTo: isEqualTo,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
      );
    }
    return await queryCollection.get();
  }

  getAllDocumentFromCollectionSnapshot(
      {required CollectionReference collection,
      String? field,
      Object? isEqualTo}) {
    Query queryCollection = collection.limit(10);
    if (field != null) {
      queryCollection = queryCollection.where(field, isEqualTo: isEqualTo);
    }
    return queryCollection.snapshots();
  }

  Stream<DocumentSnapshot<Object?>> getDocumentSnapshot({
    required DocumentReference documentReference,
  }) {
    return documentReference.snapshots();
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

  Future<DocumentSnapshot> readDocument({
    required DocumentReference documentReference,
  }) async {
    return await documentReference.get();
  }
}
