import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skriptarnica/consts/theme_data.dart';
import 'package:skriptarnica/providers/theme_provider.dart';
import 'package:skriptarnica/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return ThemeProvider();
        }),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'FTN Skriptarnica',
          theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme, context: context),
          home: const HomeScreen(),
        );
      }),
    );
  }
}
