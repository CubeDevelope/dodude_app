sealed class AuthState {}

class UnsignedState extends AuthState {}

class InitializationState extends AuthState {}

class ConfirmOTPState extends AuthState {
  String verificationId = "";

  ConfirmOTPState(this.verificationId);
}

class AddPersonalInformationState extends AuthState {}

class LoadingState extends AuthState {
  String message;

  LoadingState({this.message = "Caricamento"});
}

class AuthenticatedState extends AuthState {}
