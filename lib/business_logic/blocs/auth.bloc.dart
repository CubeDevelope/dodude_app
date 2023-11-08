import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/business_logic/blocs/states/auth.state.dart';
import 'package:app/business_logic/blocs/user.bloc.dart';
import 'package:app/business_logic/managers/firestore.manager.dart';
import 'package:app/business_logic/repositories/auth.repository.dart';
import 'package:app/models/user.model.dart';
import 'package:app/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum TypeOfLogin { phone, email }

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository = AuthRepository();
  final FirestoreManager _firestoreManager = FirestoreManager();

  AuthCubit() : super(InitializationState());

  TypeOfLogin type = TypeOfLogin.phone;
  UserCredential? userCredential;
  PhoneAuthCredential? phoneAuthCredential;
  UserModel? user;

  _setCurrentUser() async {
    user =
        await _firestoreManager.getUserData(_authRepository.currentUser!.uid);

    if (user == null) {
      addInformationState();
    } else {
      await AppProvider.instance.syncActions();
      authenticateState();
    }
  }

  initApp() async {
    emit(LoadingState(message: "Sto controllando l'accesso sul server"));
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
    phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: (state as ConfirmOTPState).verificationId,
      smsCode: smsCode,
    );

    userCredential =
        await _authRepository.loginWithCredential(phoneAuthCredential!);
    if (userCredential != null) {
      _setCurrentUser();
    } else {
      emit(UnsignedState());
    }
  }

  addInformationState() {
    user = UserModel();
    user?.uid = _authRepository.currentUser?.uid;
    user?.email = _authRepository.currentUser?.email;
    emit(AddPersonalInformationState());
  }

  checkUsername(String userName) async {
    return await _firestoreManager.checkUsername(userName);
  }

  Future<bool> addInformationToDB({
    required String userName,
    String name = "",
    String surname = "",
  }) async {
    user?.name = name;
    user?.surname = surname;
    user?.username = userName;
    user?.phoneNumber = _authRepository.currentUser?.phoneNumber;

    if (await _firestoreManager.updateUserInformation(user!)) {
      authenticateState();
      return true;
    } else {
      return false;
    }
  }

  authenticateState() {
    user?.phoneNumber ??= _authRepository.currentUser?.phoneNumber;
    Keys.masterNavigator.currentContext?.read<UserBloc>().login(user!);
    AppProvider.instance.currentUser = user!;
    AppProvider.instance.getNotification();
    emit(AuthenticatedState());
  }

  logout() {
    userCredential = null;
    _authRepository.logout();
    emit(UnsignedState());
  }

  deleteUser() async {
    emit(LoadingState());
    await _authRepository.reauthenticateWithCredential(phoneAuthCredential!);
    await _authRepository.deleteUser();
    emit(UnsignedState());
  }
}

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {}
