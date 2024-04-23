import 'package:flutter/material.dart';
import 'package:sized_context/sized_context.dart';
import 'package:todo/components/todo_card.dart';
import 'package:todo/components/todo_tile.dart';
import 'package:todo/enums/window_size.dart';
import 'package:todo/models/todo/todo.dart';

class ToDoList extends StatelessWidget {
  final List<ToDo> toDoList;
  final void Function(ToDo) onToDoTap;

  const ToDoList({
    super.key,
    required this.toDoList,
    required this.onToDoTap,
  });

  @override
  Widget build(BuildContext context) {
    final windowSizeType = WindowSizeType.fromWidth(context.widthPx);
    switch (windowSizeType) {
      case WindowSizeType.compact:
      case WindowSizeType.expanded:
        return ListView.builder(
          itemCount: toDoList.length,
          itemBuilder: (context, index) {
            final toDo = toDoList[index];
            return ToDoTile(
              title: toDo.title,
              onTap: () => onToDoTap(toDo),
            );
          },
        );
      case WindowSizeType.medium:
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: toDoList.length,
          itemBuilder: (context, index) {
            final toDo = toDoList[index];
            return ToDoCard(
              title: toDo.title,
              details: toDo.details,
              isCompleted: toDo.isCompleted,
              onTap: () => onToDoTap(toDo),
            );
          },
        );
    }
  }
}
