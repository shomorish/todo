import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sized_context/sized_context.dart';
import 'package:todo/components/dialogs/yes_no_dialog.dart';
import 'package:todo/enums/window_size.dart';
import 'package:todo/models/todo/todo.dart';
import 'package:todo/models/todo/todo_provider.dart';
import 'package:todo/pages/home/narrow_home.dart';
import 'package:todo/pages/home/wide_home.dart';

class HomePage extends StatefulWidget {
  final List<ToDo> toDoList;
  final bool isLoading;
  final bool isError;

  const HomePage({
    super.key,
    required this.toDoList,
    required this.isLoading,
    required this.isError,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ToDo? selectedToDo;
  late TextEditingController titleController;
  late TextEditingController detailsController;

  @override
  void initState() {
    titleController = TextEditingController();
    detailsController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  void openToDo(ToDo toDo) {
    setState(() {
      selectedToDo = toDo;
      titleController.text = toDo.title;
      detailsController.text = toDo.details ?? '';
    });
  }

  void createNewToDo() {
    setState(() {
      selectedToDo = null;
      titleController.text = '';
      detailsController.text = '';
    });
  }

  void saveToDo() async {
    if (selectedToDo == null) {
      var toDo = ToDo(
        titleController.text,
        false,
        details: detailsController.text,
      );

      // A new todo is added and the id is set.
      toDo = await context.read<ToDoProvider>().insertToDo(toDo);

      // Select newly added todo.
      setState(() {
        selectedToDo = toDo;
      });
    } else {
      final updatedToDo = selectedToDo!.copy(
        title: titleController.text,
        details: detailsController.text,
      );
      context.read<ToDoProvider>().updateToDo(updatedToDo);
    }
  }

  void deleteToDo(ToDo toDo) async {
    showDialog(
      context: context,
      builder: (context) {
        return YesNoDialog(
          content: const Text("Do you want to delete it?"),
          onYes: () async {
            await context.read<ToDoProvider>().deleteToDo(toDo.id!);
            if (selectedToDo?.id == toDo.id) {
              selectedToDo = null;
              titleController.clear();
              detailsController.clear();
            }
            if (context.mounted) Navigator.pop(context);
          },
          onNo: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final windowSizeType = WindowSizeType.fromWidth(context.widthPx);
    if (windowSizeType == WindowSizeType.expanded) {
      return ValueListenableBuilder<TextEditingValue>(
        valueListenable: titleController,
        builder: (context, value, child) {
          return WideHomeLayout(
            toDoList: widget.toDoList,
            selectedToDo: selectedToDo,
            isLoading: widget.isLoading,
            isError: widget.isError,
            onToDoDelete: deleteToDo,
            onToDoTap: openToDo,
            onAdd: createNewToDo,
            titleController: titleController,
            detailsController: detailsController,
            onSave: value.text.isNotEmpty ? saveToDo : null,
          );
        },
      );
    } else {
      return NarrowHomeLayout(
        toDoList: widget.toDoList,
        isLoading: widget.isLoading,
        isError: widget.isError,
        onToDoDelete: deleteToDo,
        onToDoTap: (toDo) => context.go('/todo/edit', extra: toDo),
        onAdd: () => context.go('/todo/new'),
      );
    }
  }
}
