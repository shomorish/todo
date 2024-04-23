import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sized_context/sized_context.dart';
import 'package:todo/components/todo_card.dart';
import 'package:todo/components/todo_tile.dart';
import 'package:todo/enums/window_size.dart';
import 'package:todo/models/todo/todo.dart';
import 'package:todo/models/todo/todo_provider.dart';
import 'package:todo/pages/home/narrow_home.dart';
import 'package:todo/pages/home/wide_home.dart';
import 'package:todo/utils/list.dart';

class HomePage extends StatefulWidget {
  final void Function(ToDo) onToDoTap;
  final VoidCallback onAdd;

  const HomePage({
    super.key,
    required this.onToDoTap,
    required this.onAdd,
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ToDo>>(
      stream: Provider.of<ToDoProvider>(context)
          .observeToDos()
          .distinct((prev, next) => equalsList(prev, next)),
      builder: (context, snapshot) {
        final windowSizeType = WindowSizeType.fromWidth(context.widthPx);
        if (windowSizeType == WindowSizeType.expanded) {
          return ValueListenableBuilder<TextEditingValue>(
            valueListenable: titleController,
            builder: (context, value, child) {
              return WideHomeLayout(
                toDoList: snapshot.data ?? [],
                selectedToDo: selectedToDo,
                isLoading: snapshot.connectionState == ConnectionState.none ||
                    snapshot.connectionState == ConnectionState.waiting,
                isError: snapshot.hasError,
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
            toDoList: snapshot.data ?? [],
            isLoading: snapshot.connectionState == ConnectionState.none ||
                snapshot.connectionState == ConnectionState.waiting,
            isError: snapshot.hasError,
            onToDoTap: (toDo) => context.go('/todo/edit', extra: toDo),
            onAdd: () => context.go('/todo/new'),
          );
        }
      },
    );
  }
}

class ToDoListContent extends StatelessWidget {
  final List<ToDo> toDoList;
  final void Function(ToDo) onToDoTap;

  const ToDoListContent({
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
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
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
