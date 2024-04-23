import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo/todo_provider.dart';
import 'package:todo/pages/home/home.dart';
import 'package:todo/utils/list.dart';

class HomePageWithStream extends StatelessWidget {
  const HomePageWithStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.read<ToDoProvider>().observeToDos().distinct(equalsList),
      builder: (context, snapshot) {
        return HomePage(
          toDoList: snapshot.data ?? [],
          isLoading: snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting,
          isError: snapshot.hasError,
        );
      },
    );
  }
}
