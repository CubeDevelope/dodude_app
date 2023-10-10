import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class AuthRepository extends ChangeNotifier {
  FirebaseAuth? _auth;

  initApp() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
  }

  bool get isLogged => _auth?.currentUser != null;

  User? get currentUser => _auth?.currentUser;

  void loginByPhone(String number,
      {Function(String verificationId)? codeSent,
      Function(FirebaseAuthException error)? onError}) async {
    await _auth?.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {
        onError?.call(error);
      },
      codeSent: (verificationId, forceResendingToken) async {
        codeSent?.call(verificationId);
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  Future<UserCredential?> loginWithCredential(
      PhoneAuthCredential credential) async {
    return _auth?.signInWithCredential(credential);
  }

  void loginByEmail() async {}

  bool signUp() {
    return false;
  }

  void logout() async {
    await _auth?.signOut();
  }

  reauthenticateWithCredential(AuthCredential credential) async {
    await _auth?.currentUser?.reauthenticateWithCredential(credential);
  }


  deleteUser() async {
    await _auth?.currentUser?.delete();
  }
}
