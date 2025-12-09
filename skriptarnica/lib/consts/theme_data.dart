import 'package:flutter/material.dart';
import 'package:skriptarnica/consts/app_colors.dart';

class Styles {
  static ThemeData themeData({
    required bool isDarkTheme,
    required BuildContext context,
  }) {
    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme
          ? AppColors.darkScaffoldColor
          : AppColors.lightScaffoldColor,
      cardColor: isDarkTheme ? Colors.grey[800] : AppColors.lightCardColor,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      appBarTheme: AppBarTheme(
          backgroundColor: isDarkTheme
              ? AppColors.darkScaffoldColor
              : AppColors.lightScaffoldColor,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
