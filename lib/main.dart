import 'package:adolapp/provider/object_temporary_provider.dart';
import 'package:adolapp/provider/product_provider.dart';
import 'package:adolapp/screens/add_product_screen.dart';
import 'package:adolapp/screens/cart_screen.dart';
import 'package:adolapp/screens/login_screen.dart';
import 'package:adolapp/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/hometabs_screen.dart';
import 'screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Adol App",
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        accentColor: Colors.lightGreenAccent,
        fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              body1: TextStyle(
                fontFamily: 'OpenSans',
              ),
              body2: TextStyle(
                fontFamily: 'OpenSans',
                color: Theme.of(context).primaryColor,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
              ),
          iconTheme: IconThemeData.fallback().copyWith(
            color: Colors.white,
          ),
        ),
      ),
      initialRoute: "/",
      routes: {
        "/": (_) => SplashScreen(),
        "/login": (_) => LoginScreen(),
        "/register": (_) => RegisterScreen(),
        AddProductScreen.routeName: (_) => AddProductScreen(),
        CartScreen.routeName: (_) => CartScreen(),
      },
    );
  }
}
