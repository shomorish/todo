import 'package:flutter/material.dart';
import 'package:sized_context/sized_context.dart';
import 'package:todo/enums/window_size.dart';
import 'package:todo/routing/top_level_destination.dart';
import 'package:todo/utils/routing.dart';

class TopLevelScaffold extends StatelessWidget {
  final ValueChanged<TopLevelDestination> onNavigateToDestination;
  final Widget child;

  const TopLevelScaffold({
    super.key,
    required this.onNavigateToDestination,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final windowSizeType = WindowSizeType.fromWidth(context.widthPx);
    final shouldShowBottomNavBar = windowSizeType == WindowSizeType.compact;
    final shouldShowDrawer = windowSizeType == WindowSizeType.medium;
    final shouldShowNavRail = windowSizeType == WindowSizeType.expanded;
    final topLevelDestinations = TopLevelDestination.values.toList();
    final currentIndex = getCurrentTopLevelDestinationIndex(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('T O D O'),
      ),
      drawer: shouldShowDrawer
          ? _Drawer(
              onNavigateToDestination: onNavigateToDestination,
            )
          : null,
      bottomNavigationBar: shouldShowBottomNavBar
          ? _BottomNavBar(
              topLevelDestinations: topLevelDestinations,
              currentIndex: currentIndex,
              onNavigateToDestination: onNavigateToDestination,
            )
          : null,
      body: Row(
        children: [
          if (shouldShowNavRail)
            _NavRail(
              topLevelDestinations: topLevelDestinations,
              currentIndex: currentIndex,
              onNavigateToDestination: onNavigateToDestination,
            ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _Drawer extends StatelessWidget {
  final ValueChanged<TopLevelDestination> onNavigateToDestination;

  const _Drawer({
    required this.onNavigateToDestination,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Logo.
          const DrawerHeader(
            child: Center(
                child: Icon(
              Icons.task_alt,
              size: 64,
            )),
          ),

          for (final dest in TopLevelDestination.values)
            ListTile(
              title: Text(dest.title),
              leading: Icon(dest.icon),
              onTap: () {
                Navigator.pop(context);
                onNavigateToDestination(dest);
              },
            ),
        ],
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final List<TopLevelDestination> topLevelDestinations;
  final int currentIndex;
  final ValueChanged<TopLevelDestination> onNavigateToDestination;

  const _BottomNavBar({
    required this.topLevelDestinations,
    required this.currentIndex,
    required this.onNavigateToDestination,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: topLevelDestinations.map(
        (dest) {
          return BottomNavigationBarItem(
            icon: Icon(dest.icon),
            label: dest.title,
          );
        },
      ).toList(),
      onTap: (index) => onNavigateToDestination(topLevelDestinations[index]),
    );
  }
}

class _NavRail extends StatelessWidget {
  final List<TopLevelDestination> topLevelDestinations;
  final int currentIndex;
  final ValueChanged<TopLevelDestination> onNavigateToDestination;

  const _NavRail({
    required this.topLevelDestinations,
    required this.currentIndex,
    required this.onNavigateToDestination,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      destinations: [
        for (final dest in TopLevelDestination.values)
          NavigationRailDestination(
            icon: Icon(dest.icon),
            label: Text(dest.title),
          ),
      ],
      selectedIndex: currentIndex,
      onDestinationSelected: (index) =>
          onNavigateToDestination(topLevelDestinations[index]),
    );
  }
}
