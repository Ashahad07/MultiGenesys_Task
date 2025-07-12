import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/employee_controller.dart';

class AddEmployeeScreen extends StatelessWidget {
  final nameCtrl = TextEditingController();
  final avatarCtrl = TextEditingController();
  final positionCtrl = TextEditingController();
  final departmentCtrl = TextEditingController();

  final controller = Get.find<EmployeeController>();

  @override
  Widget build(BuildContext context) {
    final themeColor = const Color(0xFF4E89AE);
    final backgroundColor = const Color(0xFFF4F7FA);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Employee",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: themeColor,
        elevation: 2,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputField("Name", nameCtrl, Icons.person, themeColor),
            const SizedBox(height: 20),
            _buildInputField("Avatar URL", avatarCtrl, Icons.image, themeColor),
            const SizedBox(height: 20),
            _buildInputField(
              "Position",
              positionCtrl,
              Icons.work_outline,
              themeColor,
            ),
            const SizedBox(height: 20),
            _buildInputField(
              "Department",
              departmentCtrl,
              Icons.apartment,
              themeColor,
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                onPressed: () {
                  controller.addEmployee({
                    "id": DateTime.now().millisecondsSinceEpoch.toString(),
                    "name": nameCtrl.text,
                    "avatar": avatarCtrl.text,
                    "position": positionCtrl.text,
                    "department": departmentCtrl.text,
                    "createdAt": DateTime.now().toIso8601String(),
                  });
                },
                icon: const Icon(Icons.add),
                label: Text(
                  "Add Employee",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: backgroundColor,
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller,
    IconData icon,
    Color themeColor,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: themeColor),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: themeColor.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: themeColor, width: 1.5),
        ),
        labelStyle: TextStyle(color: themeColor.withOpacity(0.8)),
      ),
      cursorColor: themeColor,
    );
  }
}
