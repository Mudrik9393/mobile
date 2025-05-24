import 'package:flutter/material.dart';

class Complaints extends StatelessWidget {
  const Complaints({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Submit Your Complaint',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}
