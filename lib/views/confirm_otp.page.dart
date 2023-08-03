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
          Column(
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
          Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              right: 0,
              child: Visibility(
                visible: isLoading,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(color: Colors.black.withAlpha(55)),
                  child: const CircularProgressIndicator(),
                ),
              ))
        ],
      ),
    );
  }
}
