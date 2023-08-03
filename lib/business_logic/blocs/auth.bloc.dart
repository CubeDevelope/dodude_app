import 'package:app/business_logic/blocs/states/auth.state.dart';
import 'package:app/business_logic/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum TypeOfLogin { phone, email }

class AuthBloc extends Cubit<AuthState> {
  final AuthRepository _authRepository = AuthRepository();

  TypeOfLogin type = TypeOfLogin.phone;
  UserCredential? userCredential;

  AuthBloc() : super(InitializationState());

  initApp() async {
    await _authRepository.initApp();
    emit(UnsignedState());
  }

  login(String number,
      { Function(FirebaseAuthException error)? onError}) {
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

  loginWithSmsCode(String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: (state as ConfirmOTPState).verificationId,
      smsCode: smsCode,
    );

    userCredential = await _authRepository.loginWithCredential(credential);
    if (userCredential != null) {
      emit(AuthenticatedState());
    } else {
      emit(UnsignedState());
    }
  }

  signUp() {}

  logout() {
    userCredential = null;
    _authRepository.logout();
    emit(UnsignedState());
  }
}

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {}
