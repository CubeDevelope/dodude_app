import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/business_logic/blocs/pages_bloc/home.bloc.dart';
import 'package:app/models/completed_action.model.dart';
import 'package:app/views/widgets/tiles/discovery_action.tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscoveryPage extends StatelessWidget {
  const DiscoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, List<CompletedAction>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return const Center(
            child: Text("Nessun action presente"),
          );
        }
        return Column(
          children: [
            Expanded(
                child: PageView(
              scrollDirection: Axis.vertical,
              children: state
                  .map((e) => DiscoveryActionTile(
                        completedAction: e,
                        onVoted: (vote) {
                          AppProvider.instance.homeCubit.votePost(e, vote);
                        },
                      ))
                  .toList(),
            )),
          ],
        );
      },
      bloc: AppProvider.instance.homeCubit,
    );
  }
}
