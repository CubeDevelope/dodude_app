import 'package:app/business_logic/blocs/auth.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String number = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.only(
                bottom: 32,
                right: 32.0,
              ),
              child: Row(
                children: [
                  const TextButton(
                      onPressed: null,
                      child: Row(
                        children: [
                          Text("+39"),
                        ],
                      )),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          number = value;
                        });
                      },
                    ),
                  )
                ],
              )),
          ElevatedButton(
            onPressed: number.isEmpty
                ? null
                : () async {
                    await context.read<AuthBloc>().login(
                          number,
                        );
                  },
            child: const Text("Login"),
          )
        ],
      ),
    );
  }
}
