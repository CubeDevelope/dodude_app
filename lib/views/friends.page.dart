import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/business_logic/blocs/pages_bloc/home.bloc.dart';
import 'package:app/models/completed_action.model.dart';
import 'package:app/views/widgets/tiles/discovery_action.tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, List<CompletedAction>>(
      bloc: AppProvider.instance.homeCubit,
      builder: (context, state) {
        List<CompletedAction> friendCompleteAction = state.where((element) {
          return AppProvider.instance.currentUser.friends != null &&
              AppProvider.instance.currentUser.friends!
                  .contains(element.createdBy);
        }).toList();

        if (friendCompleteAction.isNotEmpty) {
          return PageView.builder(
            itemBuilder: (context, index) {
              return DiscoveryActionTile(
                  completedAction: friendCompleteAction.elementAt(index));
            },
            itemCount: friendCompleteAction.length,
          );
        }
        return const Center(
          child: Text("Nessun contenuto"),
        );
      },
    );
  }
}
