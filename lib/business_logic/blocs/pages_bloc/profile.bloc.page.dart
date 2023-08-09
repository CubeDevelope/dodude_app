import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/models/user.model.dart';

class ProfileBloc {
  final AppProvider _appProvider = AppProvider.instance;

  UserModel get currentUser => _appProvider.currentUser;
}
