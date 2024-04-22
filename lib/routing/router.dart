import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/components/top_level_scaffold.dart';
import 'package:todo/models/note/todo.dart';
import 'package:todo/pages/home/home.dart';
import 'package:todo/pages/settings/settings.dart';
import 'package:todo/pages/todo_details/todo_details.dart';
import 'package:todo/routing/top_level_destination.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      routes: [
        GoRoute(
          path: TopLevelDestination.home.goRoutePath,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: HomePage(
                onToDoTap: (toDo) => context.go('/todo/edit', extra: toDo),
                onAdd: () => context.go('/todo/new'),
              ),
            );
          },
          routes: [
            GoRoute(
              path: 'todo/new',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) {
                return ToDoDetailsPage();
              },
            ),
            GoRoute(
              path: 'todo/edit',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) {
                final toDo = state.extra as ToDo;
                return ToDoDetailsPage();
              },
            ),
          ],
        ),
        GoRoute(
          path: TopLevelDestination.settings.goRoutePath,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            GoRouter.of(context).routeInformationProvider.value.uri;
            return NoTransitionPage(
              child: const SettingsPage(),
            );
          },
        ),
      ],
      // ShellRoute builder.
      builder: (context, state, child) {
        return TopLevelScaffold(
          onNavigateToDestination: (dest) => context.go(dest.goRoutePath),
          child: child,
        );
      },
    ),
  ],
);
