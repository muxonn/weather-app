import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider({this.isDark = false});

  bool isDark;

  void changeTheme(bool isDark) {}
}
