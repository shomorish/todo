import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo/models/todo/todo_provider.dart';
import 'package:todo/todo_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  if (!kIsWeb) {
    sqfliteFfiInit();
  }
  databaseFactory = databaseFactoryFfi;

  final toDoProvider = ToDoProvider();
  await toDoProvider.openDb();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ja', 'JP')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: ToDoApp(toDoProvider: toDoProvider),
    ),
  );
}
