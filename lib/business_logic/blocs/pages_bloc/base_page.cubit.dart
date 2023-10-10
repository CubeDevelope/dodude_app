import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BasePageCubit<T> extends Cubit<T?> {
  BasePageCubit(super.initialState, this.appProvider);

  final AppProvider appProvider;
}
