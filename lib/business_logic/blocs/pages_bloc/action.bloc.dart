import 'dart:io';
import 'dart:math';

import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/business_logic/blocs/user.bloc.dart';
import 'package:app/models/action_type.model.dart';
import 'package:app/models/completed_action.model.dart';
import 'package:app/utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionCubit extends Cubit<List<ActionType>> {
  ActionCubit() : super([]);

  Random random = Random();

  ActionType? actionTypeSelected;

  getThreeActions() async {
    emit([]);
    List<ActionType> type =
        await AppProvider.instance.firestoreManager.getThreeActions();
    emit(type);
  }

  loadImageInStorage(
      File file, String filename, Function(TaskSnapshot) callback) async {
    Reference reference = Keys.masterNavigator.currentContext!
        .read<UserBloc>()
        .state
        .storageUserRef
        .child("$filename.jpg");
    TaskSnapshot upload = await AppProvider.instance.firestoreManager
        .uploadActionImage(file, reference);
    callback.call(upload);
  }

  createNewAction(CompletedAction action, File file) async {
    String filename = "";
    for (int i = 0; i < 16; i++) {
      filename += (random.nextInt(8) + 1).toString();
    }

    loadImageInStorage(file, filename, (upload) async {
      String path = await upload.ref.getDownloadURL();
      action.actionImage = path;
      AppProvider.instance.firestoreManager.createNewAction(action);
    });
  }
}
