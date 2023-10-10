import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/business_logic/managers/firestore.manager.dart';
import 'package:app/models/completed_action.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<List<CompletedAction>> {
  HomeCubit() : super([]);

  getAllActions() async {
    List<CompletedAction> completedActions =
        await FirestoreManager().getAllActions();

    emit(completedActions);
  }

  votePost(CompletedAction action, bool isPositive) {

    CompletedAction updateAction;
    if (isPositive) {
      updateAction = action.copyWith(
        angelsPositive: [...action.angelsPositive ?? [], AppProvider.instance.userDocReference]
      );
    } else {
      updateAction = action.copyWith(
          angelsNegative: [...action.angelsNegative ?? [], AppProvider.instance.userDocReference]
      );
    }

    AppProvider.instance.firestoreManager.voteAction(updateAction);
  }
}
