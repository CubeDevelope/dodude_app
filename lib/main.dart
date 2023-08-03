import 'package:app/business_logic/blocs/auth.bloc.dart';
import 'package:app/business_logic/blocs/error_handler.bloc.dart';
import 'package:app/business_logic/blocs/states/auth.state.dart';
import 'package:app/business_logic/blocs/states/error.state.dart';
import 'package:app/views/confirm_otp.page.dart';
import 'package:app/views/dialogs/error.dialog.dart';
import 'package:app/views/login.page.dart';
import 'package:app/views/splash.page.dart';
import 'package:app/views/widgets/dodude_scaffold.widget.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ErrorHandlerBloc(),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(),
        home: BlocListener<ErrorHandlerBloc, ErrorState>(
          listener: (context, state) {
            Widget dialog = const Dialog();
            switch (state.runtimeType) {
              case TooManyRequestErrorState:
                dialog = const ErrorDialog(
                  title: "TooManyRequest",
                  description:
                      "Sono state effettuate troppo richieste in poco tempo. Riprova più tardi",
                );
                break;
            }

            showDialog(context: context, builder: (context) => dialog);
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case InitializationState:
                  return const SplashPage();
                case UnsignedState:
                  return const LoginPage();
                case ConfirmOTPState:
                  return const ConfirmOTPPage();
                case AuthenticatedState:
                  return const HomePage();
                default:
                  return const SplashPage();
              }
            },
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const DodudeScaffold();
  }
}
