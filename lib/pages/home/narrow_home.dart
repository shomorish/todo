import 'package:flutter/material.dart';
import 'package:todo/components/todo_list.dart';
import 'package:todo/models/todo/todo.dart';

class NarrowHomeLayout extends StatelessWidget {
  final List<ToDo> toDoList;
  final bool isLoading;
  final bool isError;
  final void Function(ToDo) onToDoTap;
  final void Function() onAdd;

  const NarrowHomeLayout({
    super.key,
    required this.toDoList,
    this.isLoading = false,
    this.isError = false,
    required this.onToDoTap,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (isError) {
      children.add(
        const Center(
          child: Text('Error.'),
        ),
      );
    } else if (isLoading) {
      children.add(
        const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      children.add(
        ToDoList(
          toDoList: toDoList,
          onToDoTap: onToDoTap,
        ),
      );
    }

    // Add button.
    children.add(
      Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16, right: 16),
          child: FloatingActionButton(
            onPressed: onAdd,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );

    return Stack(
      children: children,
    );
  }
}
