import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider({this.isDark = false});

  bool isDark;

  void changeToDark(bool value) {
    isDark = value;
    notifyListeners();
  }
}
