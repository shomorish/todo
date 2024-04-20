import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/components/left_right_row.dart';
import 'package:todo/models/app/app_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('S E T T I N G S'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            LeftRightRow(
              onTap: context.read<AppState>().toggleTheme,
              padding: const EdgeInsets.all(8),
              left: const Text('Dark Theme'),
              right: CupertinoSwitch(
                value:
                    context.select((AppState appState) => appState.isDarkTheme),
                onChanged: (_) => context.read<AppState>().toggleTheme(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
