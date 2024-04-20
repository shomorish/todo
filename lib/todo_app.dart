import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/app/app_state.dart';
import 'package:todo/models/note/todo_provider.dart';
import 'package:provider/provider.dart';
import 'package:todo/pages/home/home.dart';

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
        ChangeNotifierProvider(create: (context) => AppState()),
        Provider.value(value: toDoProvider),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: context.select((AppState appState) => appState.theme),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: const HomePage(),
        );
      },
    );
  }
}
