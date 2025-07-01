import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/header.dart';
import '../widget/footer.dart';
import '../pages/home.dart';
import '../pages/message_page.dart';
import '../pages/settings_page.dart';
import '../pages/about_page.dart';
import '../pages/bill.dart';

class Dashboard extends StatelessWidget {
  final Widget child;
  const Dashboard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Header(), // Header ya juu

            Expanded(child: child), // Yaliyomo ya kila page

            // Navigation bar
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: screenWidth * 0.04,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navIcon(context, Icons.home, 'Home', const Home(), screenWidth),
                  _navIcon(context, Icons.receipt_long, 'Bills', null, screenWidth, isBill: true),
                  _navIcon(context, Icons.message, 'Message', const MessagePage(), screenWidth),
                  _navIcon(context, Icons.settings, 'Settings', const SettingsPage(), screenWidth),
                  _navIcon(context, Icons.info_outline, 'About', const AboutPage(), screenWidth),
                ],
              ),
            ),

            const Footer(), // Footer ya mwisho
          ],
        ),
      ),
    );
  }

  Widget _navIcon(
    BuildContext context,
    IconData icon,
    String label,
    Widget? page,
    double screenWidth, {
    bool isBill = false,
  }) {
    return GestureDetector(
      onTap: () async {
        if (isBill) {
          final prefs = await SharedPreferences.getInstance();
          final userId = prefs.getString('userId');

          if (userId != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard(child: Bill(userId: userId)),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User ID not found')),
            );
          }
        } else if (page != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Dashboard(child: page)),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.blueAccent, size: 24),
          Text(
            label,
            style: TextStyle(fontSize: screenWidth * 0.025),
          ),
        ],
      ),
    );
  }
}
