import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/models/todo/todo.dart';
import 'package:todo/pages/home/narrow_home.dart';
import 'package:todo/pages/todo_details/todo_details.dart';

class WideHomeLayout extends StatelessWidget {
  final List<ToDo> toDoList;
  final ToDo? selectedToDo;
  final bool isLoading;
  final bool isError;
  final void Function(ToDo) onToDoDelete;
  final void Function(ToDo) onToDoTap;
  final void Function() onAdd;

  final TextEditingController titleController;
  final TextEditingController detailsController;
  final void Function()? onSave;

  const WideHomeLayout({
    super.key,
    required this.toDoList,
    this.selectedToDo,
    required this.isLoading,
    required this.isError,
    required this.onToDoDelete,
    required this.onToDoTap,
    required this.onAdd,
    required this.titleController,
    required this.detailsController,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 400,
          child: NarrowHomeLayout(
            toDoList: toDoList,
            isLoading: isLoading,
            isError: isError,
            onToDoDelete: onToDoDelete,
            onToDoTap: onToDoTap,
            onAdd: onAdd,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ToDoDetailsPage(
            toDo: selectedToDo,
            titleController: titleController,
            detailsController: detailsController,
            onSave: onSave,
          ),
        ),
      ],
    );
  }
}
