import 'package:flutter/material.dart';
import 'package:todo/theme/dark_theme.dart';
import 'package:todo/theme/light_theme.dart';
import 'package:todo/utils/easy_notifier.dart';

class AppState extends EasyNotifier {
  ThemeData _theme = lightTheme;
  ThemeData get theme => _theme;

  bool get isDarkTheme => _theme == darkTheme;

  void toggleTheme() =>
      notify(() => _theme = isDarkTheme ? lightTheme : darkTheme);
}
