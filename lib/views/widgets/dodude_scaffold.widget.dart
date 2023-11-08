import 'package:app/utils/constants.dart';
import 'package:app/views/widgets/dodude_nav_bar.widget.dart';
import 'package:flutter/material.dart' hide Router;

import '../../utils/router.dart';

class DodudeScaffold extends StatelessWidget {
  const DodudeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: const DodudeNavBar(),
      body: Navigator(
        key: Keys.internalNavigator,
        onGenerateRoute: Router.generateRoute,
      ),
    ));
  }
}
