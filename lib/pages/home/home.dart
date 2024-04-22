import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sized_context/sized_context.dart';
import 'package:todo/components/todo_card.dart';
import 'package:todo/components/todo_tile.dart';
import 'package:todo/enums/window_size.dart';
import 'package:todo/models/note/todo.dart';
import 'package:todo/models/note/todo_provider.dart';

class HomePage extends StatelessWidget {
  final void Function(ToDo) onToDoTap;
  final VoidCallback onAdd;

  const HomePage({
    super.key,
    required this.onToDoTap,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder<List<ToDo>>(
          stream: Provider.of<ToDoProvider>(context).observeToDos(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error.'),
              );
            } else {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  // Loading UI.
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                case ConnectionState.active:
                case ConnectionState.done:
                  // Content UI.
                  final toDoList = snapshot.data!;
                  return ToDoListContent(
                    toDoList: toDoList,
                    onToDoTap: onToDoTap,
                  );
              }
            }
          },
        ),

        // Add button.
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16, right: 16),
            child: FloatingActionButton(
              onPressed: onAdd,
              child: const Icon(Icons.add),
            ),
          ),
        )
      ],
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
