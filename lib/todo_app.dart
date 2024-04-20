import 'package:flutter/material.dart';
import 'package:todo/models/note/todo_provider.dart';
import 'package:todo/pages/home/home.dart';
import 'package:provider/provider.dart';

class ToDoApp extends StatelessWidget {
  final ToDoProvider toDoProvider;

  const ToDoApp({
    super.key,
    required this.toDoProvider,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: toDoProvider),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomePage(),
        );
      },
    );
  }
}
