import 'package:app/business_logic/blocs/pages_bloc/profile.bloc.page.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/router.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileBloc _bloc = ProfileBloc();

  @override
  Widget build(BuildContext context) {
    print(_bloc.currentUser.toJson());

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  Keys.masterNavigator.currentState
                      ?.pushNamed(MasterPages.settings.toPath);
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        Expanded(
          child: Column(
            children: [
              Text(_bloc.currentUser.username ?? ""),
              Text(_bloc.currentUser.fullName),
              Expanded(
                  child: GridView.count(
                crossAxisCount: 3,
                children: [],
              )),
            ],
          ),
        )
      ],
    );
  }
}
