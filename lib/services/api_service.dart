import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/employee_model.dart';

class ApiService {
  final String baseUrl =
      "https://669b3f09276e45187d34eb4e.mockapi.io/api/v1/employee";

  Future<List<Employee>> getEmployees() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      print("Response Body -- ${response.body}");
      return data.map((e) => Employee.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load employees");
    }
  }

  Future<bool> addEmployee(Map<String, dynamic> employeeData) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(employeeData),
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode == 201;
  }
}
