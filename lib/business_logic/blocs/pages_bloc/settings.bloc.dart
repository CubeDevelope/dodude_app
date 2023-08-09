import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/business_logic/blocs/auth.bloc.dart';
import 'package:app/models/user.model.dart';

class SettingsBloc {
  final AppProvider _appProvider = AppProvider.instance;

  logout() {
    _appProvider.currentUser = UserModel();

    AuthCubit.instance.logout();
  }
}
