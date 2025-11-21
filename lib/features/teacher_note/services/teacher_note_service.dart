import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/features/auth/models/models.dart';
import '../../homework/models/models.dart';
import '../models/models.dart';

class TeacherNoteService {
  final Dio apiClient;
  final String baseUrl;
  const TeacherNoteService(this.apiClient, this.baseUrl);

  // In your TeacherNoteService class, add these methods:

  Future<bool> uploadTeacherNoteDocument({
    required String random_no,
    required String shortName,
    required List<int> fileBytes,
    required String uploadDate,
    required String filename,
  }) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/upload_files',
        data: FormData.fromMap({
          'random_no': random_no,
          'short_name': shortName,
          'datafile': base64Encode(fileBytes),
          'upload_date': uploadDate,
          'doc_type_folder': "daily_notes",
          'filename': filename,
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

  Future<bool> deleteTeacherNoteDocument({
    required String random_no,
    required String uploadDate,
    required String classId,
    required String sectionId,
    required String shortName,
    required String filename,
  }) async {
    try {
      final params = {
        "random_no": random_no,
        "upload_date": uploadDate,
        "short_name": shortName,
        "doc_type_folder": "daily_notes",
        "filename": filename,
      };

      final response = await apiClient.post(
        '${baseUrl}AdminApi/delete_uploaded_files',
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
      return false;
    }
  }

  Future<Map<String, dynamic>> createNoteWithFiles(CreateNoteBody body) async {
    List<String> filenames = [];

    // Upload files FIRST using the same random number
    if (body.files.isNotEmpty) {
      for (var file in body.files) {
        String classId = '';
        String sectionId = '';

        if (body.strArray != null && body.strArray!.contains('^')) {
          final parts = body.strArray!.split('^');
          if (parts.length >= 2) {
            classId = parts[0];
            sectionId = parts[1];
          }
        }

        // Use the random_no from the body (which is the shared random number)
        final success = await uploadTeacherNoteDocument(
          random_no: body.randomNo ?? '1234',
          shortName: body.shortName ?? '',
          filename: file.name,
          fileBytes: file.bytes!,
          uploadDate: body.dailyNoteDate ?? '',
        );

        if (!success) {
          return {'status': false, 'error_msg': 'Failed to upload file ${file.name}'};
        }
        filenames.add(file.name);
      }
    }

    try {
      // Create the parameters with JSON-encoded arrays
      final params = {
        "academic_yr": body.academicYear,
        "short_name": body.shortName,
        "random_no": body.randomNo, // This should now be your shared random number
        "teacher_id": body.teacherId,
        "description": body.description,
        "str_array": body.strArray, // already a valid JSON string like ["130^512","132^521"]

        "login_type": body.loginType,
        "publish": body.publish,
        "dailynote_date": body.dailyNoteDate,
        "operation": body.operation,
        "subject_id": body.subjectId,
        "filename": jsonEncode(body.filename), // Encode as JSON array: ["filename.jpg"]
      };

      // Remove null values but keep empty strings for required fields
      params.removeWhere((key, value) => value == null);

      print("=== FINAL PARAMS BEING SENT ===");
      params.forEach((key, value) {
        print("$key: $value (${value.runtimeType})");
      });
      print("=== END PARAMS ===");

      // Add timeout and better error handling
      final options = Options(
        contentType: 'multipart/form-data',
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      );

      final response = await apiClient.post(
        '${baseUrl}AdminApi/daily_notes',
        data: FormData.fromMap(params),
        options: options,
      );

      print("=== RESPONSE RECEIVED ===");
      print("Status Code: ${response.statusCode}");
      print("Headers: ${response.headers}");
      print("Data: ${response.data}");
      print("=== END RESPONSE ===");

      if (response.statusCode == 200) {
        final jsonResponse = response.data is String
            ? json.decode(response.data)
            : response.data;

        print("Parsed Response: $jsonResponse");

        return jsonResponse;
      } else {
        print("Server error with status: ${response.statusCode}");
        return {
          'status': false,
          'error_msg': 'Server error: ${response.statusCode} - ${response.statusMessage}'
        };
      }
    } catch (e) {
      print("=== ERROR DETAILS ===");
      print("Error type: ${e.runtimeType}");
      print("Error message: $e");

      if (e is DioException) {
        print("Dio error type: ${e.type}");
        print("Dio error message: ${e.message}");
        print("Dio error response: ${e.response?.data}");
        print("Dio error stack: ${e.stackTrace}");
      }
      print("=== END ERROR ===");

      return {
        'status': false,
        'error_msg': 'Network error: ${e.toString()}'
      };
    }
  }

  Future<Map<String, dynamic>> updateNoteWithFiles(CreateNoteBody body) async {
    List<String> filenames = [];

    // Upload new files first
    // if (body.files.isNotEmpty) {
    //   for (var file in body.files) {
    //     final success = await uploadTeacherNoteDocument(
    //       classId: body.classId ?? '',
    //       sectionId: body.sectionId ?? '',
    //       shortName: body.shortName ?? '',
    //       filename: file.name,
    //       fileBytes: file.bytes!,
    //       uploadDate: body.dailyNoteDate ?? '',
    //     );
    //
    //     if (!success) {
    //       return {'status': false, 'error_msg': 'Failed to upload file ${file.name}'};
    //     }
    //     filenames.add(file.name);
    //   }
    // }

    try {
      final params = {
        ...body.toJson(),
        if (filenames.isNotEmpty) "filename": jsonEncode(filenames),
        if (body.deleteimagelist?.isNotEmpty ?? false)
          "deleteimagelist": jsonEncode(body.deleteimagelist),
      };

      final response = await apiClient.post(
        '${baseUrl}AdminApi/daily_notes',
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

  Future<List<Note>> getTeacherNote(
    String regId,
    String year,
    String shortName,
  ) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/get_daily_notes',
        data: FormData.fromMap({
          "acd_yr": year,
          "reg_id": regId,
          "short_name": shortName,
        }),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        if (jsonResponse['status'] == true) {
          final List<dynamic> data = jsonResponse['daily_notes'];
          return data.map((item) => Note.fromJson(item)).toList();
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

  Future<bool> uploadDocument(UploadDocNote document) async {
    final x = document.toJson();
    x.remove('datafile');
    Utils.debLog("======>>>>>$x");
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/upload_files',
        data: FormData.fromMap(document.toJson()),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        if (jsonResponse['status'] == true) {
          return true;
        } else {
          return true;
        }
      } else {
        return true;
      }
    } catch (e) {
      return true;
    }
  }

  Future<bool> createNote(CreateNoteBody note) async {
    List<String>? filename = [];
    if (note.files.isNotEmpty) {
      for (var file in note.files) {
        final x = UploadDocNote.fromJson({
          ...note.toJson(),
          "filename": file.name,
          "datafile": base64Encode(file.bytes!),
          "upload_date":
              "${DateTime.parse(note.dailyNoteDate!).day.toString().padLeft(2, '0')}-${DateTime.parse(note.dailyNoteDate!).month.toString().padLeft(2, '0')}-${DateTime.parse(note.dailyNoteDate!).year}",
        });

        final doc = await uploadDocument(x);
        if (!doc) return false;
        filename.add(x.filename!);
      }
    }
    try {
      final d = note.copyWith(operation: 'create').toJson();
      final x = {
        ...d,
        "str_array": [...note.strArray?.split(',') ?? []],
        if (filename.isNotEmpty) "filename": jsonEncode(filename),
      };

      final response = await apiClient.post(
        '${baseUrl}AdminApi/daily_notes',
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

  Future<bool> updateNote(CreateNoteBody n) async {
    List<String>? filename = [];
    if (n.files.isNotEmpty) {
      for (var file in n.files) {
        //     await Future.delayed(const Duration(milliseconds: 1000));
        final x = UploadDocNote.fromJson({
          ...n.toJson(),
          "filename": file.name,
          "datafile": base64Encode(file.bytes!),
          "upload_date":
              "${DateTime.parse(n.dailyNoteDate!).day.toString().padLeft(2, '0')}-${DateTime.parse(n.dailyNoteDate!).month.toString().padLeft(2, '0')}-${DateTime.parse(n.dailyNoteDate!).year}",
        });

        final doc = await uploadDocument(x);

        if (!doc) return false;
        filename.add(x.filename!);
      }
    }

    try {
      final d = n.copyWith(operation: 'edit').toJson();
      final x = {
        ...d,
        // "str_array": [...n.strArray?.split(',') ?? []],
        if (filename.isNotEmpty) "filename": jsonEncode(filename),
        if (n.deleteimagelist?.isNotEmpty ?? false && filename.isNotEmpty)
          "deleteimagelist": n.deleteimagelist!.first,
        if (n.deleteimagelist?.isEmpty ?? true && filename.isNotEmpty)
          "filename": jsonEncode(filename),
      };

      final formData = FormData.fromMap(x);
      final response = await apiClient.post(
        '${baseUrl}AdminApi/daily_notes',
        data: formData,
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
      Utils.debLog('Error: ===>>>> $e');
      return true;
    }
  }




  Future<bool> publishNote(NotePublishBody b) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/daily_notes',
        data: FormData.fromMap(b.toJson()),
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

  Future<DocHomework?> getDocument(DocNoteBody attachment) async {
    final response = await apiClient.post(
      '${baseUrl}AdminApi/get_images_daily_notes',
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

  Future<List<ClassInfo>> getClass(ClassBody classBody) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/get_subject_alloted_to_teacher_by_multiple_class',
        data: FormData.fromMap(classBody.toJson()),
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

  Future<bool> deleteNote(NoteDeleteBody n) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/daily_notes',
        data: FormData.fromMap(n.copyWith(loginType: 'T').toJson()),
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

  Future<bool> deleteDocument(DeleteDocumentBody n) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/delete_uploaded_files',
        data: FormData.fromMap(n.toJson()),
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
      return true;
      //throw Exception('Error: $e');
    }
  }
  Future<List<NoteView>> getNoteView(NoteViewBody b) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/get_students_notes_viewed',
        data: FormData.fromMap(b.toJson()),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;

        final List<dynamic> data = jsonResponse['student_list'];
        return data.map((item) => NoteView.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load leave applications');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
