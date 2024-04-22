import 'package:flutter/material.dart';
import 'package:todo/models/todo/todo.dart';

class ToDoDetailsPage extends StatelessWidget {
  final ToDo? toDo;
  final TextEditingController titleController;
  final TextEditingController detailsController;
  final void Function()? onSave;

  ToDoDetailsPage({
    super.key,
    this.toDo,
    TextEditingController? titleController,
    TextEditingController? detailsController,
    this.onSave,
  })  : titleController =
            titleController ?? TextEditingController(text: toDo?.title),
        detailsController =
            detailsController ?? TextEditingController(text: toDo?.details);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          ListView(
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

          // Save button.
          if (onSave != null)
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton(
                  onPressed: onSave,
                  child: const Text('SAVE'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
