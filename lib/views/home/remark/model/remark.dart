// In your remark.dart model file
class Remark {
  final String remarkId;
  final String remarkDesc;
  final String remarkSubject;
  final String remarkType;
  final String remarkDate;
  final String? publishDate;
  final String classId;
  final String sectionId;
  final String studentId;
  final String subjectId;
  final String teacherId;
  final String academicYr;
  final String publish;
  final String acknowledge;
  final String isDelete;
  final String? className;
  final String? secName;
  final String? subName;
  final String? firstName;
  final String? midName;
  final String? lastName;

  Remark({
    required this.remarkId,
    required this.remarkDesc,
    required this.remarkSubject,
    required this.remarkType,
    required this.remarkDate,
    this.publishDate,
    required this.classId,
    required this.sectionId,
    required this.studentId,
    required this.subjectId,
    required this.teacherId,
    required this.academicYr,
    required this.publish,
    required this.acknowledge,
    required this.isDelete,
    this.className,
    this.secName,
    this.subName,
    this.firstName,
    this.midName,
    this.lastName,
  });

  factory Remark.fromJson(Map<String, dynamic> json) => Remark(
    remarkId: json['remark_id'] ?? '',
    remarkDesc: json['remark_desc'] ?? '',
    remarkSubject: json['remark_subject'] ?? '',
    remarkType: json['remark_type'] ?? '',
    remarkDate: json['remark_date'] ?? '',
    publishDate: json['publish_date'],
    classId: json['class_id'] ?? '',
    sectionId: json['section_id'] ?? '',
    studentId: json['student_id'] ?? '',
    subjectId: json['subject_id'] ?? '',
    teacherId: json['teacher_id'] ?? '',
    academicYr: json['academic_yr'] ?? '',
    publish: json['publish'] ?? 'N',
    acknowledge: json['acknowledge'] ?? 'N',
    isDelete: json['isDelete'] ?? 'N',
    className: json['class_name'],
    secName: json['sec_name'],
    subName: json['sub_name'],
    firstName: json['first_name'],
    midName: json['middle_name'],
    lastName: json['last_name'],
  );

  // Helper method to check if remark is published
  bool get isPublished => publish == 'Y';

  // Helper method to check if remark is deleted
  bool get isDeleted => isDelete == 'Y';
}