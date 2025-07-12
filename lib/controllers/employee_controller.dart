import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/employee_model.dart';
import '../services/api_service.dart';

class EmployeeController extends GetxController {
  var employeeList = <Employee>[].obs;
  var isLoading = false.obs;
  var searchQuery = ''.obs;

  final ApiService _api = ApiService();

  @override
  void onInit() {
    fetchEmployees();
    super.onInit();
  }

  void fetchEmployees() async {
    isLoading(true);
    try {
      final employees = await _api.getEmployees();
      employeeList.assignAll(employees);
    } catch (e) {
        Fluttertoast.showToast(
          msg: "Failed to fetch employees $e",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: const Color(0xFFe53935),
          textColor: Colors.white,
          fontSize: 14.0,
        );
    } finally {
      isLoading(false);
    }
  }

  void addEmployee(Map<String, dynamic> data) async {
    bool success = await _api.addEmployee(data);
    if (success) {
      fetchEmployees();
      Get.back();
      Fluttertoast.showToast(msg: "Employee Added Successfully");
    } else {
      Fluttertoast.showToast(msg: "Failed to add employee");
    }
  }
}
