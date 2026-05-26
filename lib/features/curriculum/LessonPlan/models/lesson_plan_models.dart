// lib/models/lesson_plan_models.dart

class ClassResponse {
  final int status;
  final String message;
  final List<ClassData> data;
  final bool success;

  ClassResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.success,
  });

  factory ClassResponse.fromJson(Map<String, dynamic> json) {
    return ClassResponse(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: (json['data'] as List?)?.map((e) => ClassData.fromJson(e)).toList() ?? [],
      success: json['success'] ?? false,
    );
  }
}

class ClassData {
  final int lessonPlanId;
  final int classId;
  final int sectionId;
  final String className;
  final String secName;

  ClassData({
    required this.lessonPlanId,
    required this.classId,
    required this.sectionId,
    required this.className,
    required this.secName,
  });

  factory ClassData.fromJson(Map<String, dynamic> json) {
    return ClassData(
      lessonPlanId: json['lesson_plan_id'] ?? 0,
      classId: json['class_id'] ?? 0,
      sectionId: json['section_id'] ?? 0,
      className: json['class_name'] ?? '',
      secName: json['sec_name'] ?? '',
    );
  }

  String get fullClassName => '$className $secName';
}

// Add this to your existing models file

class TeacherClassResponse {
  final int status;
  final String message;
  final List<TeacherClassData> data;
  final bool success;

  TeacherClassResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.success,
  });

  factory TeacherClassResponse.fromJson(Map<String, dynamic> json) {
    return TeacherClassResponse(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: (json['data'] as List?)?.map((e) => TeacherClassData.fromJson(e)).toList() ?? [],
      success: json['success'] ?? false,
    );
  }
}

class TeacherClassData {
  final int classId;
  final int sectionId;
  final String classname;
  final String sectionname;
  final String teachername;
  final int teacherId;
  final int isClassTeacher;

  TeacherClassData({
    required this.classId,
    required this.sectionId,
    required this.classname,
    required this.sectionname,
    required this.teachername,
    required this.teacherId,
    required this.isClassTeacher,
  });

  factory TeacherClassData.fromJson(Map<String, dynamic> json) {
    return TeacherClassData(
      classId: json['class_id'] ?? 0,
      sectionId: json['section_id'] ?? 0,
      classname: json['classname'] ?? '',
      sectionname: json['sectionname'] ?? '',
      teachername: json['teachername'] ?? '',
      teacherId: json['teacher_id'] ?? 0,
      isClassTeacher: json['is_class_teacher'] ?? 0,
    );
  }

  String get fullClassName => '$classname $sectionname';
}

class SubjectResponse {
  final int status;
  final String message;
  final List<SubjectData> data;
  final bool success;

  SubjectResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.success,
  });

  factory SubjectResponse.fromJson(Map<String, dynamic> json) {
    return SubjectResponse(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: (json['data'] as List?)?.map((e) => SubjectData.fromJson(e)).toList() ?? [],
      success: json['success'] ?? false,
    );
  }
}

class SubjectData {
  final int smId;
  final String name;

  SubjectData({
    required this.smId,
    required this.name,
  });

  factory SubjectData.fromJson(Map<String, dynamic> json) {
    return SubjectData(
      smId: json['sm_id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class SubSubjectResponse {
  final int status;
  final String message;
  final List<dynamic> data;
  final bool success;

  SubSubjectResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.success,
  });

  factory SubSubjectResponse.fromJson(Map<String, dynamic> json) {
    return SubSubjectResponse(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
      success: json['success'] ?? false,
    );
  }
}

class LessonPlanResponse {
  final List<LessonPlanData> data;

  LessonPlanResponse({
    required this.data,
  });

  factory LessonPlanResponse.fromJson(List<dynamic> json) {
    return LessonPlanResponse(
      data: json.map((e) => LessonPlanData.fromJson(e)).toList(),
    );
  }
}

class ChapterData {
  final int chapterId;
  final int classId;
  final int subjectId;
  final int chapterNo;
  final String name;

  ChapterData({
    required this.chapterId,
    required this.classId,
    required this.subjectId,
    required this.chapterNo,
    required this.name,
  });

  factory ChapterData.fromJson(Map<String, dynamic> json) {
    return ChapterData(
      chapterId: json['chapter_id'],
      classId: json['class_id'],
      subjectId: json['subject_id'],
      chapterNo: json['chapter_no'],
      name: json['name'] ?? '',
    );
  }
}

class ChapterResponse {
  final bool success;
  final List<ChapterData> data;
  final String message;
  final int status;

  ChapterResponse({
    required this.success,
    required this.data,
    required this.message,
    required this.status,
  });

  factory ChapterResponse.fromJson(Map<String, dynamic> json) {
    return ChapterResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List)
          .map((e) => ChapterData.fromJson(e))
          .toList(),
      message: json['message'] ?? '',
      status: json['status'] ?? 0,
    );
  }
}

class LessonPlanData {
  final int lessonPlanId;
  final int unqId;
  final int lesPlnTempId;
  final int classId;
  final int sectionId;
  final int subjectId;
  final int chapterId;
  final String noOfPeriods;
  final String weekDate;
  final int regId;
  final String academicYr;
  final String status;
  final String approve;
  final String remark;
  final String className;
  final String secName;
  final String subName;
  final int chapterNo;
  final String name;
  final dynamic subSubject;

  LessonPlanData({
    required this.lessonPlanId,
    required this.unqId,
    required this.lesPlnTempId,
    required this.classId,
    required this.sectionId,
    required this.subjectId,
    required this.chapterId,
    required this.noOfPeriods,
    required this.weekDate,
    required this.regId,
    required this.academicYr,
    required this.status,
    required this.approve,
    required this.remark,
    required this.className,
    required this.secName,
    required this.subName,
    required this.chapterNo,
    required this.name,
    required this.subSubject,
  });

  factory LessonPlanData.fromJson(Map<String, dynamic> json) {
    return LessonPlanData(
      lessonPlanId: json['lesson_plan_id'] ?? 0,
      unqId: json['unq_id'] ?? 0,
      lesPlnTempId: json['les_pln_temp_id'] ?? 0,
      classId: json['class_id'] ?? 0,
      sectionId: json['section_id'] ?? 0,
      subjectId: json['subject_id'] ?? 0,
      chapterId: json['chapter_id'] ?? 0,
      noOfPeriods: json['no_of_periods'] ?? '',
      weekDate: json['week_date'] ?? '',
      regId: json['reg_id'] ?? 0,
      academicYr: json['academic_yr'] ?? '',
      status: json['status'] ?? '',
      approve: json['approve'] ?? '',
      remark: json['remark'] ?? '',
      className: json['c_name'] ?? '',
      secName: json['secname'] ?? '',
      subName: json['sub_name'] ?? '',
      chapterNo: json['chapter_no'] ?? 0,
      name: json['name'] ?? '',
      subSubject: json['sub_subject'],
    );
  }

  String get fullClassName => '$className $secName';
}

class LessonPlanHeadingData {
  final int lesPlnTempId;
  final int classId;
  final int subjectId;
  final int chapterId;
  final int regId;
  final String publish;
  final String academicYr;
  final int lesPlnTempdetailsId;
  final int lessonPlanHeadingsId;
  String? description;
  final String headingName;

  LessonPlanHeadingData({
    required this.lesPlnTempId,
    required this.classId,
    required this.subjectId,
    required this.chapterId,
    required this.regId,
    required this.publish,
    required this.academicYr,
    required this.lesPlnTempdetailsId,
    required this.lessonPlanHeadingsId,
    this.description,
    required this.headingName,
  });

  factory LessonPlanHeadingData.fromJson(Map<String, dynamic> json) {
    return LessonPlanHeadingData(
      lesPlnTempId: json['les_pln_temp_id'],
      classId: json['class_id'],
      subjectId: json['subject_id'],
      chapterId: json['chapter_id'],
      regId: json['reg_id'],
      publish: json['publish'] ?? '',
      academicYr: json['academic_yr'] ?? '',
      lesPlnTempdetailsId: json['les_pln_tempdetails_id'],
      lessonPlanHeadingsId: json['lesson_plan_headings_id'],
      description: json['description'],
      headingName: json['heading_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'les_pln_temp_id': lesPlnTempId,
      'class_id': classId,
      'subject_id': subjectId,
      'chapter_id': chapterId,
      'reg_id': regId,
      'publish': publish,
      'academic_yr': academicYr,
      'les_pln_tempdetails_id': lesPlnTempdetailsId,
      'lesson_plan_headings_id': lessonPlanHeadingsId,
      'description': description,
      'heading_name': headingName,
    };
  }
}

class LessonPlanDetailsData {
  final String classId;
  final String sectionId;
  final String smId;
  final String chapterId;
  final List<LessonPlanHeadingData> lessonPlanInfo1;
  final bool presentData;
  final int unqId;
  final int lesPlnTempId;

  LessonPlanDetailsData({
    required this.classId,
    required this.sectionId,
    required this.smId,
    required this.chapterId,
    required this.lessonPlanInfo1,
    required this.presentData,
    required this.unqId,
    required this.lesPlnTempId,
  });

  factory LessonPlanDetailsData.fromJson(Map<String, dynamic> json) {
    return LessonPlanDetailsData(
      classId: json['class_id']?.toString() ?? '',
      sectionId: json['section_id']?.toString() ?? '',
      smId: json['sm_id']?.toString() ?? '',
      chapterId: json['chapter_id']?.toString() ?? '',
      lessonPlanInfo1: (json['lesson_plan_info1'] as List)
          .map((e) => LessonPlanHeadingData.fromJson(e))
          .toList(),
      presentData: json['present_data'] ?? false,
      unqId: json['unq_id'] ?? 0,
      lesPlnTempId: json['les_pln_temp_id'] ?? 0,
    );
  }
}

class LessonPlanHeadingNonDaily {
  final int lessonPlanHeadingsId;
  final String name;
  final int sequence;

  LessonPlanHeadingNonDaily({
    required this.lessonPlanHeadingsId,
    required this.name,
    required this.sequence,
  });

  factory LessonPlanHeadingNonDaily.fromJson(Map<String, dynamic> json) {
    return LessonPlanHeadingNonDaily(
      lessonPlanHeadingsId: json['lesson_plan_headings_id'],
      name: json['name'] ?? '',
      sequence: json['sequence'] ?? 0,
    );
  }
}

class LessonPlanHeadingNonDailyResponse {
  final bool success;
  final List<LessonPlanHeadingNonDaily> data;
  final String message;
  final int status;

  LessonPlanHeadingNonDailyResponse({
    required this.success,
    required this.data,
    required this.message,
    required this.status,
  });

  factory LessonPlanHeadingNonDailyResponse.fromJson(Map<String, dynamic> json) {
    return LessonPlanHeadingNonDailyResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List)
          .map((e) => LessonPlanHeadingNonDaily.fromJson(e))
          .toList(),
      message: json['message'] ?? '',
      status: json['status'] ?? 0,
    );
  }
}

class LessonPlanDetailsResponse {
  final int status;
  final LessonPlanDetailsData data;
  final bool success;

  LessonPlanDetailsResponse({
    required this.status,
    required this.data,
    required this.success,
  });

  factory LessonPlanDetailsResponse.fromJson(Map<String, dynamic> json) {
    return LessonPlanDetailsResponse(
      status: json['status'] ?? 0,
      data: LessonPlanDetailsData.fromJson(json['data']),
      success: json['success'] ?? false,
    );
  }
}