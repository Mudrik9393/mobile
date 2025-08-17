import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../pages/dashboard.dart';
import 'constants.dart'; // ← kuhakikisha Dashboard ipo

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
        Uri.parse('${Constants.baseUrl}/api/bills/user/${widget.userId}'),
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
    return Dashboard(
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : bills.isEmpty
              ? const Center(
                  child: Text(
                    "Hakuna bill zilizopatikana.",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 60.0, left: 16, right: 16, bottom: 20),
                    child: ListView.builder(
                      itemCount: bills.length,
                      itemBuilder: (context, index) {
                        final bill = bills[index];

                        final billName = bill['billName'] ?? 'No Name';
                        final description = bill['description'] ?? 'No Description';
                        final amount = bill['amount'] != null
                            ? bill['amount'].toString()
                            : '0';
                        final createdDate = bill['createdDate'] ?? '';

                        return Center(
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.95,
                            ),
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              margin: const EdgeInsets.only(
                                  top: 20, bottom: 20),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      billName,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Container(
                                      height: 1,
                                      width: 100,
                                      color: Colors.grey[300],
                                      margin:
                                          const EdgeInsets.only(bottom: 16),
                                    ),
                                    Text(
                                      description,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.grey[700],
                                        height: 1.4,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.green[50],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "TZS $amount",
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.green,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                    if (createdDate.isNotEmpty) ...[
                                      const SizedBox(height: 18),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.calendar_today,
                                            size: 18,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            createdDate,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
    );
  }
}
