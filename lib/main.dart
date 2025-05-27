import 'package:flutter/material.dart';
import 'pages/dashboard.dart';
import 'pages/home.dart';  // Hakikisha ume import page unayotaka kuonyesha kama default

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
      home: const Dashboard(
        child: Home(),  // Hii ni content ya default unayotaka kuonyesha
      ),
    );
  }
}
