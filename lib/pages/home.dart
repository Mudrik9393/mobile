import 'package:flutter/material.dart';
import '../pages/zawaInfoPage.dart';
import '../pages/bill.dart';
import '../pages/complaints.dart';
import '../pages/request.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Image.asset(
                'assets/zawa_logo.png',
                width: 150,
                height: 150,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Welcome our Dear Customer',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildButtonBox(
                  icon: Icons.receipt,
                  label: 'View Bill',
                  iconColor: Colors.teal,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Bill(userId: '',)));
                  },
                ),
                _buildButtonBox(
                  icon: Icons.report,
                  label: 'Complaint',
                  iconColor: Colors.deepOrange,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Complaints()));
                  },
                ),
                _buildButtonBox(
                  icon: Icons.send,
                  label: 'Request',
                  iconColor: Colors.deepPurple,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Request()));
                  },
                ),
                _buildButtonBox(
                  icon: Icons.receipt_long,
                  label: 'Generate',
                  iconColor: Colors.green,
                  onTap: () {
                    // Add your navigation here
                  },
                ),
                _buildButtonBox(
                  icon: Icons.info,
                  label: 'ZAWA Info',
                  iconColor: Colors.blue,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const ZawaInfoPage()));
                  },
                ),
              ],
            ),
            const SizedBox(height: 18),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/zawa_logo.png',
                      width: 120,
                      height: 120,
                    ),
                    const SizedBox(width: 70),
                    const Expanded(
                      child: Text(
                        'ZAWA (Zanzibar Water Authority) is a government authority responsible for managing water services in Zanzibar. It ensures the availability of clean and safe water, receives customer inquiries, handles complaints, and provides bills efficiently.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonBox({
    required IconData icon,
    required String label,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.lightBlue[100]!, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: iconColor),
            // Tumeweka SizedBox kwa 2 badala ya 4
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}