import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/features/auth/models/models.dart';
import 'package:teacherapp/features/homework/models/homework_publish_body.dart';
import '../models/models.dart';

class HomeworkService {
  final Dio apiClient;
  final String baseUrl;
  const HomeworkService(this.apiClient, this.baseUrl);

  Future<List<Homework>> getHomework(
    String regId,
    String year,
    String shortName,
  ) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/get_homework',
        data: FormData.fromMap({
          "acd_yr": year,
          "reg_id": regId,
          "short_name": shortName,
        }),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        if (jsonResponse['status'] == true) {
          final List<dynamic> data = jsonResponse['homework_details'];
          return data.map((item) => Homework.fromJson(item)).toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load Homework Deatils');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<int> getCommentCount(String homeworkId) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/get_count_of_homework_comments',
        data: FormData.fromMap({
          "homework_id": homeworkId,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        if (jsonResponse['status'] == true) {
          return jsonResponse['comment_count'] ?? 0;
        } else {
          return 0;
        }
      } else {
        throw Exception('Failed to load comment count');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> createHomework(CreateHomeworkBody b) async {
    List<String> filename = [];
    final rand = Random().nextInt(100).toString();
    if (b.files.isNotEmpty) {
      for (var file in b.files) {
        final x = UploadDocBody.fromJson({
          ...b.toJson(),
          "filename": file.name,
          "random_no": rand,
          "homework_id": b.homeworkId,
          "datafile": base64Encode(file.bytes!),
          "upload_date":
              "${DateTime.parse(b.startDate!).day.toString().padLeft(2, '0')}-${DateTime.parse(b.startDate!).month.toString().padLeft(2, '0')}-${DateTime.parse(b.startDate!).year}",
        });
        final doc = await uploadDocuments(x);
        if (!doc) return false;
        filename.add(x.filename!);
      }
    }
    try {
      final d = b.copyWith(operation: 'create').toJson();
      final x = {
        ...d,
        "random_no": rand,
        if (filename.isNotEmpty)
          "filename": jsonEncode(filename), // ["one.jpg"]
        if (b.deleteimagelist.isNotEmpty)
          "deleteimagelist": jsonEncode(b.deleteimagelist),
      };

      final response = await apiClient.post(
        '${baseUrl}AdminApi/homework',
        data: FormData.fromMap(x),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        if (jsonResponse['status'] == true) {
          return true;
        } else {
          return false;
        }
      } else {
        return true;
      }
    } catch (e) {
      return true;
    }
  }

  Future<bool> publishHomework(HomeworkPublishBody b) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/homework',
        data: FormData.fromMap(b.toJson()),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        return jsonResponse['status'] == true;
      } else {
        throw Exception('Failed to publish homework');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }


  Future<List<Subject>> getSubjects(SubjectsBody b) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/get_subject_alloted_to_teacher_by_class',
        data: FormData.fromMap(b
            .copyWith(
              academicYr: b.academicYr,
              // 'acd_yr': body.acdYr, //TODO REMEMBER TO CHANGE THIS
            )
            .toJson()),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        if (jsonResponse['status'] == true) {
          final List<dynamic> data = jsonResponse['subject_name'];
          return data.map((item) => Subject.fromJson(item)).toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load leave applications');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<MultiSub>> getMultiSubjects(MultiSubBody b) async {
    Utils.debLog({
      ...b.toJson(),
      "str_array": b.strArray.join("^"),
    });

    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/get_subject_alloted_to_teacher_by_multiple_class',
        data: FormData.fromMap({
          ...b.toJson(),
          "str_array":
              b.strArray.map((e) => '${e.classId}^${e.sectionId}').join(","),
        }),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        if (jsonResponse['status'] == true) {
          final List<dynamic> data = jsonResponse['subject_name'];
          return data.map((item) => MultiSub.fromJson(item)).toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load leave applications');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<ClassInfo>> getClass(
    String regId,
    String year,
    String shortName,
  ) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/getClassAndSection_teacheralloted',
        data: FormData.fromMap({
          "academic_yr": year, //TODO REMEMBER TOT CHANGE THIS
          "reg_id": regId,
          "short_name": shortName,
        }),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        if (jsonResponse['status'] == true) {
          final List<dynamic> data = jsonResponse['class_name'];
          return data.map((item) => ClassInfo.fromJson(item)).toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load leave applications');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> deleteHomeWork(HomeworkDeleteBody b) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/homework',
        data: FormData.fromMap(b.copyWith(loginType: 'T').toJson()),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        if (jsonResponse['status'] == true) {
          return true;
        } else {
          return false;
        }
      } else {
        throw Exception('Failed to load leave applications');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<HomeworkStudentStatus>> studentWithHomeworkStatus(
      HSStatusBody b) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/get_student_with_homework_status',
        data: FormData.fromMap(b.toJson()),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;

        final List<dynamic> data = jsonResponse['student_details'];
        return data
            .map((item) => HomeworkStudentStatus.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load leave applications');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> updateHomeWorkStatus(
    List<HomeworkStatus> data,
    String shortName,
  ) async {
    try {
      final jsonData = data
          .map((s) => {
                "homework_id": s.homeworkId,
                "student_id": s.studentId,
                "homework_status": s.homeworkStatus,
                "teachercomment": s.teachercomment ?? "",
                "short_name": shortName,
              })
          .toList();
      final d = FormData.fromMap({
        "short_name": shortName,
        "data": jsonEncode({"arraylist": jsonData}),
      });
      final response =
          await apiClient.post('${baseUrl}AdminApi/updateHomework', data: d);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Utils.debLog(e);
      return false;
    }
  }

  Future<List<HomeworkViewByParent>> getHomeWorkViews(
      HomeWorkViewBody b) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/get_students_homework_viewed',
        data: FormData.fromMap(b.toJson()),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;

        final List<dynamic> data = jsonResponse['student_list'];
        return data.map((item) => HomeworkViewByParent.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load leave applications');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> uploadDocuments(UploadDocBody document) async {
    try {

      Utils.debLog("Uploading document: ${document.filename}");

      final response = await apiClient.post(
        '${baseUrl}AdminApi/upload_files',
        data: FormData.fromMap(document.toJson()),
      );
      //   await Future.delayed(const Duration(seconds: 5));
      Utils.debLog("Document upload response: ${response.statusCode}, ${response.data}");
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        if (jsonResponse['status'] == true) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      Utils.debLog('Error in uploadDocuments: $e');
      return false;
    }
  }

  Future<DocHomework?> getDocument(DocHomeworkBody attachment) async {
    final response = await apiClient.post(
      '${baseUrl}AdminApi/get_images_homework',
      data: FormData.fromMap(attachment.toJson()),
    );
    if (response.statusCode == 200) {
      final jsonResponse = response.data;
      Utils.debLog(jsonResponse);
      if (jsonResponse['status'] == true) {
        return DocHomework.fromJson(jsonResponse);
      }
      return null;
    }
    return null;
  }

  Future<bool> updateHomework(CreateHomeworkBody b) async {
    List<String> filename = [];
    final rand = Random().nextInt(100).toString();

    // 1. Upload files first
    if (b.files.isNotEmpty) {
      for (var file in b.files) {
        try {
          final x = UploadDocBody.fromJson({
            ...b.toJson(),
            "random_no": b.homeworkId,
            "filename": file.name,
            "homework_id": b.homeworkId,
            "datafile": base64Encode(file.bytes!),
            "upload_date":
            "${DateTime.parse(b.startDate!).day.toString().padLeft(2, '0')}-${DateTime.parse(b.startDate!).month.toString().padLeft(2, '0')}-${DateTime.parse(b.startDate!).year}",
          });

          final doc = await uploadDocuments(x);

          if (!doc) {
            Utils.debLog("Failed to upload file: ${file.name}");
            return false; // File upload failed
          }
          filename.add(x.filename!);
        } catch (e) {
          Utils.debLog('Error uploading file ${file.name}: $e');
          return false; // File upload error
        }
      }
    }

    Utils.debLog("Uploaded files: $filename");

    // 2. Update homework record
    try {
      final d = b.copyWith(operation: 'edit').toJson();
      final x = {
        ...d,
        "random_no": rand,
        if (filename.isNotEmpty) "filename": jsonEncode(filename),
        if (b.deleteimagelist.isNotEmpty) "deleteimagelist": jsonEncode(b.deleteimagelist),
      };

      Utils.debLog("Homework update payload: $x");

      final response = await apiClient.post(
        '${baseUrl}AdminApi/homework',
        data: FormData.fromMap(x),
      );

      Utils.debLog("API Response status: ${response.statusCode}");
      Utils.debLog("API Response data: ${response.data}");

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        if (jsonResponse['status'] == true) {
          return true;
        } else {
          Utils.debLog("API returned false status: ${jsonResponse}");
          return false;
        }
      } else {
        Utils.debLog("API returned non-200 status: ${response.statusCode}");
        return false; // Changed from true to false
      }
    } catch (e) {
      Utils.debLog('Error in homework update API call: $e');
      return false; // Changed from true to false
    }
  }

  Future<bool> deleteDocument(DeleteDocumentBody d) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/delete_uploaded_files',
        data: FormData.fromMap(d.toJson()),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        Utils.debLog(jsonResponse);
        return true;
      }
      return false;
    } catch (e) {
      return true;
    }
  }
}
