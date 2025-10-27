import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;


import '../model/ClassSubStudentModel.dart';
import '../model/create_remark_body.dart';
import '../model/remark.dart';
import '../model/remark_attachment.dart';

class RemarkService {
  final Dio apiClient;
  final String baseUrl;
  RemarkService(this.apiClient, this.baseUrl);

  Future<List<Remark>> getRemarks({
    required String academicYr,
    required String regId,
    required String shortName,
  }) async {
    final res = await apiClient.post(
      '${baseUrl}AdminApi/get_remark_teacherwise',
      data: {
        'app_version': '1.70',
        'academic_yr': academicYr,
        'reg_id': regId,
        'login_type': 'T',
        'short_name': shortName,
      },
    );

    if (res.statusCode == 200 && res.data['status'] == true) {
      return (res.data['remark'] as List)
          .map((e) => Remark.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<List<ClassSection>> getClassSections(String academicYr, String regId, String shortName) async {
    final res = await apiClient.post(
      '${baseUrl}AdminApi/getClassAndSection_teacheralloted',
      data: {
        'academic_yr': academicYr,
        'reg_id': regId,
        'short_name': shortName,
      },
    );
    if (res.statusCode == 200 && res.data['status'] == true) {
      return (res.data['class_name'] as List)
          .map((e) => ClassSection.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<List<Subject>> getSubjects(String academicYr, String regId, String classId, String sectionId, String shortName) async {
    final res = await apiClient.post(
      '${baseUrl}AdminApi/get_subject_alloted_to_teacher_by_class',
      data: {
        'academic_yr': academicYr,
        'reg_id': regId,
        'class_id': classId,
        'section_id': sectionId,
        'short_name': shortName,
      },
    );
    if (res.statusCode == 200 && res.data['status'] == true) {
      return (res.data['subject_name'] as List)
          .map((e) => Subject.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<List<Student>> getStudents(String academicYr, String classId, String sectionId, String shortName) async {
    final res = await apiClient.post(
      '${baseUrl}AdminApi/get_students',
      data: {
        'academic_yr': academicYr,
        'class_id': classId,
        'section_id': sectionId,
        'short_name': shortName,
      },
    );
    if (res.statusCode == 200 && res.data['status'] == true) {
      return (res.data['students'] as List)
          .map((e) => Student.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<bool> uploadRemarkDocument({
    required String studentIds,
    required String shortName,
    required List<int> fileBytes,
    required String uploadDate,
    required String filename,

  }) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/upload_remark_files',
        data: FormData.fromMap({
          'student_id': studentIds,
          'short_name': shortName,
          'datafile': base64Encode(fileBytes),
          'upload_date': uploadDate,
          'doc_type_folder': "remark",
          'filename': filename,

        }),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data is String
            ? json.decode(response.data)   // in some setups, Dio returns a String
            : response.data;
        return jsonResponse['status'] == true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  /// Delete a file/attachment for a Remark
  Future<bool> deleteRemarkDocument({
    required String upload_date,
    required String student_id,
    required String shortName,
    required String filename,
  }) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/delete_uploaded_remark_files',
        data: FormData.fromMap({
          'upload_date': upload_date,
          'student_id': student_id,
          'short_name': shortName,
          'filename': filename,
          'doc_type_folder': "remark",
        }),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data is String
            ? json.decode(response.data)
            : response.data;
        return jsonResponse['status'] == true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }




  Future<Map<String, dynamic>> createRemark({
    required String academicYr,
    required String teacherId,
    required String sectionId,
    required String classId,
    required String subjectId,
    required String fileName,
    required String studentIds,
    required String remarkDesc,
    required String remarkSubject,
    required String remarkDate,
    required String shortName,
    required String remarkType,
  }) async {
    final res = await apiClient.post(
      '${baseUrl}AdminApi/remark',
      data: {
        'academic_yr': academicYr,
        'teacher_id': teacherId,
        'section_id': sectionId,
        'class_id': classId,
        if(subjectId == null)
        'subject_id': '0' else
          'subject_id': subjectId,

        'filename': fileName,
        'student_id': studentIds, // send as List<String>
        'remark_desc': remarkDesc,
        'publish': 'N',
        'remark_subject': remarkSubject,
        'remark_date': remarkDate,
        'login_type': 'T',
        'operation': 'create',
        'short_name': shortName,
        'remark_type': remarkType,
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
        responseType: ResponseType.plain, // <--- for debugging
      ),
    );

    print("Status: ${res.statusCode}");
    print("Raw Response: ${res.data}");

    // Properly decode the plain text JSON string to a Map
    final data = res.data is String ? json.decode(res.data) : res.data;

    return data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateRemark({
    required String app_version,
    required String remarkId,
    required String remarkSubject,
    required String remarkDesc,
    required String remarkDate,
    required String academicYr,
    required String teacherId,
    required String shortName,
    required String classId,
    required String sectionId,
    required String subjectId,
    required String studentId,
    required String remarkType,
    required String publish,
    required String acknowledge,
    String fileName = "",           // Make optional with default ""
    String deleteFiles = "",
  }) async {
    final url = Uri.parse('${baseUrl}AdminApi/remark');

    final params = {
      "app_version": app_version,
      "academic_yr": academicYr,
      "teacher_id": teacherId,
      "section_id": sectionId,
      "class_id": classId,
      "subject_id": subjectId,
      "student_id": studentId,
      "remark_id": remarkId,
      "remark_desc": remarkDesc,
      "remark_subject": remarkSubject,
      "publish": publish,
      "acknowledge": acknowledge,
      "remark_date": remarkDate,
      "login_type": "T",
      "operation": "edit",
      "short_name": shortName,
      "remark_type": remarkType,
      if (fileName.isNotEmpty) "filename": fileName,      // Only include if not empty!
      if (deleteFiles.isNotEmpty) "deleteimagelist": deleteFiles,
    };

    print("UPDATE REMARK PARAMS: $params");

    try {
      final response = await http.post(url, body: params);
      print("Update Remark Status: ${response.statusCode}");
      print("Update Remark Raw Response: ${response.body}");

      final rawResponse = response.body.toString();
      final startIndex = rawResponse.indexOf("{");
      if (startIndex == -1) {
        throw Exception("No JSON found in response");
      }

      final jsonPart = rawResponse.substring(startIndex);
      final result = json.decode(jsonPart) as Map<String, dynamic>;
      return result;
    } catch (e, st) {
      print("❌ Error parsing updateRemark response: $e");
      print(st);
      return {
        "status": false,
        "error_msg": "Failed to update remark: $e",
      };
    }
  }

  Future<Map<String, dynamic>> updateRemarkFromPayload(Map<String, dynamic> payload) async {
    final res = await apiClient.post(
      '${baseUrl}AdminApi/remark',
      data: payload,
      options: Options(
        headers: {"Content-Type": "application/json"},
        responseType: ResponseType.plain,
      ),
    );

    print("Update Remark Status: ${res.statusCode}");
    print("Update Remark Raw Response: ${res.data}");

    final data = res.data is String ? json.decode(res.data) : res.data;
    return data as Map<String, dynamic>;
  }


  Future<List<RemarkAttachment>> getRemarkImages({
    required String remarkId,
    required String remarkDate,
    required String shortName,
  }) async {
    final res = await apiClient.post(
      '${baseUrl}AdminApi/get_images_remark',
      data: {
        'remark_id': remarkId,
        'remark_date': remarkDate,
        'short_name': shortName,
      },
    );
    if (res.statusCode == 200 && res.data['status'] == true) {
      final List attachments = res.data['images'];
      final url = res.data['url'] as String? ?? "";
      // You can return both as a tuple if you need the base url
      return attachments.map((e) => RemarkAttachment.fromJson({...e, "url": url})).toList();
    }
    return [];
  }

  Future<Map<String, dynamic>> deleteRemark({
    required String remarkId,
    required String academicYr,
    required String teacherId,
    required String classId,
    required String sectionId,
    required String subjectId,
    required String remarkDesc,
    required String studentId,
    required String remarkDate,
    required String remarkSubject,
    required String shortName,
  }) async {
    try {
      final res = await apiClient.post(
        '${baseUrl}AdminApi/remark',
        data: {
          'remark_id': remarkId,
          'publish': 'N',
          'acknowledge': 'N',
          'operation': 'delete',
          'login_type': 'T',
          'academic_yr': academicYr,
          'teacher_id': teacherId,
          'class_id': classId,
          'section_id': sectionId,
          'subject_id': subjectId,
          'remark_desc': remarkDesc,
          'student_id': studentId,
          'remark_date': remarkDate,
          'remark_subject': remarkSubject,
          'short_name': shortName,
        },
        options: Options(
          headers: {"Content-Type": "application/json"},
          responseType: ResponseType.plain, // get raw response
        ),
      );

      print("Delete Remark Status: ${res.statusCode}");
      print("Delete Remark Response: ${res.data}");

      // 🔹 Extract only JSON part from response
      String raw = res.data.toString();
      final jsonStart = raw.indexOf('{');
      final jsonEnd = raw.lastIndexOf('}');
      if (jsonStart != -1 && jsonEnd != -1) {
        final cleanJson = raw.substring(jsonStart, jsonEnd + 1);
        return json.decode(cleanJson);
      }

      return {"status": false, "error_msg": "Invalid server response"};
    } catch (e) {
      print("Delete Remark Error: $e");
      return {"status": false, "error_msg": e.toString()};
    }
  }



  Future<Map<String, dynamic>> publishRemark({
    required String remarkId,
    required String teacherId,
    required String studentId,
    required String shortName,
    String publish = "Y",
    String operation = "publish",
    String loginType = "T",
  }) async {
    final res = await apiClient.post(
      '${baseUrl}AdminApi/remark',
      data: {
        'remark_id': remarkId,
        'publish': publish,
        'operation': operation,
        'login_type': loginType,
        'teacher_id': teacherId,
        'student_id': studentId,
        'short_name': shortName,
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
        responseType: ResponseType.plain,
      ),
    );

    print("Publish Remark Status: ${res.statusCode}");
    print("Publish Remark Raw Response: ${res.data}");

    // Parse the response if it's JSON
    if (res.data is String) {
      try {
        return json.decode(res.data);
      } catch (e) {
        return {'status': false, 'error': 'Failed to parse response: $e'};
      }
    }

    return res.data;
  }


  Future<bool> euploadRemarkDocument({
    // required String academicYr,
    required String studentIds,
    required String shortName,
    required String filename,
    required Uint8List fileBytes,
    required String uploadDate,
    required String academicYr,
    required String teacherId,
    required String remarkId,

  }) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/upload_remark_files',
        data: FormData.fromMap({
          // 'acd_yr': academicYr,
          'student_id': remarkId,
          'short_name': shortName,
          'datafile': base64Encode(fileBytes),
          'upload_date': uploadDate,
          'doc_type_folder': "remark",
          'filename': filename,

        }),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data is String
            ? json.decode(response.data)   // in some setups, Dio returns a String
            : response.data;
        return jsonResponse['status'] == true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> edeleteRemarkDocument({
    required String upload_date,
    required String short_name,
    required String filename,
    required String student_id, // This should contain the remark ID, not student ID
  }) async {
    try {
      // Create the exact same parameters as your Java code
      final params = {
        "upload_date": upload_date,
        "short_name": short_name,
        "doc_type_folder": "remark",
        "filename": filename,
        "student_id": student_id, // This should be the remark ID wrapped in array format
      };

      print("🗑️ DELETE API PARAMS:");
      print("  upload_date: $upload_date");
      print("  short_name: $short_name");
      print("  filename: $filename");
      print("  student_id: $student_id");

      final response = await apiClient.post(
        '${baseUrl}AdminApi/delete_uploaded_remark_files',
        data: params,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      print("✅ DELETE RESPONSE:");
      print("  Status: ${response.statusCode}");
      print("  Headers: ${response.headers}");
      print("  Data Type: ${response.data.runtimeType}");
      print("  Data: ${response.data}");

      if (response.statusCode == 200) {
        // Handle different response types
        dynamic responseData = response.data;

        // If response is a string, try to parse it as JSON
        if (responseData is String) {
          if (responseData.isEmpty) {
            print("⚠️ Empty response from server");
            return false;
          }

          try {
            responseData = json.decode(responseData);
          } catch (e) {
            print("⚠️ Response is not JSON: $responseData");
            // Check if it contains success indicators
            if (responseData.toLowerCase().contains('success') ||
                responseData.toLowerCase().contains('true')) {
              return true;
            }
            return false;
          }
        }

        // Handle parsed JSON
        if (responseData is Map<String, dynamic>) {
          return responseData['status'] == true ||
              responseData['success'] == true ||
              (responseData['message']?.toString().toLowerCase().contains('success') ?? false);
        }

        return false;
      } else {
        print("❌ Non-200 status code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("❌ DELETE ERROR: $e");
      if (e is DioError) {
        print("Dio Error Type: ${e.type}");
        print("Dio Error Message: ${e.message}");
        print("Dio Error Response: ${e.response?.data}");
        print("Dio Error Stack: ${e.stackTrace}");

        // Handle specific Dio error types
        if (e.type == DioErrorType.connectionTimeout ||
            e.type == DioErrorType.receiveTimeout ||
            e.type == DioErrorType.sendTimeout) {
          print("⏰ Timeout error");
        } else if (e.type == DioErrorType.badResponse) {
          print("📉 Bad response error");
          // The server responded with a non-200 status code
          if (e.response != null) {
            print("Response status: ${e.response!.statusCode}");
            print("Response data: ${e.response!.data}");
          }
        }
      }
      return false;
    }
  }

  // Experment

  Future<bool> NuploadRemarkDocument({
    required String studentIds,
    required String shortName,
    required String filename,
    required List<int> fileBytes,
    required String uploadDate,
  }) async {
    try {
      final formData = FormData.fromMap({
        'student_id': studentIds,
        'short_name': shortName,
        'filename': filename,
        'datafile': MultipartFile.fromBytes(fileBytes, filename: filename),
        'upload_date': uploadDate,
        'doc_type_folder': 'remark',
      });

      final response = await apiClient.post(
        '${baseUrl}AdminApi/upload_remark_files',
        data: formData,
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data is String
            ? json.decode(response.data)
            : response.data;
        return jsonResponse['status'] == true;
      }
      return false;
    } catch (e) {
      print("Upload error: $e");
      return false;
    }
  }

  Future<bool> NdeleteRemarkDocument({
    required String upload_date,
    required String student_id,
    required String shortName,
    required String filename,
  }) async {
    try {
      final params = {
        "upload_date": upload_date,
        "short_name": shortName,
        "doc_type_folder": "remark",
        "filename": filename,
        "student_id": student_id,
      };

      final response = await apiClient.post(
        '${baseUrl}AdminApi/delete_uploaded_remark_files',
        data: params,
        options: Options(
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data is String
            ? json.decode(response.data)
            : response.data;
        return jsonResponse['status'] == true;
      } else {
        return false;
      }
    } catch (e) {
      print("❌ DELETE ERROR: $e");
      return false;
    }
  }

  Future<Map<String, dynamic>> NcreateRemark(CreateRemarkBody body) async {
    List<String> filenames = [];

    // Upload files first (similar to homework)
    if (body.files.isNotEmpty) {
      for (var file in body.files) {
        final success = await NuploadRemarkDocument(
          studentIds: body.studentIds,
          shortName: body.shortName,
          filename: file.name,
          fileBytes: file.bytes!,
          uploadDate: body.remarkDate,
        );

        if (!success) {
          return {'status': false, 'error_msg': 'Failed to upload file ${file.name}'};
        }
        filenames.add(file.name);
      }
    }

    try {
      final params = {
        ...body.toJson(),
        if (filenames.isNotEmpty) "filename": jsonEncode(filenames),
        if (body.deleteimagelist.isNotEmpty)
          "deleteimagelist": jsonEncode(body.deleteimagelist),
      };

      final response = await apiClient.post(
        '${baseUrl}AdminApi/remark',
        data: FormData.fromMap(params),
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data is String
            ? json.decode(response.data)
            : response.data;
        return jsonResponse;
      } else {
        return {'status': false, 'error_msg': 'Server error: ${response.statusCode}'};
      }
    } catch (e) {
      return {'status': false, 'error_msg': 'Error: $e'};
    }
  }

// Add updateRemark method
  Future<Map<String, dynamic>> NupdateRemark(CreateRemarkBody body) async {
    List<String> filenames = [];

    // Upload new files
    if (body.files.isNotEmpty) {
      for (var file in body.files) {
        final success = await NuploadRemarkDocument(
          studentIds: body.studentIds,
          shortName: body.shortName,
          filename: file.name,
          fileBytes: file.bytes!,
          uploadDate: body.remarkDate,
        );

        if (!success) {
          return {'status': false, 'error_msg': 'Failed to upload file ${file.name}'};
        }
        filenames.add(file.name);
      }
    }

    try {
      final params = {
        ...body.toJson(),
        'operation': 'edit', // Change operation for update
        if (filenames.isNotEmpty) "filename": jsonEncode(filenames),
        if (body.deleteimagelist.isNotEmpty)
          "deleteimagelist": jsonEncode(body.deleteimagelist),
      };

      final response = await apiClient.post(
        '${baseUrl}AdminApi/remark',
        data: FormData.fromMap(params),
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data is String
            ? json.decode(response.data)
            : response.data;
        return jsonResponse;
      } else {
        return {'status': false, 'error_msg': 'Server error: ${response.statusCode}'};
      }
    } catch (e) {
      return {'status': false, 'error_msg': 'Error: $e'};
    }
  }

}
