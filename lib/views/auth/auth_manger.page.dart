import 'package:app/business_logic/blocs/auth.bloc.dart';
import 'package:app/business_logic/blocs/states/auth.state.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/router.dart';
import 'package:app/views/auth/add_personal_info.page.dart';
import 'package:app/views/auth/confirm_otp.page.dart';
import 'package:app/views/auth/login.page.dart';
import 'package:app/views/splash.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthManagerPage extends StatefulWidget {
  const AuthManagerPage({super.key});

  @override
  State<AuthManagerPage> createState() => _AuthManagerPageState();
}

class _AuthManagerPageState extends State<AuthManagerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer(
          listener: (context, state) {
            if (state is AuthenticatedState) {
              Keys.masterNavigator.currentState
                  ?.pushReplacementNamed(MasterPages.home.toPath);
            }
          },
          builder: (context, state) {
            Widget page = const Center(
              child: CircularProgressIndicator(),
            );

            switch (state.runtimeType) {
              case UnsignedState:
                page = const LoginPage();
                break;
              case InitializationState:
                page = const SplashPage();
                break;
              case ConfirmOTPState:
                page = const ConfirmOTPPage();
                break;
              case AddPersonalInformationState:
                page = const AddPersonalInfoPage();
                break;
              case LoadingState:
                page = Scaffold(
                  body: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: CircularProgressIndicator(),
                        ),
                        Text((state as LoadingState).message)
                      ],
                    ),
                  ),
                );
              default:
            }

            return page;
          },
          bloc: AuthCubit.instance,
          buildWhen: (previous, current) {
            return current is! AuthenticatedState;
          },
        ),
      ),
    );
  }
}
