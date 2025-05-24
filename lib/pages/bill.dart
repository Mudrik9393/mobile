import 'package:flutter/material.dart';

class Bill extends StatelessWidget {
  const Bill({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Your Billing Information',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}
