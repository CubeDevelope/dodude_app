import 'package:app/business_logic/blocs/user.bloc.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/router.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (c) => UserBloc(),
      child: MaterialApp(
        navigatorKey: Keys.masterNavigator,
        themeMode: ThemeMode.dark,
        theme: AppColors.lightTheme,
        darkTheme: AppColors.darkTheme,
        onGenerateRoute: Router.masterGenerateRoute,
        initialRoute: MasterPages.auth.toPath,
      ),
    );
  }
}
