import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _darkMode = false;
  var _color = Colors.yellow ;
  SharedPreferences? prefs;

  bool get darkMode => _darkMode;

  void toggleMode() {
    _darkMode = !_darkMode;
    if (prefs != null) {
      prefs!.setBool('darkMode', _darkMode);
    }

    notifyListeners();
  }

  SettingsProvider() {
    initPreferences();
  }

  void initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      _darkMode = prefs!.getBool('darkMode') ?? false;
    }
    notifyListeners();
  }

  void setColor(var color) async {
    prefs = await SharedPreferences.getInstance();
    _color = color;
    prefs!.setString('color', color.toString());
    notifyListeners();
  }




}
