import 'package:flutter/material.dart';
import 'package:my_project/auth/loginPage.dart';
import 'package:my_project/auth/sign_upPage.dart';
import 'pages/dashboard.dart';
import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZAWA System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login', // Anza na login page
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/dashboard': (context) => const Dashboard(
              child: Home(), // Dashboard itakuwa na Home kama default
            ),
      },
    );
  }
}