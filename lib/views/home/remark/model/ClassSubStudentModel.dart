class Subject {
  final String subjectId;
  final String smId;
  final String name;

  Subject({
    required this.subjectId,
    required this.smId,
    required this.name,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    subjectId: json['subject_id'],
    smId: json['sm_id'],
    name: json['name'],
  );
}


class ClassSection {
  final String classId;
  final String sectionId;
  final String className;
  final String sectionName;

  ClassSection({
    required this.classId,
    required this.sectionId,
    required this.className,
    required this.sectionName,
  });

  factory ClassSection.fromJson(Map<String, dynamic> json) => ClassSection(
    classId: json['class_id'],
    sectionId: json['section_id'],
    className: json['classname'],
    sectionName: json['sectionname'],
  );
}



class Student {
  final String studentId;
  final String firstName;
  final String midName;
  final String lastName;

  Student({
    required this.studentId,
    required this.firstName,
    required this.midName,
    required this.lastName,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    studentId: json['student_id'],
    firstName: json['first_name'],
    midName: json['mid_name'] ?? "",
    lastName: json['last_name'] ?? "",
  );
}
