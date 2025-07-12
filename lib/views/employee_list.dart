import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/employee_controller.dart';
import '../models/employee_model.dart';
import 'employee_detail.dart';
import 'add_employee.dart';

class EmployeeListScreen extends StatelessWidget {
  final controller = Get.put(EmployeeController());
  final searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF4E89AE);
    const Color backgroundColor = Color(0xFFF4F7FA);
    const Color secondaryText = Color(0xFF666666);

    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Exit"),
                content: const Text("Do you want to exit?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text("No"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text("Yes"),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: const Text(
              "Employee List",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          elevation: 2,
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: primaryColor,
          icon: const Icon(Icons.group_add_rounded, color: Colors.white),
          label: const Text(
            "Add Employee",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => Get.to(() => AddEmployeeScreen()),
        ),

        body: Container(
          padding: const EdgeInsets.all(16.0),
          color: backgroundColor,
          child: Column(
            children: [
              Obx(
                () => TextField(
                  controller: searchCtrl,
                  decoration: InputDecoration(
                    hintText: "Search employees",
                    prefixIcon: Icon(Icons.search, color: primaryColor),
                    suffixIcon: controller.searchQuery.value.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, color: primaryColor),
                            onPressed: () {
                              searchCtrl.clear();
                              controller.searchQuery.value = '';
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) => controller.searchQuery.value = value,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  var query = controller.searchQuery.value.toLowerCase();

                  var filtered = controller.employeeList.where((e) {
                    return e.name.toLowerCase().contains(query) ||
                        (e.position?.toLowerCase().contains(query) ?? false) ||
                        (e.department?.toLowerCase().contains(query) ?? false);
                  }).toList();

                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (filtered.isEmpty) {
                    return const Center(child: Text("No employees found"));
                  }

                  return ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      var emp = filtered[i];
                      return GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          barrierColor: Colors.black.withOpacity(0.2),
                          builder: (_) => EmployeeDetailPopup(employee: emp),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(14.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(emp.avatar),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      emp.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      emp.position ?? "No Position",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: secondaryText,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      emp.department ?? "No Department",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: secondaryText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
