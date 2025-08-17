// billservice.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_project/models/billmodel.dart';

class BillService {
  static Future<List<BillModel>> getBills(String userId) async {
    final response = await http.get(
  Uri.parse('http://10.153.24.78:5555/api/bills/user/$userId'),
);


    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => BillModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load bills');
    }
  }
}
