import 'package:flutter/material.dart';
import '../pages/dashboard.dart';

class Bill extends StatelessWidget {
  const Bill({super.key});

  @override
  Widget build(BuildContext context) {
    return Dashboard(
      child: Text(
        'Your Billing Information',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}
