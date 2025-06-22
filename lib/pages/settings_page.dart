import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Account'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.lock),
          title: Text('Change Password'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Log Out'),
        ),
      ],
    );
  }
}
