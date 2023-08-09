import 'package:app/business_logic/repositories/firestore.repositories.dart';
import 'package:app/business_logic/repositories/network_repository.dart';
import 'package:app/models/user.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BaseManager {
  final FirestoreRepository firestoreRepository = FirestoreRepository();

}
