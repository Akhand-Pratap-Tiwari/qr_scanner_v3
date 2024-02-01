import 'package:flutter/material.dart';

class CircularLoadDialog extends StatelessWidget {
  const CircularLoadDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 4),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: CircularProgressIndicator(strokeCap: StrokeCap.round),
        ),
      ),
    );
  }
}
