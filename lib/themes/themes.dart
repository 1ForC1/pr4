import 'package:flutter/material.dart';

class ThemesChange {
  ThemeData change(bool isDark) {
    if (isDark) {
      return ThemeData(
        textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Color(0xFF293462)),
            headlineMedium: TextStyle(color: Color(0xFF293462), fontSize: 30)),
        scaffoldBackgroundColor: const Color(0xFFffdf4a),
        brightness: Brightness.light,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xFFf19339)),
              iconColor: MaterialStateProperty.all(const Color(0xFF292625))),
        ),
      );
    } else {
      return ThemeData(
        textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Color(0xFFf19339)),
            headlineMedium: TextStyle(color: Color(0xFFf19339), fontSize: 30)),
        scaffoldBackgroundColor: const Color(0xFF293462),
        brightness: Brightness.dark,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xFF292625)),
              iconColor: MaterialStateProperty.all(const Color(0xFFf19339))),
        ),
      );
    }
  }
}
