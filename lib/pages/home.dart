import 'package:flutter/material.dart';
import '../pages/bill.dart';
import '../pages/complaints.dart';
import '../pages/request.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[50], // Background ya kuvutia
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ZAWA logo juu
            Center(
              child: Image.asset(
                'assets/zawa_logo.png',
                width: 100,
                height: 100,
              ),
            ),

            const SizedBox(height: 10),

            // Dashboard title
            const Text(
              'Welcome our Dear Customer',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // Grid buttons (smaller)
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
                  color: Colors.teal[100]!,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Bill()));
                  },
                ),
                _buildButtonBox(
                  icon: Icons.report,
                  label: 'Complaint',
                  color: Colors.orange[100]!,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Complaints()));
                  },
                ),
                _buildButtonBox(
                  icon: Icons.send,
                  label: 'Request',
                  color: Colors.purple[100]!,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Request()));
                  },
                ),
                _buildButtonBox(
                  icon: Icons.receipt_long,
                  label: 'Generate',
                  color: Colors.green[100]!,
                  onTap: () {
                    // Navigate to Generate Bill page
                  },
                ),
                _buildButtonBox(
                  icon: Icons.info,
                  label: 'ZAWA Info',
                  color: Colors.blue[100]!,
                  onTap: () {
                    // Show ZAWA info
                  },
                ),
              ],
            ),

            const SizedBox(height: 28),

            // ZAWA info card - bigger and prominent
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
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'ZAWA (Zanzibar Water Authority) is a government authority responsible for managing water services in Zanzibar. It ensures the availability of clean and safe water, receives customer inquiries, handles complaints, and provides bills efficiently.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12), // Nafasi kabla ya footer
          ],
        ),
      ),
    );
  }

  // Button ndogo kama square
   Widget _buildButtonBox({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60, // ✅ Punguzwa square height ya button
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 26, color: Colors.black87), // ✅ Icon imeachwa kama ilivyo
            const SizedBox(height: 4),
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