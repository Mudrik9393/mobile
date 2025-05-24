import 'package:flutter/material.dart';

class Request extends StatelessWidget {
  const Request({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Connection Request'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fill the form below to request a water connection:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            const TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            const TextField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),

            const TextField(
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  // You can add logic to handle submission here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Request submitted!')),
                  );
                },
                child: const Text('Submit Request'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
