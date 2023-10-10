import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:app/business_logic/blocs/auth.bloc.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String number = "";
  String email = "", password = "";
  bool isPhoneLogin = true;

  final AuthCubit authCubit = AppProvider.instance.authCubit;

  ///
  /// Costruisce la schermata per il login tramite numero di telefono
  ///

  Widget _buildPhoneLogin() {
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
            decoration: const InputDecoration.collapsed(hintText: 'Telefono'),
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

  /// Costruisce la parte della ui per effettuare il login tramite email
  // TODO: creare il procedimento per effettuare il login

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
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32.0,
          vertical: 16.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Benvenuto",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                "Inserisci il tuo numero di telefono o la tua email per accedere",
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: isPhoneLogin ? _buildPhoneLogin() : _buildEmailLogin(),
            ),
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
                      (!isPhoneLogin && email.isNotEmpty && password.isNotEmpty)
                  ? () async {
                      await authCubit.login(number);
                    }
                  : null,
              child: const Text("Login"),
            )
          ],
        ));
  }
}
