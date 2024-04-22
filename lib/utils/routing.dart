import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/routing/top_level_destination.dart';

String getCurrentDestinationPath(BuildContext context) {
  return GoRouter.of(context).routeInformationProvider.value.uri.path;
}

TopLevelDestination getCurrentTopLevelDestinationFromPath(String path) {
  if (path.startsWith(TopLevelDestination.settings.absolutePath)) {
    return TopLevelDestination.settings;
  } else {
    // The home path is "/", so return with else.
    return TopLevelDestination.home;
  }
}

int getCurrentTopLevelDestinationIndex(BuildContext context) {
  final currentDestinationPath = getCurrentDestinationPath(context);
  final currentTopLevelDestionation =
      getCurrentTopLevelDestinationFromPath(currentDestinationPath);
  final currentTopLevelDestinationIndex =
      TopLevelDestination.values.indexOf(currentTopLevelDestionation);
  return currentTopLevelDestinationIndex;
}
