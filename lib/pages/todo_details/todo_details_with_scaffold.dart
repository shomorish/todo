import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/components/dialogs/yes_no_dialog.dart';
import 'package:todo/models/todo/todo.dart';
import 'package:todo/models/todo/todo_provider.dart';
import 'package:todo/pages/todo_details/todo_details.dart';

class ToDoDetailsPageWithScaffold extends StatelessWidget {
  final ToDo? toDo;
  final TextEditingController titleController;
  final TextEditingController detailsController;

  ToDoDetailsPageWithScaffold({
    super.key,
    this.toDo,
  })  : titleController = TextEditingController(text: toDo?.title),
        detailsController = TextEditingController(text: toDo?.details);

  Future<ToDo> _insertToDo(BuildContext context) async {
    final toDo = ToDo(
      titleController.text,
      false,
      details: detailsController.text,
    );
    return await context.read<ToDoProvider>().insertToDo(toDo);
  }

  Future<int> _updateToDo(BuildContext context) async {
    final updatedToDo = toDo!.copy(
      title: titleController.text,
      details: detailsController.text,
    );
    return await context.read<ToDoProvider>().updateToDo(updatedToDo);
  }

  String _getDialogMessage() {
    if (toDo == null) {
      return 'The title is empty and will not be saved. Do you want to return to the previous page?';
    } else {
      return 'Changes will not be saved because the title is empty. Do you want to return to the previous page?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (titleController.text.isNotEmpty) {
            if (toDo == null) {
              _insertToDo(context);
            } else {
              _updateToDo(context);
            }
            if (context.mounted) Navigator.pop(context);
            return;
          }
          showDialog(
            context: context,
            builder: (context) {
              return YesNoDialog(
                content: Text(_getDialogMessage()),
                onYes: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                onNo: () {
                  Navigator.pop(context);
                },
              );
            },
          );
        },
        child: ToDoDetailsPage(
          toDo: toDo,
          titleController: titleController,
          detailsController: detailsController,
        ),
      ),
    );
  }
}
