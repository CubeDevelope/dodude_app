import 'package:app/business_logic/blocs/error_handler.bloc.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/router.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (c) => ErrorHandlerBloc()),
      ],
      child: MaterialApp(
        navigatorKey: Keys.masterNavigator,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(),
        onGenerateRoute: Router.masterGenerateRoute,
        initialRoute: MasterPages.auth.toPath,
      ),
    );
  }
}
