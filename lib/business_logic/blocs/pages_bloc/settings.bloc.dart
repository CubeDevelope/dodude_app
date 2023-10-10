import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/models/user.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingCubit extends Cubit {
  logout() {
    AppProvider.instance.currentUser = UserModel();
    AppProvider.instance.authCubit.logout();
  }

  SettingCubit() : super(null);
}
