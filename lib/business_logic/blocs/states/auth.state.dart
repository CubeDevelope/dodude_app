sealed class AuthState {}

class UnsignedState extends AuthState {}

class InitializationState extends AuthState {}

class ConfirmOTPState extends AuthState {
  String verificationId = "";

  ConfirmOTPState(this.verificationId);
}

class AddPersonalInformationState extends AuthState {}

class AuthenticatedState extends AuthState {}
