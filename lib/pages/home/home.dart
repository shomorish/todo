import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/note/todo.dart';
import 'package:todo/models/note/todo_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('T O D O'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: StreamBuilder<List<ToDo>>(
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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.active:
                case ConnectionState.done:
                  final toDoList = snapshot.data!;
                  return ListView.builder(
                    itemCount: toDoList.length,
                    itemBuilder: (context, index) {
                      return Text(toDoList[index].title);
                    },
                  );
              }
            }
          },
        ),
      ),
    );
  }
}
