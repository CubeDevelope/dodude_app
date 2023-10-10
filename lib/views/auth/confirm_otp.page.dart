import 'package:app/business_logic/blocs/app.provider.dart';
import 'package:flutter/material.dart';

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
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Inserisci il codice che ti è stato inviato tramite messaggio",
                style: TextStyle(height: 1.3),
                textAlign: TextAlign.center,
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 32.0, top: 16.0),
                  child: Row(
                    children: List.generate(6, (index) {
                      return Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        height: 70,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                        child: Text(
                          smsCode.length >= index + 1 ? smsCode[index] : "",
                          style: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ));
                    }),
                  )),
              ElevatedButton(
                onPressed: smsCode.length < 6
                    ? null
                    : () async {
                        setState(() {
                          isLoading = true;
                        });
                        await AppProvider.instance.authCubit
                            .confirmOTP(smsCode);
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
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: 8,
          child: TextField(
            maxLength: 6,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                smsCode = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
