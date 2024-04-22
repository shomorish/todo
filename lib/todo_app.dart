import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/app/app_state.dart';
import 'package:todo/models/todo/todo_provider.dart';
import 'package:provider/provider.dart';
import 'package:todo/routing/router.dart';

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
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'TODO',
          theme: context.select((AppState appState) => appState.theme),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routerConfig: router,
        );
      },
    );
  }
}
