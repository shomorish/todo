import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/components/top_level_scaffold.dart';
import 'package:todo/pages/home/home.dart';
import 'package:todo/pages/settings/settings.dart';
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
              child: const HomePage(),
            );
          },
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
