import 'package:app/business_logic/repositories/firebase.repository.dart';
import 'package:app/business_logic/repositories/firestore.repositories.dart';

class BaseManager {
  final FirestoreRepository firestoreRepository = FirestoreRepository();
  final FirebaseRepository firebaseRepository = FirebaseRepository();
}
