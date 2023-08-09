import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/business_logic/blocs/states/auth.state.dart';
import 'package:app/business_logic/managers/firestore.manager.dart';
import 'package:app/business_logic/repositories/auth_repository.dart';
import 'package:app/models/user.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum TypeOfLogin { phone, email }

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository = AuthRepository();
  final FirestoreManager _firestoreManager = FirestoreManager();

  static final AuthCubit _instance = AuthCubit._();

  AuthCubit._() : super(InitializationState());

  TypeOfLogin type = TypeOfLogin.phone;
  UserCredential? userCredential;
  AppProvider appProvider = AppProvider.instance;
  UserModel? user;

  static AuthCubit get instance => _instance;

  _setCurrentUser() async {
    user =
        await FirestoreManager().getUserData(_authRepository.currentUser!.uid);

    if (user == null) {
      addInformation();
    } else {
      authenticate();
    }
  }

  initApp() async {
    await _authRepository.initApp();
    if (_authRepository.isLogged) {
      _setCurrentUser();
    } else {
      emit(UnsignedState());
    }
  }

  login(String number, {Function(FirebaseAuthException error)? onError}) {
    switch (type) {
      case TypeOfLogin.phone:
        _authRepository.loginByPhone(
          "+39$number",
          codeSent: (verificationId) {
            emit(ConfirmOTPState(
              verificationId,
            ));
          },
          onError: onError,
        );
        break;
      case TypeOfLogin.email:
        _authRepository.loginByEmail();
        break;
      default:
    }
  }

  confirmOTP(String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: (state as ConfirmOTPState).verificationId,
      smsCode: smsCode,
    );

    userCredential = await _authRepository.loginWithCredential(credential);
    if (userCredential != null) {
      _setCurrentUser();
    } else {
      emit(UnsignedState());
    }
  }

  addInformation() {
    user = UserModel();
    user?.uid = _authRepository.currentUser?.uid;
    user?.email = _authRepository.currentUser?.email;
    emit(AddPersonalInformationState());
  }

  Future<bool> updateUserData({
    required String userName,
    String name = "",
    String surname = "",
  }) async {
    user?.name = name;
    user?.surname = surname;
    user?.username = userName;
    user?.phoneNumber = _authRepository.currentUser?.phoneNumber;

    if (await _firestoreManager.updateUserInformation(user!)) {
      authenticate();
      return true;
    } else {
      return false;
    }
  }

  authenticate() {
    user?.phoneNumber ??= _authRepository.currentUser?.phoneNumber;

    appProvider.currentUser = user!;
    emit(AuthenticatedState());
  }

  logout() {
    userCredential = null;
    _authRepository.logout();
    emit(UnsignedState());
  }
}

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {}
