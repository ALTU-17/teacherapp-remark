// models/curriculum_role_info.dart
class CurriculumRoleInfo {
  final String? role;
  final String? deptId;

  CurriculumRoleInfo({this.role, this.deptId});

  factory CurriculumRoleInfo.fromJson(Map<String, dynamic> json) {
    return CurriculumRoleInfo(
      role: json['role'],
      deptId: json['department_id']?.toString(),
    );
  }
}