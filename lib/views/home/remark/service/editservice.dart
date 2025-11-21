import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/features/auth/models/models.dart';
import '../../../../providers/api_client_provider.dart';
import 'note_att.dart';



class EditTeacherNoteService {
  final Dio apiClient;
  final String baseUrl;

  EditTeacherNoteService({ required this.apiClient,  required this.baseUrl});

  // Delete teacher note document
  Future<bool> deleteTeacherNoteDocument({
    required String random_no,
    required String uploadDate,
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
      print("❌ DELETE TEACHER NOTE ERROR: $e");
      return false;
    }
  }

  // Get teacher note attachments
  Future<List<NoteAttachment>> getTeacherNoteAttachments({
    required String noteId,
    required String noteDate,
    required String shortName,
  }) async {
    try {
      final res = await apiClient.post(
        '${baseUrl}AdminApi/get_images_daily_notes',
        data: {
          'note_id': noteId,
          'dailynote_date': noteDate,
          'short_name': shortName,
        },
      );

      if (res.statusCode == 200 && res.data['status'] == true) {
        final List data = res.data['images'] ?? [];
        final String baseUrl = res.data['url'] ?? "";

        return data.map((e) {
          return NoteAttachment(
            noteId: e['notes_id'].toString(),
            imageName: e['image_name'] ?? '',
            fileSize: e['file_size'].toString(),
            url: "$baseUrl/${e['image_name']}",
          );
        }).toList();
      }
      return [];
    } catch (e) {
      print("❌ GET TEACHER NOTE ATTACHMENTS ERROR: $e");
      return [];
    }
  }


  Future<Map<String, dynamic>> updateTeacherNote({
    required String app_version,
    required String noteId,
    required String description,
    required String noteDate,
    required String academicYr,
    required String teacherId,
    required String shortName,
    required String classId,
    required String sectionId,
    required String subjectId,
    String fileName = "",
    String deleteFiles = "",
  }) async {
    try {
      final url = '${baseUrl}AdminApi/daily_notes';

      // Create FormData instead of JSON
      final formData = FormData.fromMap({
        "academic_yr": academicYr,
        "teacher_id": teacherId,
        "section_id": sectionId,
        "class_id": classId,
        "subject_id": subjectId,
        "notes_id": noteId,
        "description": description,
        "dailynote_date": noteDate,
        "login_type": "T",
        "publish": "N",
        "operation": "edit",
        "short_name": shortName,
      });

      // Add filename if provided
      if (fileName.isNotEmpty && fileName != '""') {
        formData.fields.add(MapEntry("filename", fileName));
        print('📁 Filename param: $fileName');
      }

      // Add delete files if provided
      if (deleteFiles.isNotEmpty && deleteFiles != '""') {
        formData.fields.add(MapEntry("deleteimagelist", deleteFiles));
        print('🗑️ Delete files param: $deleteFiles');
      }

      print("📤 UPDATE TEACHER NOTE FORM DATA:");
      for (var field in formData.fields) {
        print('   ${field.key}: ${field.value}');
      }

      final response = await apiClient.post(
        url,
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      print('📡 Response status: ${response.statusCode}');
      print('📡 Response data: ${response.data}');

      if (response.statusCode == 200) {
        final result = response.data is String
            ? json.decode(response.data)
            : response.data;
        return result as Map<String, dynamic>;
      } else {
        return {
          "status": false,
          "error_msg": "Server returned ${response.statusCode}",
        };
      }
    } catch (e, st) {
      print("❌ Error updating teacher note: $e");
      print(st);
      return {
        "status": false,
        "error_msg": "Failed to update teacher note: $e",
      };
    }
  }

  // Upload teacher note document
  Future<bool> uploadTeacherNoteDocument({
    required String random_no,
    required String shortName,
    required List<int> fileBytes,
    required String uploadDate,
    required String filename,
  }) async {
    try {
      final formData = FormData.fromMap({
        "random_no": random_no,
        "short_name": shortName,
        "upload_date": uploadDate,
        "doc_type_folder": "daily_notes",
        "filename": filename,
        "datafile": base64Encode(fileBytes),
      });

      final response = await apiClient.post(
        '${baseUrl}AdminApi/upload_files',
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data is String
            ? json.decode(response.data)
            : response.data;
        return jsonResponse['status'] == true;
      }
      return false;
    } catch (e) {
      print("❌ UPLOAD TEACHER NOTE ERROR: $e");
      return false;
    }
  }
}