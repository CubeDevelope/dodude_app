sealed class LoginState {}


class WaitingOTPCodeState extends LoginState {}

class CompleteLoginState extends LoginState {}
