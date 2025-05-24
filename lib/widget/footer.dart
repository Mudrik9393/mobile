import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      child: const Center(
        child: Text('© 2025 ZAWA - All rights reserved'),
      ),
    );
  }
}
