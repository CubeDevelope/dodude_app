import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/models/user.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Cubit<UserModel?> {
  UserBloc() : super(null);

  login(UserModel model) {
    emit(model);
    _userListener();
  }

  _userListener() {
    AppProvider.instance.firestoreManager
        .getUserInformation(state!.uid!)
        .listen((event) {
      emit(UserModel.fromDocument(event));
    });
  }
}
