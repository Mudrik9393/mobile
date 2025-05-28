import 'package:flutter/material.dart';
import '../widget/header.dart';
import '../widget/footer.dart';
import '../pages/home.dart';
import '../pages/bill.dart';
import '../pages/complaints.dart';
import '../pages/zawaInfoPage.dart';

class Dashboard extends StatelessWidget {
  final Widget child;
  const Dashboard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Header(), // Header juu

          // Page content
          Expanded(child: child),

          // Navigation bar
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navIcon(context, Icons.home, 'Home', const Home()),
                _navIcon(context, Icons.receipt, 'Bill', const Bill()),
                _navIcon(context, Icons.report, 'Complaint', const Complaints()),
                _navIcon(context, Icons.info, 'ZAWA', const ZawaInfoPage()),
              ],
            ),
          ),

          const Footer(), // Footer chini kabisa
        ],
      ),
    );
  }

  Widget _navIcon(
    BuildContext context,
    IconData icon,
    String label,
    Widget page,
  ) {
    return GestureDetector(
      onTap: () {
        // ✅ Hatutumii tena Dashboard ndani ya Dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard(child: page)),
        );
      },
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
