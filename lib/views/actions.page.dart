import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/business_logic/blocs/pages_bloc/action.bloc.dart';
import 'package:app/models/action_type.model.dart';
import 'package:app/views/widgets/tiles/new_action.tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionsPage extends StatefulWidget {
  const ActionsPage({super.key});

  @override
  State<ActionsPage> createState() => _ActionsPageState();
}

class _ActionsPageState extends State<ActionsPage> {
  int currentTryOfActions = 0;

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _buildPage(List<ActionType> state) {
    if (currentTryOfActions != 4) {
      return [
        ...state
            .sublist(3 * currentTryOfActions, (currentTryOfActions + 1) * 3)
            .map<Widget>(
              (e) => NewActionTile(
                actionType: e,
                onTap: () {},
              ),
            )
            .toList(),
        Visibility(
          visible: currentTryOfActions != 3,
          child: FloatingActionButton(
              onPressed: () {
                if (currentTryOfActions < 3) {
                  setState(() {
                    currentTryOfActions++;
                  });
                }
              },
              child: const Icon(Icons.shuffle)),
        )
      ];
    } else {
      return [
        Container(),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuova azione"),
        actions: [
          IconButton(
              onPressed: () {
                AppProvider.instance.actionCubit.getThreeActions();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: BlocBuilder<ActionCubit, List<ActionType>>(
        builder: (context, state) {
          if (state.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                ..._buildPage(state),
              ],
            );
          }
        },
        bloc: AppProvider.instance.actionCubit,
      ),
    );
  }
}
