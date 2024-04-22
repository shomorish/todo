import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {
  final String title;
  final void Function() onTap;

  const ToDoTile({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }
}
