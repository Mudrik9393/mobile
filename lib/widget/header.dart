import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.blue.shade700,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: const Center(
          child: Text(
            'ZAWA Dashboard',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
