import 'package:app/business_logic/blocs/events/error.event.dart';
import 'package:app/business_logic/blocs/states/error.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorHandlerBloc extends Bloc<ErrorEvent, ErrorState> {
  ErrorHandlerBloc() : super(NoErrorState()) {
    on<TooManyRequestErrorEvent>(
      (event, emit) => emit(
        TooManyRequestErrorState(),
      ),
    );
  }
}
