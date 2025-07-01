import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Bill extends StatefulWidget {
  final String userId;
  const Bill({super.key, required this.userId});

  @override
  State<Bill> createState() => _BillState();
}

class _BillState extends State<Bill> {
  List<dynamic> bills = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBills();
  }

  Future<void> fetchBills() async {
    try {
      final response = await http.get(
        Uri.parse('http://172.23.10.5:5555/api/bills/user/${widget.userId}'),
      );

      if (response.statusCode == 200) {
        setState(() {
          bills = json.decode(response.body);
          isLoading = false;
        });
      } else if (response.statusCode == 204) {
        setState(() {
          bills = [];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load bills');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching bills: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (bills.isEmpty) {
      return const Center(
        child: Text(
          "Hakuna bill zilizopatikana.",
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ListView.builder(
        itemCount: bills.length,
        itemBuilder: (context, index) {
          final bill = bills[index];

          // Safisha data, tumia '' kama kuna null
          final billName = bill['billName'] ?? 'No Name';
          final description = bill['description'] ?? 'No Description';
          final amount = bill['amount'] != null ? bill['amount'].toString() : '0';
          final createdDate = bill['createdDate'] ?? '';

          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    billName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Amount: TZS $amount",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                  if (createdDate.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(
                      "Date: $createdDate",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
