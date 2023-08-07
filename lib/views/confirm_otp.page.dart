import 'package:app/business_logic/blocs/auth.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmOTPPage extends StatefulWidget {
  const ConfirmOTPPage({super.key});

  @override
  State<ConfirmOTPPage> createState() => _ConfirmOTPPageState();
}

class _ConfirmOTPPageState extends State<ConfirmOTPPage> {
  String smsCode = "";

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      smsCode = value;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: smsCode.length < 6
                      ? null
                      : () async {
                          setState(() {
                            isLoading = true;
                          });
                          await context
                              .read<AuthBloc>()
                              .loginWithSmsCode(smsCode);
                        },
                  child: const Text("Conferma"),
                )
              ],
            ),
          ),
          Positioned.fill(
            child: Visibility(
              visible: isLoading,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.black.withAlpha(55)),
                child: const CircularProgressIndicator(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
