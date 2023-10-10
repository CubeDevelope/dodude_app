
sealed class ErrorState {}

class InvalidPhoneNumberErrorState extends ErrorState {}

class TooManyRequestErrorState extends ErrorState {}

class NoErrorState extends ErrorState {

}