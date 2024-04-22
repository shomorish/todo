import 'package:flutter/material.dart';
import 'package:todo/models/note/todo.dart';

class ToDoDetailsPage extends StatelessWidget {
  final ToDo? toDo;
  final TextEditingController titleController;
  final TextEditingController detailsController;

  ToDoDetailsPage({
    super.key,
    this.toDo,
  })  : titleController = TextEditingController(text: toDo?.title ?? ''),
        detailsController = TextEditingController(text: toDo?.details ?? '');

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: [
          // Title text field.
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Title',
            ),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Details text field.
          TextField(
            controller: detailsController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Details',
            ),
            maxLines: null,
          ),
        ],
      ),
    );
  }
}
