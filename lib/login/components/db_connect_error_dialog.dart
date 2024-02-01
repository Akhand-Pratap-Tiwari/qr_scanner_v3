import 'package:flutter/material.dart';

class DatabaseConnectError extends StatelessWidget {
  const DatabaseConnectError({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Looks like a typo in Database Name...'),
      ),
    );
  }
}
