class Students {
  // All fields with null safety
  final String? studentId;
  final String? academicYr;
  final String? parentId;
  final String? firstName;
  final String? midName;
  final String? lastName;
  final String? studentName;
  final String? dob;
  final String? gender;
  final String? admissionDate;
  final String? studIdNo;
  final String? motherTongue;
  final String? birthPlace;
  final String? admissionClass;
  final String? rollNo;
  final String? classId;
  final String? sectionId;
  final String? feesPaid;
  final String? bloodGroup;
  final String? religion;
  final String? caste;
  final String? subcaste;
  final String? transportMode;
  final String? vehicleNo;
  final String? busId;
  final String? emergencyName;
  final String? emergencyContact;
  final String? emergencyAdd;
  final String? height;
  final String? weight;
  final String? hasSpecs;
  final String? allergies;
  final String? nationality;
  final String? currentAddress;
  final String? permantAdd;
  final String? city;
  final String? state;
  final String? pincode;
  final String? isDelete;
  final String? prevYearStudentId;
  final String? isPromoted;
  final String? isNew;
  final String? isModify;
  final String? isActive;
  final String? regNo;
  final String? house;
  final String? stuAadhaarNo;
  final String? category;
  final String? lastDate;
  final String? slcNo;
  final String? slcIssueDate;
  final String? leavingRemark;
  final String? deletedDate;
  final String? deletedBy;
  final String? createdBy;
  final String? updatedBy;
  final String? imageName;
  final String? guardianName;
  final String? guardianAdd;
  final String? guardianMobile;
  final String? relation;
  final String? guardianImageName;
  final String? udisePenNo;
  final String? apaarId;
  final String? addedBkDate;
  final String? addedBy;
  final String? createdAt;
  final String? updatedAt;

  // Attendance-specific fields (may be null initially)
  final String? attendanceId;
  final String? unqId;
  final String? teacherId;
  final String? date;
  final String? attendanceStatus;
  final String? onlyDate;
  final String? markAttendance;
  final String? deleteBtn;

  Students({
    this.studentId,
    this.academicYr,
    this.parentId,
    this.firstName,
    this.midName,
    this.lastName,
    this.studentName,
    this.dob,
    this.gender,
    this.admissionDate,
    this.studIdNo,
    this.motherTongue,
    this.birthPlace,
    this.admissionClass,
    this.rollNo,
    this.classId,
    this.sectionId,
    this.feesPaid,
    this.bloodGroup,
    this.religion,
    this.caste,
    this.subcaste,
    this.transportMode,
    this.vehicleNo,
    this.busId,
    this.emergencyName,
    this.emergencyContact,
    this.emergencyAdd,
    this.height,
    this.weight,
    this.hasSpecs,
    this.allergies,
    this.nationality,
    this.currentAddress,
    this.permantAdd,
    this.city,
    this.state,
    this.pincode,
    this.isDelete,
    this.prevYearStudentId,
    this.isPromoted,
    this.isNew,
    this.isModify,
    this.isActive,
    this.regNo,
    this.house,
    this.stuAadhaarNo,
    this.category,
    this.lastDate,
    this.slcNo,
    this.slcIssueDate,
    this.leavingRemark,
    this.deletedDate,
    this.deletedBy,
    this.createdBy,
    this.updatedBy,
    this.imageName,
    this.guardianName,
    this.guardianAdd,
    this.guardianMobile,
    this.relation,
    this.guardianImageName,
    this.udisePenNo,
    this.apaarId,
    this.addedBkDate,
    this.addedBy,
    this.createdAt,
    this.updatedAt,
    this.attendanceId,
    this.unqId,
    this.teacherId,
    this.date,
    this.attendanceStatus,
    this.onlyDate,
    this.markAttendance,
    this.deleteBtn,
  });

  factory Students.fromJson(Map<String, dynamic> json) {
    return Students(
      // Student fields from Laravel API
      studentId: json["student_id"]?.toString(),
      academicYr: json["academic_yr"]?.toString(),
      parentId: json["parent_id"]?.toString(),
      firstName: json["first_name"]?.toString() ?? "Unknown",
      midName: json["mid_name"]?.toString(),
      lastName: json["last_name"]?.toString() ?? "",
      studentName: json["student_name"]?.toString(),
      dob: json["dob"]?.toString(),
      gender: json["gender"]?.toString(),
      admissionDate: json["admission_date"]?.toString(),
      studIdNo: json["stud_id_no"]?.toString(),
      motherTongue: json["mother_tongue"]?.toString(),
      birthPlace: json["birth_place"]?.toString(),
      admissionClass: json["admission_class"]?.toString(),
      rollNo: json["roll_no"]?.toString(),
      classId: json["class_id"]?.toString(),
      sectionId: json["section_id"]?.toString(),
      feesPaid: json["fees_paid"]?.toString(),
      bloodGroup: json["blood_group"]?.toString(),
      religion: json["religion"]?.toString(),
      caste: json["caste"]?.toString(),
      subcaste: json["subcaste"]?.toString(),
      transportMode: json["transport_mode"]?.toString(),
      vehicleNo: json["vehicle_no"]?.toString(),
      busId: json["bus_id"]?.toString(),
      emergencyName: json["emergency_name"]?.toString(),
      emergencyContact: json["emergency_contact"]?.toString(),
      emergencyAdd: json["emergency_add"]?.toString(),
      height: json["height"]?.toString(),
      weight: json["weight"]?.toString(),
      hasSpecs: json["has_specs"]?.toString(),
      allergies: json["allergies"]?.toString(),
      nationality: json["nationality"]?.toString(),
      currentAddress: json["current_address"]?.toString(),
      permantAdd: json["permant_add"]?.toString(),
      city: json["city"]?.toString(),
      state: json["state"]?.toString(),
      pincode: json["pincode"]?.toString(),
      isDelete: json["IsDelete"]?.toString(),
      prevYearStudentId: json["prev_year_student_id"]?.toString(),
      isPromoted: json["isPromoted"]?.toString(),
      isNew: json["isNew"]?.toString(),
      isModify: json["isModify"]?.toString(),
      isActive: json["isActive"]?.toString() ?? "Y",
      regNo: json["reg_no"]?.toString(),
      house: json["house"]?.toString(),
      stuAadhaarNo: json["stu_aadhaar_no"]?.toString(),
      category: json["category"]?.toString(),
      lastDate: json["last_date"]?.toString(),
      slcNo: json["slc_no"]?.toString(),
      slcIssueDate: json["slc_issue_date"]?.toString(),
      leavingRemark: json["leaving_remark"]?.toString(),
      deletedDate: json["deleted_date"]?.toString(),
      deletedBy: json["deleted_by"]?.toString(),
      createdBy: json["created_by"]?.toString(),
      updatedBy: json["updated_by"]?.toString(),
      imageName: json["image_name"]?.toString(),
      guardianName: json["guardian_name"]?.toString(),
      guardianAdd: json["guardian_add"]?.toString(),
      guardianMobile: json["guardian_mobile"]?.toString(),
      relation: json["relation"]?.toString(),
      guardianImageName: json["guardian_image_name"]?.toString(),
      udisePenNo: json["udise_pen_no"]?.toString(),
      apaarId: json["apaar_id"]?.toString(),
      addedBkDate: json["added_bk_date"]?.toString(),
      addedBy: json["added_by"]?.toString(),
      createdAt: json["created_at"]?.toString(),
      updatedAt: json["updated_at"]?.toString(),

      // Attendance-specific fields (may be null)
      attendanceId: json["attendance_id"]?.toString(),
      unqId: json["unq_id"]?.toString(),
      teacherId: json["teacher_id"]?.toString(),
      date: json["date"]?.toString(),
      attendanceStatus: json["attendance_status"]?.toString(),
      onlyDate: json["only_date"]?.toString(),
      markAttendance: json["mark_attendance"]?.toString() ?? "0",
      deleteBtn: json["Delete_btn"]?.toString() ?? "0",
    );
  }

  Students copyWith({
    String? studentId,
    String? academicYr,
    String? parentId,
    String? firstName,
    String? midName,
    String? lastName,
    String? studentName,
    String? dob,
    String? gender,
    String? admissionDate,
    String? studIdNo,
    String? motherTongue,
    String? birthPlace,
    String? admissionClass,
    String? rollNo,
    String? classId,
    String? sectionId,
    String? feesPaid,
    String? bloodGroup,
    String? religion,
    String? caste,
    String? subcaste,
    String? transportMode,
    String? vehicleNo,
    String? busId,
    String? emergencyName,
    String? emergencyContact,
    String? emergencyAdd,
    String? height,
    String? weight,
    String? hasSpecs,
    String? allergies,
    String? nationality,
    String? currentAddress,
    String? permantAdd,
    String? city,
    String? state,
    String? pincode,
    String? isDelete,
    String? prevYearStudentId,
    String? isPromoted,
    String? isNew,
    String? isModify,
    String? isActive,
    String? regNo,
    String? house,
    String? stuAadhaarNo,
    String? category,
    String? lastDate,
    String? slcNo,
    String? slcIssueDate,
    String? leavingRemark,
    String? deletedDate,
    String? deletedBy,
    String? createdBy,
    String? updatedBy,
    String? imageName,
    String? guardianName,
    String? guardianAdd,
    String? guardianMobile,
    String? relation,
    String? guardianImageName,
    String? udisePenNo,
    String? apaarId,
    String? addedBkDate,
    String? addedBy,
    String? createdAt,
    String? updatedAt,
    String? attendanceId,
    String? unqId,
    String? teacherId,
    String? date,
    String? attendanceStatus,
    String? onlyDate,
    String? markAttendance,
    String? deleteBtn,
  }) {
    return Students(
      studentId: studentId ?? this.studentId,
      academicYr: academicYr ?? this.academicYr,
      parentId: parentId ?? this.parentId,
      firstName: firstName ?? this.firstName,
      midName: midName ?? this.midName,
      lastName: lastName ?? this.lastName,
      studentName: studentName ?? this.studentName,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      admissionDate: admissionDate ?? this.admissionDate,
      studIdNo: studIdNo ?? this.studIdNo,
      motherTongue: motherTongue ?? this.motherTongue,
      birthPlace: birthPlace ?? this.birthPlace,
      admissionClass: admissionClass ?? this.admissionClass,
      rollNo: rollNo ?? this.rollNo,
      classId: classId ?? this.classId,
      sectionId: sectionId ?? this.sectionId,
      feesPaid: feesPaid ?? this.feesPaid,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      religion: religion ?? this.religion,
      caste: caste ?? this.caste,
      subcaste: subcaste ?? this.subcaste,
      transportMode: transportMode ?? this.transportMode,
      vehicleNo: vehicleNo ?? this.vehicleNo,
      busId: busId ?? this.busId,
      emergencyName: emergencyName ?? this.emergencyName,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      emergencyAdd: emergencyAdd ?? this.emergencyAdd,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      hasSpecs: hasSpecs ?? this.hasSpecs,
      allergies: allergies ?? this.allergies,
      nationality: nationality ?? this.nationality,
      currentAddress: currentAddress ?? this.currentAddress,
      permantAdd: permantAdd ?? this.permantAdd,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
      isDelete: isDelete ?? this.isDelete,
      prevYearStudentId: prevYearStudentId ?? this.prevYearStudentId,
      isPromoted: isPromoted ?? this.isPromoted,
      isNew: isNew ?? this.isNew,
      isModify: isModify ?? this.isModify,
      isActive: isActive ?? this.isActive,
      regNo: regNo ?? this.regNo,
      house: house ?? this.house,
      stuAadhaarNo: stuAadhaarNo ?? this.stuAadhaarNo,
      category: category ?? this.category,
      lastDate: lastDate ?? this.lastDate,
      slcNo: slcNo ?? this.slcNo,
      slcIssueDate: slcIssueDate ?? this.slcIssueDate,
      leavingRemark: leavingRemark ?? this.leavingRemark,
      deletedDate: deletedDate ?? this.deletedDate,
      deletedBy: deletedBy ?? this.deletedBy,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      imageName: imageName ?? this.imageName,
      guardianName: guardianName ?? this.guardianName,
      guardianAdd: guardianAdd ?? this.guardianAdd,
      guardianMobile: guardianMobile ?? this.guardianMobile,
      relation: relation ?? this.relation,
      guardianImageName: guardianImageName ?? this.guardianImageName,
      udisePenNo: udisePenNo ?? this.udisePenNo,
      apaarId: apaarId ?? this.apaarId,
      addedBkDate: addedBkDate ?? this.addedBkDate,
      addedBy: addedBy ?? this.addedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      attendanceId: attendanceId ?? this.attendanceId,
      unqId: unqId ?? this.unqId,
      teacherId: teacherId ?? this.teacherId,
      date: date ?? this.date,
      attendanceStatus: attendanceStatus ?? this.attendanceStatus,
      onlyDate: onlyDate ?? this.onlyDate,
      markAttendance: markAttendance ?? this.markAttendance,
      deleteBtn: deleteBtn ?? this.deleteBtn,
    );
  }

  // Helper getters for UI
  String get fullName => "$firstName ${lastName ?? ""}".trim();

  bool get isPresent => attendanceStatus != "1";

  bool get isAbsent => attendanceStatus == "1";

  bool get isMarkedForAttendance => markAttendance == "1";

  bool get canDelete => deleteBtn == "1";

  bool get isActiveStudent => isActive == "Y";

  int get rollNumber => int.tryParse(rollNo ?? '0') ?? 0;
}