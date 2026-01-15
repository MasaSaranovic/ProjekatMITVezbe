import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skriptarnica/consts/theme_data.dart';
import 'package:skriptarnica/providers/theme_provider.dart';
import 'package:skriptarnica/screens/auth/login.dart';
import 'package:skriptarnica/screens/auth/register.dart';
import 'package:skriptarnica/screens/inner_screen/orders/orders_screen.dart';
import 'package:skriptarnica/screens/inner_screen/product_details.dart';
import 'package:skriptarnica/screens/inner_screen/viewed_recently.dart';
import 'package:skriptarnica/screens/inner_screen/wishlist.dart';
import 'package:skriptarnica/screens/root_screen.dart';

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
            //home: const RootScreen(),
            home: const LoginScreen(),
            routes: {
              RootScreen.routeName: (context) => const RootScreen(),
              ProductDetailsScreen.routName: (context) =>
                  const ProductDetailsScreen(),
              WishlistScreen.routName: (context) => const WishlistScreen(),
              ViewedRecentlyScreen.routName: (context) =>
                  const ViewedRecentlyScreen(),
              RegisterScreen.routName: (context) => const RegisterScreen(),
              LoginScreen.routeName: (context) => const LoginScreen(),
              OrdersScreen.routeName: (context) => const OrdersScreen(),
            });
      }),
    );
  }
}
