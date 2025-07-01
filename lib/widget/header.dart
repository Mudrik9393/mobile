import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.blue.shade700,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'ZARECO',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            // 🔁 Badala ya more_vert tumetumia Icon ya mtu
            PopupMenuButton<String>(
              icon: const Icon(Icons.account_circle, color: Colors.white, size: 28),
              onSelected: (value) {
                if (value == 'logout') {
                  Navigator.pushReplacementNamed(context, '/login');
                } else if (value == 'change_password') {
                  Navigator.pushNamed(context, '/change-password');
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'change_password',
                  child: Text('Change Password'),
                ),
                const PopupMenuItem(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
