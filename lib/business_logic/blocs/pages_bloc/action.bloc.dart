import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/models/action_type.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionCubit extends Cubit<List<ActionType>> {
  ActionCubit() : super([]);

  getThreeActions() async {
    emit([]);
    List<ActionType> type =
        await AppProvider.instance.firestoreManager.getThreeActions();
    emit(type);
  }
}
