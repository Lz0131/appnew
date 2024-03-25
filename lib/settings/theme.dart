import 'package:flutter/material.dart';

class ThemeApp {
  static Color startColorForTheme(bool isDarkMode) {
    return isDarkMode
        ? Color.fromARGB(255, 96, 102, 104)
        : const Color.fromARGB(255, 33, 150, 243);
  }

  static Color endColorForTheme(bool isDarkMode) {
    return isDarkMode
        ? Color.fromARGB(255, 44, 35, 35)
        : const Color.fromARGB(255, 156, 39, 176);
  }

  static ThemeData lightTheme(BuildContext context) {
    final theme = ThemeData.light();
    return theme.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: Color.fromARGB(255, 124, 71, 189),
          ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    final theme = ThemeData.dark();
    return theme.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: Color.fromARGB(255, 49, 56, 57),
          ), // Color de fondo para el tema oscuro
    );
  }
}
