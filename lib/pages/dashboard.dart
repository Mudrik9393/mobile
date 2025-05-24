import 'package:flutter/material.dart';
import '../widget/header.dart';
import '../widget/footer.dart';
import 'home.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Header(),
          Expanded(child: Home()), // Home ndio default content
          Footer(),
        ],
      ),
    );
  }
}
