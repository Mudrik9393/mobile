import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No new messages',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
