import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skriptarnica/consts/theme_data.dart';
import 'package:skriptarnica/providers/cart_provider.dart';
import 'package:skriptarnica/providers/order_provider.dart';
import 'package:skriptarnica/providers/products_provider.dart';
import 'package:skriptarnica/providers/theme_provider.dart';
import 'package:skriptarnica/providers/user_provider.dart';
import 'package:skriptarnica/providers/viewed_recently_provider.dart';
import 'package:skriptarnica/providers/wishlist_provider.dart';
import 'package:skriptarnica/screens/auth/forgot_password.dart';
import 'package:skriptarnica/screens/auth/login.dart';
import 'package:skriptarnica/screens/auth/register.dart';
import 'package:skriptarnica/screens/inner_screen/orders/orders_screen.dart';
import 'package:skriptarnica/screens/inner_screen/product_details.dart';
import 'package:skriptarnica/screens/inner_screen/viewed_recently.dart';
import 'package:skriptarnica/screens/inner_screen/wishlist.dart';
import 'package:skriptarnica/screens/root_screen.dart';
import 'package:skriptarnica/screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                  body:
                      Center(child: SelectableText(snapshot.error.toString()))),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) {
                return ThemeProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return ProductsProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return CartProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return WishlistProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return ViewedProdProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return UserProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return OrderProvider();
              }),
            ],
            child: Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'FTN Skriptarnica',
                  theme: Styles.themeData(
                      isDarkTheme: themeProvider.getIsDarkTheme,
                      context: context),
                  //home: const RootScreen(),
                  home: const LoginScreen(),
                  routes: {
                    RootScreen.routeName: (context) => const RootScreen(),
                    ProductDetailsScreen.routName: (context) =>
                        const ProductDetailsScreen(),
                    WishlistScreen.routName: (context) =>
                        const WishlistScreen(),
                    ViewedRecentlyScreen.routName: (context) =>
                        const ViewedRecentlyScreen(),
                    RegisterScreen.routName: (context) =>
                        const RegisterScreen(),
                    LoginScreen.routeName: (context) => const LoginScreen(),
                    OrdersScreen.routeName: (context) => const OrdersScreen(),
                    ForgotPasswordScreen.routeName: (context) =>
                        const ForgotPasswordScreen(),
                    SearchScreen.routName: (context) => const SearchScreen(),
                  });
            }),
          );
        });
  }
}
