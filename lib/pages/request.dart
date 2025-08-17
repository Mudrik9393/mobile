import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../pages/dashboard.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'constants.dart';

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

  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _requestNameController = TextEditingController();

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
      _locationDetails = 'Latitude: ${loc.latitude}, Longitude: ${loc.longitude}';
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

  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate()) return;

    final uri = Uri.parse("${Constants.baseUrl}/api/requests/create");
    final request = http.MultipartRequest('POST', uri);

    request.fields['fullName'] = _fullNameController.text;
    request.fields['phoneNumber'] = _phoneNumberController.text;
    request.fields['address'] = _addressController.text;
    request.fields['requestName'] = _requestNameController.text;
    request.fields['date'] = DateFormat('yyyy-MM-dd').format(DateTime.now());
    request.fields['message'] = '';
    request.fields['latitude'] = _locationData?.latitude?.toString() ?? '';
    request.fields['longitude'] = _locationData?.longitude?.toString() ?? '';

    if (_selectedFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'document',
        _selectedFile!.path,
        filename: basename(_selectedFile!.path),
      ));
    }

    try {
      final response = await request.send();
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          const SnackBar(content: Text('Request submitted successfully!')),
        );

        // Clear all form fields
        _fullNameController.clear();
        _phoneNumberController.clear();
        _addressController.clear();
        _requestNameController.clear();

        setState(() {
          _selectedFile = null;
          _locationDetails = null;
          _locationData = null;
        });

        // Refresh location
        _fetchLocation();
      } else {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(content: Text('Submission failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dashboard(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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

              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter full name' : null,
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter phone number';
                  }
                  final regex = RegExp(r'^[0-9]+$'); // digits only
                  if (!regex.hasMatch(value)) {
                    return 'Phone number must contain digits only';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter address' : null,
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: _requestNameController,
                decoration: const InputDecoration(
                  labelText: 'Request Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter request name' : null,
              ),
              const SizedBox(height: 20),

              if (_locationDetails != null)
                Text(
                  'Your current location:\n$_locationDetails',
                  style: const TextStyle(color: Colors.blue),
                )
              else
                const Center(child: CircularProgressIndicator()),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: _pickFile,
                icon: const Icon(Icons.upload_file),
                label: const Text("Upload File"),
              ),
              if (_selectedFile != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Selected file: ${_selectedFile!.path.split(Platform.pathSeparator).last}',
                    style: const TextStyle(color: Colors.green),
                  ),
                ),

              const SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  onPressed: _submitRequest,
                  child: const Text('Submit Request'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
