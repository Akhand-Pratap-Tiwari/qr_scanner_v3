import 'package:flutter/material.dart';

class DatabaseError extends StatelessWidget {
  const DatabaseError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text("Database Error Happened..."),
      ),
    );
  }
}