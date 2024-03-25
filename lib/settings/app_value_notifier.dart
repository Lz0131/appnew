import 'package:flutter/material.dart';

class AppValueNotifier {
  static ValueNotifier banTheme = ValueNotifier(false);
  static ValueNotifier<bool> themeNotifier = ValueNotifier<bool>(false);
  static ValueNotifier banProducts = ValueNotifier(false);
}
