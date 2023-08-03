import 'package:app/utils/constants.dart';
import 'package:app/utils/router.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [IconButton(onPressed: () {
            Keys.navigator.currentState?.pushNamed(PagesEnum.settings.toPath);
          }, icon: const Icon(Icons.settings))],
        ),
        const Expanded(
            child: Center(
          child: Text("Profile"),
        ))
      ],
    );
  }
}
