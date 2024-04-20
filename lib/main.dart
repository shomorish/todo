import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo/models/note/todo_provider.dart';
import 'package:todo/todo_app.dart';

void main() async {
  if (!kIsWeb) {
    sqfliteFfiInit();
  }
  databaseFactory = databaseFactoryFfi;

  final toDoProvider = ToDoProvider();
  await toDoProvider.openDb();

  runApp(ToDoApp(toDoProvider: toDoProvider));
}
