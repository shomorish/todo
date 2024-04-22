import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum TopLevelDestination {
  home('/', '/', Icons.home, 'home'),
  settings('/settings', '/settings', Icons.settings, 'settings');

  /// Destination relative path.
  final String goRoutePath;

  /// Destination absolute path.
  final String absolutePath;

  /// Destination icon.
  final IconData icon;

  /// Destination title text key.
  /// You can find the title text key in the json file under assets/translations.
  final String _titleTextKey;

  /// Desination titile.
  /// It uses easy_localization package.
  String get title => _titleTextKey.tr();

  const TopLevelDestination(
      this.goRoutePath, this.absolutePath, this.icon, this._titleTextKey);
}
