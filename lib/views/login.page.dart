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
  String email = "", password = "";
  bool isPhoneLogin = true;

  _buildPhoneLogin() {
    return Row(
      children: [
        const Text(
          "+39",
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration.collapsed(hintText: 'Telefono'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                number = value;
              });
            },
          ),
        )
      ],
    );
  }

  _buildEmailLogin() {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(label: Text("Email")),
          onChanged: (value) {
            setState(() {
              email = value;
            });
          },
        ),
        TextField(
          decoration: const InputDecoration(label: Text("Password")),
          onChanged: (value) {
            setState(() {
              password = value;
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accedi"),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32.0,
            vertical: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isPhoneLogin ? _buildPhoneLogin() : _buildEmailLogin(),
              TextButton(
                onPressed: () {
                  setState(() {
                    isPhoneLogin = !isPhoneLogin;
                  });
                },
                child: Text(isPhoneLogin
                    ? "Acced con email"
                    : "Accedi con il numero di telefono"),
              ),
              ElevatedButton(
                onPressed: (isPhoneLogin && number.isNotEmpty) ||
                        (!isPhoneLogin &&
                            email.isNotEmpty &&
                            password.isNotEmpty)
                    ? () async {
                        await context.read<AuthBloc>().login(number);
                      }
                    : null,
                child: const Text("Login"),
              )
            ],
          )),
    );
  }
}
