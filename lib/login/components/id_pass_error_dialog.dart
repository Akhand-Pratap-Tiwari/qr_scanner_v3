import 'package:flutter/material.dart';

class IdPassError extends StatelessWidget {
  const IdPassError({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Oops!",
        style: TextStyle(color: Colors.red),
      ),
      content: const Text(
          "Looks like there is problem in email or password... \nRecheck the details you have entered."),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("OK"),
        )
      ],
    );
  }
}
