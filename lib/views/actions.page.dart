import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/business_logic/blocs/pages_bloc/action.bloc.dart';
import 'package:app/models/action_type.model.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/router.dart';
import 'package:app/views/widgets/doduce_button.dart';
import 'package:app/views/widgets/tiles/new_action.tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionsPage extends StatefulWidget {
  const ActionsPage({super.key});

  @override
  State<ActionsPage> createState() => _ActionsPageState();
}

class _ActionsPageState extends State<ActionsPage> {
  int currentTryOfActions = 0;

  List<Widget> buildActionTiles(List<ActionType> state) {
    List<Widget> tiles = [];
    state
        .sublist(currentTryOfActions, currentTryOfActions + 3)
        .indexed
        .forEach((element) {
      if (element.$1 != currentTryOfActions + 2) {
        tiles.addAll([
          Expanded(
            child: NewActionTile(
              onTap: () {
                AppProvider.instance.actionCubit.actionTypeSelected = element.$2;
                Keys.masterNavigator.currentState
                    ?.pushNamed(MasterPages.createAction.toPath);
              },
              actionType: element.$2,
              direction:
                  element.$1 % 2 == 0 ? TextDirection.ltr : TextDirection.rtl,
            ),
          ),
          const SizedBox(
            height: 16,
          )
        ]);
      } else {
        tiles.add(
          Expanded(
              child: NewActionTile(
            actionType: element.$2,
            direction:
                element.$1 % 2 == 0 ? TextDirection.ltr : TextDirection.rtl,
          )),
        );
      }
    });
    return tiles;
  }

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _buildPage(List<ActionType> state) {
    if (currentTryOfActions >= 3) {
      return [
        Expanded(
          child: SvgPicture.asset(
            AppIcons.pasta.toAssetPath,
            width: 100,
            height: 100,
          ),
        ),
      ];
    }
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: currentTryOfActions != 0,
            child: DodudeButton(
              onTap: () {
                setState(() {
                  currentTryOfActions--;
                });
              },
              icon: AppIcons.back,
              margin: const EdgeInsets.only(right: 16),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DodudeButton(
                hasProcess: true,
                process: currentTryOfActions,
                icon: AppIcons.shuffle,
                onTap: () {
                  setState(() {
                    currentTryOfActions++;
                  });
                },
              ),
            ],
          )
        ],
      ),
      Expanded(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: buildActionTiles(state),
        ),
      ))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActionCubit, List<ActionType>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                ..._buildPage(state),
              ],
            ),
          );
        }
      },
      bloc: AppProvider.instance.actionCubit,
    );
  }
}
