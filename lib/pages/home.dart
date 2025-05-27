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
            // Logo ya ZAWA juu
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

            // Buttons kwa grid ndogo
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
                    // Add your navigation here
                  },
                ),
                _buildButtonBox(
                  icon: Icons.info,
                  label: 'ZAWA Info',
                  color: Colors.blue[100]!,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const ZawaInfoPage()));
                  },
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Card ya maelezo ya ZAWA
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

      // Footer card
      bottomNavigationBar: Card(
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navIcon(context, Icons.home, 'Home', () {}),
              _navIcon(context, Icons.receipt, 'Bill', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Bill()));
              }),
              _navIcon(context, Icons.report, 'Complaint', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Complaints()));
              }),
              _navIcon(context, Icons.info, 'ZAWA', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ZawaInfoPage()));
              }),
            ],
          ),
        ),
      ),
    );
  }

  // 🟦 Button kwa grid
  Widget _buildButtonBox({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 20, // square ndogo
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: Colors.black87),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 9),
            ),
          ],
        ),
      ),
    );
  }

  // 🟨 Nav icon helper
  Widget _navIcon(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.blueAccent, size: 24),
          Text(label, style: const TextStyle(fontSize: 10)),
        ],
      ),
    );
  }
}
