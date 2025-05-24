import 'package:flutter/material.dart';
import '../pages/bill.dart';
import '../pages/complaints.dart';
import '../pages/request.dart';

class SquareIconWidget extends StatelessWidget {
  final IconData iconData;
  final String label;
  final VoidCallback onTap;

  const SquareIconWidget({
    Key? key,
    required this.iconData,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80, // ukubwa wa mraba
        height: 80,
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Welcome to the Dashboard',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SquareIconWidget(
                iconData: Icons.receipt,
                label: 'View Bill',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Bill()),
                  );
                },
              ),
              SquareIconWidget(
                iconData: Icons.report,
                label: 'Complaint',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Complaints()),
                  );
                },
              ),
              SquareIconWidget(
                iconData: Icons.send,
                label: 'Request',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Request()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}