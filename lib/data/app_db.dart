import 'package:hive_flutter/hive_flutter.dart';


class AppDb {
  static const key = "COLOR";
  int themeColor = 0xFF6733AB7;

  final _colorBox = Hive.box<int>("colorBox");

  void getThemeColor() {
    themeColor = _colorBox.get(key, defaultValue: themeColor) ?? themeColor;
  }

  void updateThemeColor() {
    _colorBox.put(key, themeColor);
  }
}