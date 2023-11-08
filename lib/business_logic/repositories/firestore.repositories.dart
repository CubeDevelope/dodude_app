import 'dart:io';

import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/enums/endpoint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreRepository {

  DocumentReference getDocumentReference(String documentId,
      {FirestoreCollectionsNames? collectionsEndpoint,
      CollectionReference? collectionReference}) {
    assert(collectionReference != null || collectionsEndpoint != null);
    if (collectionsEndpoint != null) {
      CollectionReference collectionRef =
          getCollectionReference(collectionsEndpoint);

      return collectionRef.doc(documentId);
    } else {
      return collectionReference!.doc(documentId);
    }
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

  Future<dynamic> createDocument({
    CollectionReference? collectionReference,
    DocumentReference? documentReference,
    required Map<String, dynamic> data,
  }) async {
    assert(documentReference != null || collectionReference != null);

    if (documentReference != null) return await documentReference.set(data);

    return await collectionReference!.add(data);
  }

  Future<DocumentSnapshot> readDocument({
    required DocumentReference documentReference,
  }) async {
    return await documentReference.get();
  }

  // Upload file

  uploadFile(File file) async {
    final ref = FirebaseStorage.instance.ref();
    final bucketReference =
        ref.child("user").child("${AppProvider.instance.currentUser.uid!}.jpg");
    bucketReference.putFile(file);
    //bucketReference.putFile(file);
  }
}
