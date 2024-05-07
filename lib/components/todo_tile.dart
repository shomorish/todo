import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {
  final String title;
  final void Function() onDelete;
  final void Function() onTap;

  const ToDoTile({
    super.key,
    required this.title,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(onPressed: onDelete, icon: const Icon(Icons.delete)),
      onTap: onTap,
    );
  }
}
