import 'package:flutter/material.dart';
import '../widget/header.dart';
import '../widget/footer.dart';

class Dashboard extends StatelessWidget {
  final Widget child;
  const Dashboard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Header(),
          Expanded(child: child), // Hii inachukua page yoyote kama content
          const Footer(),
        ],
      ),
    );
  }
}
