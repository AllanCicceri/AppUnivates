import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final ValueChanged<bool>? onResult;

  const CustomDialog({super.key, this.onResult});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Wrong password!"),
      content: const Text("Would you like to see a tip?"),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Yes")),
        TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("No")),
      ],
    );
  }
}
