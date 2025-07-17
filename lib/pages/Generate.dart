import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/dashboard.dart';

class Generate extends StatefulWidget {
  const Generate({super.key});

  @override
  State<Generate> createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  bool isLoading = false;
  String? controlNumber;
  String? errorMessage;

  Future<String?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  Future<void> generateControlNumber() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      controlNumber = null;
    });

    final userId = await _getUserId();

    if (userId == null) {
      setState(() {
        errorMessage = "User ID not found. Please login again.";
        isLoading = false;
      });
      return;
    }

    final url = Uri.parse('http://192.168.154.87:5555/api/generate/$userId');

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          controlNumber = data['controlNumber'] ?? 'N/A';
        });
      } else {
        setState(() {
          errorMessage = 'Failed to generate control number. Status: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> viewExistingControlNumber() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      controlNumber = null;
    });

    final userId = await _getUserId();

    if (userId == null) {
      setState(() {
        errorMessage = "User ID not found. Please login again.";
        isLoading = false;
      });
      return;
    }

    final url = Uri.parse('http://192.168.154.87:5555/api/generate/single/$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          controlNumber = data['controlNumber'] ?? 'No Control Number';
        });
      } else if (response.statusCode == 404) {
        setState(() {
          errorMessage = 'No control number found for this user.';
        });
      } else {
        setState(() {
          errorMessage = 'Failed to retrieve control number. Status: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dashboard(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : const Icon(Icons.control_point),
              label: const Text('Generate Control Number'),
              onPressed: isLoading ? null : generateControlNumber,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.green,
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.visibility),
              label: const Text('View Control Number'),
              onPressed: isLoading ? null : viewExistingControlNumber,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.blueGrey,
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            if (controlNumber != null)
              Card(
                color: Colors.green[50],
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'Your Control Number:\n\n$controlNumber',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
