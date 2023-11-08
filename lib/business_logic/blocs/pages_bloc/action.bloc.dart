import 'dart:io';

import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/models/action_type.model.dart';
import 'package:app/models/completed_action.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionCubit extends Cubit<List<ActionType>> {
  ActionCubit() : super([]);

  ActionType? actionTypeSelected;

  getThreeActions() async {
    emit([]);
    List<ActionType> type =
        await AppProvider.instance.firestoreManager.getThreeActions();
    emit(type);
  }

  loadImageInStorage(File file) {
    AppProvider.instance.firestoreManager.uploadImage(file);
  }

  createNewAction(CompletedAction action) {
    AppProvider.instance.firestoreManager.createNewAction(action);
  }
}
