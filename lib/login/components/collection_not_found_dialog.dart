import 'package:flutter/material.dart';

class CollectionNotFound extends StatelessWidget {
  const CollectionNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text("Can't find collection..."),
      ),
    );
  }
}
