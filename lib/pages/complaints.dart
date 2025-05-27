import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logging/logging.dart';

class Complaints extends StatefulWidget {
  const Complaints({super.key});

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController complaintNameController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  double? latitude;
  double? longitude;

  final Logger _logger = Logger('ComplaintsLogger');

  @override
  void initState() {
    super.initState();
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      // Output to console
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enable location services')),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permissions are denied')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permissions are permanently denied')),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (!mounted) return;

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Location tracked: $latitude, $longitude')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Complaint Form")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: fullNameController,
                  decoration: InputDecoration(labelText: 'Full Name'),
                ),
                TextFormField(
                  controller: complaintNameController,
                  decoration: InputDecoration(labelText: 'Complaint Name'),
                ),
                TextFormField(
                  controller: streetController,
                  decoration: InputDecoration(labelText: 'Street'),
                ),
                TextFormField(
                  controller: districtController,
                  decoration: InputDecoration(labelText: 'District'),
                ),
                TextFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _getCurrentLocation,
                  child: Text('Track Current Location'),
                ),
                if (latitude != null && longitude != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('Lat: $latitude, Lon: $longitude'),
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _logger.info('Full Name: ${fullNameController.text}');
                      _logger.info('Complaint Name: ${complaintNameController.text}');
                      _logger.info('Street: ${streetController.text}');
                      _logger.info('District: ${districtController.text}');
                      _logger.info('Phone Number: ${phoneNumberController.text}');
                      _logger.info('Latitude: $latitude');
                      _logger.info('Longitude: $longitude');

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Complaint submitted!')),
                      );
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
