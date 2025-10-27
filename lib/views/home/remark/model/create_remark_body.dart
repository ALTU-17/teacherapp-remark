import 'package:form_builder_file_picker/form_builder_file_picker.dart';

class CreateRemarkBody {
  final String app_version;
  final String academicYr;
  final String teacherId;
  final String sectionId;
  final String classId;
  final String subjectId;
  final String fileName;
  final String studentIds;
  final String remarkDesc;
  final String remarkSubject;
  final String remarkDate;
  final String shortName;
  final String remarkType;
  final List<PlatformFile> files;
  final List<String> deleteimagelist;
  final String? remarkId; // Add this for edit mode

  CreateRemarkBody({
    required this.app_version,
    required this.academicYr,
    required this.teacherId,
    required this.sectionId,
    required this.classId,
    required this.subjectId,
    required this.fileName,
    required this.studentIds,
    required this.remarkDesc,
    required this.remarkSubject,
    required this.remarkDate,
    required this.shortName,
    required this.remarkType,
    required this.files,
    this.deleteimagelist = const [],
    this.remarkId,
  });

  // Add toJson method that matches Java format
  Map<String, dynamic> toJson() {
    final map = {
      'app_version': app_version,
      'academic_yr': academicYr,
      'teacher_id': teacherId,
      'section_id': sectionId,
      'class_id': classId,
      'subject_id': subjectId,
      'student_id': studentIds,
      'remark_desc': remarkDesc,
      'remark_subject': remarkSubject,
      'remark_date': remarkDate,
      'short_name': shortName,
      'remark_type': remarkType,
      'publish': 'N',
      'login_type': 'T',
      'operation': 'create',
    };

    if (fileName.isNotEmpty && fileName != "[]" && fileName != '[""]') {
      map['filename'] = fileName;
    }

    return map;
  }

}