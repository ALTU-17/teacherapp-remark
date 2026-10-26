// lesson_plan_template_models.dart

import 'package:flutter/cupertino.dart';

class TemplateRecord {
  final int templateId;
  final int classId;
  final int subjectId;
  final int chapterId;
  final int regId;
  final String publish;
  final String academicYr;
  final String className;
  final String subject;
  final String chapter;
  final List<TemplateDetail> details;

  TemplateRecord({
    required this.templateId,
    required this.classId,
    required this.subjectId,
    required this.chapterId,
    required this.regId,
    required this.publish,
    required this.academicYr,
    required this.className,
    required this.subject,
    required this.chapter,
    required this.details,
  });

  bool get hasTemplate => details.isNotEmpty;

  static List<TemplateRecord> fromApiRows(List<dynamic> rows) {
    final grouped = <int, List<TemplateDetail>>{};
    final firstRows = <int, Map<String, dynamic>>{};

    for (final row in rows) {
      if (row is! Map<String, dynamic>) continue;
      final templateId = _asInt(row['les_pln_temp_id']);
      if (templateId == 0) continue;
      firstRows.putIfAbsent(templateId, () => row);
      grouped
          .putIfAbsent(templateId, () => [])
          .add(TemplateDetail.fromJson(row));
    }

    return firstRows.entries.map((entry) {
      final row = entry.value;
      return TemplateRecord(
        templateId: entry.key,
        classId: _asInt(row['class_id']),
        subjectId: _asInt(row['subject_id']),
        chapterId: _asInt(row['chapter_id']),
        regId: _asInt(row['reg_id']),
        publish: row['publish']?.toString() ?? '',
        academicYr: row['academic_yr']?.toString() ?? '',
        className: row['c_name']?.toString() ?? '',
        subject: row['sub_name']?.toString() ?? '',
        chapter: row['name']?.toString() ?? '',
        details: grouped[entry.key] ?? const [],
      );
    }).toList();
  }
}

class TemplateDetail {
  final int templateId;
  final int templateDetailsId;
  final int headingId;
  final String description;

  TemplateDetail({
    required this.templateId,
    required this.templateDetailsId,
    required this.headingId,
    required this.description,
  });

  factory TemplateDetail.fromJson(Map<String, dynamic> json) {
    return TemplateDetail(
      templateId: _asInt(json['les_pln_temp_id']),
      templateDetailsId:
          _asInt(json['les_pln_tempdetails_id'] ?? json['detail_id']),
      headingId: _asInt(json['lesson_plan_headings_id']),
      description: json['description']?.toString() ?? '',
    );
  }
}

class TemplateEditDetailsResult {
  final int templateId;
  final int classId;
  final int subjectId;
  final int chapterId;
  final String publish;
  final bool isUsed;
  final List<TemplateDetail> details;

  TemplateEditDetailsResult({
    required this.templateId,
    required this.classId,
    required this.subjectId,
    required this.chapterId,
    required this.publish,
    required this.isUsed,
    required this.details,
  });

  factory TemplateEditDetailsResult.fromJson(Map<String, dynamic> json) {
    final templateId = _asInt(json['les_pln_temp_id']);
    final details = json['details'];
    return TemplateEditDetailsResult(
      templateId: templateId,
      classId: _asInt(json['class_id']),
      subjectId: _asInt(json['subject_id']),
      chapterId: _asInt(json['chapter_id']),
      publish: json['publish']?.toString() ?? '',
      isUsed: json['is_used'] == true,
      details: details is List
          ? details.whereType<Map<String, dynamic>>().map((detail) {
              return TemplateDetail.fromJson({
                ...detail,
                'les_pln_temp_id': templateId,
              });
            }).toList()
          : const [],
    );
  }
}

class TemplateClass {
  final int classId;
  final String className;

  TemplateClass({required this.classId, required this.className});

  factory TemplateClass.fromJson(Map<String, dynamic> json) {
    return TemplateClass(
      classId: _asInt(json['class_id']),
      className: json['class_name']?.toString() ?? '',
    );
  }
}

class TemplateSubject {
  final int subjectId;
  final String name;

  TemplateSubject({required this.subjectId, required this.name});

  factory TemplateSubject.fromJson(Map<String, dynamic> json) {
    return TemplateSubject(
      subjectId: _asInt(json['sm_id']),
      name: json['name']?.toString() ?? '',
    );
  }
}

class TemplateChapter {
  final int chapterId;
  final int classId;
  final int subjectId;
  final String chapterNo;
  final String name;
  final String subSubject;

  TemplateChapter({
    required this.chapterId,
    required this.classId,
    required this.subjectId,
    required this.chapterNo,
    required this.name,
    required this.subSubject,
  });

  factory TemplateChapter.fromJson(Map<String, dynamic> json) {
    return TemplateChapter(
      chapterId: _asInt(json['chapter_id']),
      classId: _asInt(json['class_id']),
      subjectId: _asInt(json['subject_id']),
      chapterNo: json['chapter_no']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      subSubject: json['sub_subject']?.toString() ?? '',
    );
  }
}

class TemplateHeading {
  final int headingId;
  final String name;
  final int sequence;

  TemplateHeading({
    required this.headingId,
    required this.name,
    required this.sequence,
  });

  factory TemplateHeading.fromJson(Map<String, dynamic> json) {
    return TemplateHeading(
      headingId: _asInt(json['lesson_plan_headings_id']),
      name: json['name']?.toString() ?? '',
      sequence: _asInt(json['sequence']),
    );
  }
}

class TemplateLookupResult {
  final int status;
  final bool success;
  final bool isCreatedByRequestedUser;
  final String message;
  final List<TemplateDetail> details;

  TemplateLookupResult({
    required this.status,
    required this.success,
    required this.isCreatedByRequestedUser,
    required this.message,
    required this.details,
  });

  bool get hasTemplate => details.isNotEmpty;

  factory TemplateLookupResult.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return TemplateLookupResult(
      status: _asInt(json['status']),
      success: json['success'] == true,
      isCreatedByRequestedUser: json['isCreatedByRequestedUser'] == true,
      message: json['message']?.toString() ?? '',
      details: data is List
          ? data
              .whereType<Map<String, dynamic>>()
              .map(TemplateDetail.fromJson)
              .toList()
          : const [],
    );
  }
}

class TemplateFieldData {
  final int headingId;
  final String headingName;
  final TextEditingController controller;

  TemplateFieldData({
    required this.headingId,
    required this.headingName,
    required this.controller,
  });

  void dispose() => controller.dispose();
}

int _asInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}
