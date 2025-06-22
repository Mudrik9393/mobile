import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../pages/dashboard.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  final Location location = Location();
  LocationData? _locationData;
  String? _locationDetails;
  File? _selectedFile;

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        setState(() {
          _locationDetails = "GPS service not enabled.";
        });
        return;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        setState(() {
          _locationDetails = "Location permission denied.";
        });
        return;
      }
    }

    final loc = await location.getLocation();
    setState(() {
      _locationData = loc;
      _locationDetails =
          'Latitude: ${loc.latitude}, Longitude: ${loc.longitude}';
    });
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dashboard(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Image.asset(
                'assets/zawa_logo.png',
                height: 100,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Fill the form below to request a water connection:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            // Full Name
            const TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Phone Number
            const TextField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),

            // Address
            const TextField(
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Request Name
            const TextField(
              decoration: InputDecoration(
                labelText: 'Request Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Location display
            if (_locationDetails != null)
              Text(
                'Your current location:\n$_locationDetails',
                style: const TextStyle(color: Colors.blue),
              )
            else
              const CircularProgressIndicator(),

            const SizedBox(height: 20),

            // File upload
            ElevatedButton.icon(
              onPressed: _pickFile,
              icon: const Icon(Icons.upload_file),
              label: const Text("Upload File"),
            ),
            if (_selectedFile != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Selected file: ${_selectedFile!.path.split('/').last}',
                  style: const TextStyle(color: Colors.green),
                ),
              ),

            const SizedBox(height: 20),

            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: () {
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
