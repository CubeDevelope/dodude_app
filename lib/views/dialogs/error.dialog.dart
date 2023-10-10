import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.title,
    required this.description,
    this.onConfirm,
  });

  final String title;
  final String description;
  final Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * .6,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * .3,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          children: [
            Text(title),
            Text(description),
            TextButton(
                onPressed: () {
                  onConfirm?.call();
                  Navigator.pop(context);
                },
                child: const Text("Conferma"))
          ],
        ),
      ),
    );
  }
}
