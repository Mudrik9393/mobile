import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Map<String, dynamic>? userProfile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = int.tryParse(prefs.getString('userId') ?? '0') ?? 0;

    try {
      final response = await http
          .get(Uri.parse('${Constants.baseUrl}/api/users/$userId'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          userProfile = {
            "userName": data["userName"],
            "email": data["email"],
            "zanId": data["zanId"],
            "status": "Active",  // default status
          };
          isLoading = false;
        });
      } else {
        print("Failed to fetch user: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Error fetching user: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final initialLetter = (userProfile?["userName"] ?? "U").substring(0, 1).toUpperCase();

    return Scaffold(
      // No AppBar to remove the "My Profile" title as requested
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userProfile == null
              ? const Center(child: Text("Failed to load user data"))
              : SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 8,
                      shadowColor: Colors.grey.shade300,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.deepPurpleAccent,
                              child: Text(
                                initialLetter,
                                style: const TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            buildProfileItem(Icons.person_outline, "Username", userProfile!["userName"]),
                            const Divider(height: 30),
                            buildProfileItem(Icons.email_outlined, "Email", userProfile!["email"]),
                            const Divider(height: 30),
                            buildProfileItem(Icons.credit_card_outlined, "ZanID", userProfile!["zanId"]),
                            const Divider(height: 30),
                            buildProfileItem(Icons.check_circle_outline, "Status", userProfile!["status"]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }

  Widget buildProfileItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.deepPurpleAccent, size: 28),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.grey,
                  )),
              const SizedBox(height: 6),
              Text(value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
