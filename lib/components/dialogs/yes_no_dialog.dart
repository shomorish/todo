import 'package:flutter/material.dart';

class YesNoDialog extends StatelessWidget {
  final Widget content;
  final void Function() onYes;
  final void Function() onNo;

  const YesNoDialog({
    super.key,
    required this.content,
    required this.onYes,
    required this.onNo,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: content,
      actions: [
        MaterialButton(
          onPressed: onNo,
          child: const Text('NO'),
        ),
        MaterialButton(
          onPressed: onYes,
          child: const Text('YES'),
        ),
      ],
    );
  }
}
