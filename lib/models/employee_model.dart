class Employee {
  final String id;
  final String name;
  final String avatar;
  final String emailId;
  final String mobile;
  final String country;
  final String state;
  final String district;
  final String? position;
  final String? department;
  final String createdAt;

  Employee({
    required this.id,
    required this.name,
    required this.avatar,
    required this.emailId,
    required this.mobile,
    required this.country,
    required this.state,
    required this.district,
    required this.position,
    required this.department,
    required this.createdAt,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      emailId: json['emailId'],
      mobile: json['mobile'],
      country: json['country'],
      state: json['state'],
      district: json['district'],
      position: json['position'],
      department: json['department'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "avatar": avatar,
      "emailId": emailId,
      "mobile": mobile,
      "country": country,
      "state": state,
      "district": district,
      "position": position,
      "department": department,
      "createdAt": createdAt,
    };
  }
}
