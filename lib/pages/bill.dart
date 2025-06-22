// bill.dart
import 'package:flutter/material.dart';
import 'package:my_project/models/billmodel.dart';
import '../pages/dashboard.dart';
import '../service/billservice.dart';

class Bill extends StatelessWidget {
  final String userId;

  const Bill({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Dashboard(
      child: FutureBuilder<List<BillModel>>(
        future: BillService.getBills(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No bills found'));
          }

          final bills = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bills.length,
            itemBuilder: (context, index) {
              final bill = bills[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildRow('Bill Name:', bill.billName),
                      const SizedBox(height: 10),
                      _buildRow('Bill Amount:', 'TZS ${bill.amount.toStringAsFixed(2)}'),
                      const SizedBox(height: 10),
                      _buildRow('Units Used:', '${bill.unit} m³'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        Text(value, style: const TextStyle(fontSize: 16, color: Colors.blueGrey)),
      ],
    );
  }
}
