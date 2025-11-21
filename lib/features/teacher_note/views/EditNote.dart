import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/features/auth/models/models.dart';
import 'package:teacherapp/features/home/providers/academic_year_provider.dart';
import 'package:teacherapp/features/homework/providers/class_provider.dart';
import 'package:teacherapp/features/homework/providers/multi_sub_provider.dart';
import 'package:teacherapp/features/homework/models/models.dart';
import 'package:teacherapp/features/teacher_note/providers/providers.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../features/auth/providers/auth_provider.dart';
import '../../../views/home/remark/service/editservice.dart';
import '../../../views/home/remark/service/note_att.dart';
import '../models/models.dart';

class EditTeacherNoteView extends HookConsumerWidget {
  final Note note;
  final VoidCallback? onNoteUpdated;

  const EditTeacherNoteView({
    required this.note,
    this.onNoteUpdated,
    super.key
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();

    // State variables
    final existingAttachments = useState<List<NoteAttachment>>([]);

    final newlyUploadedFileNames = useState<List<String>>([]);
    final deletedAttachments = useState<Set<String>>({});

    final isUploading = useState<bool>(false);
    final isDownloading = useState<bool>(false);
    final loadingAttachments = useState<bool>(false);
    final refreshTrigger = useState<int>(0);
    final _descriptionController = useTextEditingController(text: note.description);
    final teacherNoteService = ref.read(editTeacherNoteServiceProvider);
    final auth = ref.read(authProvider).requireValue;
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final newlyUploadedAttachments = useState<List<NoteAttachment>>([]);
    // Initialize notifications
    useEffect(() {
      Future.microtask(() async {
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('@mipmap/ic_launcher');
        const InitializationSettings initializationSettings =
            InitializationSettings(android: initializationSettingsAndroid);
        await flutterLocalNotificationsPlugin
            .initialize(initializationSettings);
      });
      return null;
    }, []);

    // Format date for API (yyyy-MM-dd to dd-MM-yyyy)
    String formatDateForApi(String date) {
      try {
        final parsedDate = DateTime.parse(date);
        return DateFormat('dd-MM-yyyy').format(parsedDate);
      } catch (e) {
        return date;
      }
    }

    // Load existing attachments
    Future<void> _loadExistingAttachments() async {
      loadingAttachments.value = true;
      try {
        print("note.date ${note.date}");
        final attachments = await teacherNoteService.getTeacherNoteAttachments(

          noteId: note.notesId ?? '',
          noteDate: note.date ?? '',
          shortName: auth.teacherVerification?.shortName ?? '',
        );

        existingAttachments.value = attachments;
      } catch (e) {
        _showSnackBar(context, 'Failed to load attachments: $e');
      } finally {
        loadingAttachments.value = false;
      }
    }

    // Initialize
    useEffect(() {
      // Set initial form values
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (formKey.currentState != null) {
          formKey.currentState?.fields['description']
              ?.didChange(note.description ?? '');
        }
      });

      // Load attachments
      _loadExistingAttachments();

      return null;
    }, []);

    // Download functions
    Future<void> _downloadFileAndroid(
        String url,
        BuildContext context,
        String name,
        FlutterLocalNotificationsPlugin notificationsPlugin) async {
      isDownloading.value = true;

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'download_channel',
        'Download Channel',
        channelDescription: 'Notifications for file downloads',
        importance: Importance.high,
        priority: Priority.high,
        showProgress: true,
        onlyAlertOnce: true,
      );

      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      var directory = Directory("/storage/emulated/0/Download/TeacherApp/TeacherNote");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      var path = "${directory.path}/$name";
      var file = File(path);

      await notificationsPlugin.show(
        0,
        'Downloading Attachment',
        'Downloading $name...',
        platformChannelSpecifics,
      );

      try {
        var res = await http.get(Uri.parse(url));
        if (res.statusCode == 200) {
          await file.writeAsBytes(res.bodyBytes);

          await notificationsPlugin.show(
            0,
            'Download Complete',
            'File saved to Download/TeacherApp/TeacherNote/$name',
            platformChannelSpecifics,
            payload: path,
          );

          _showSnackBar(context, 'File downloaded successfully in Download/TeacherApp/TeacherNote');
        } else {
          _showSnackBar(context, 'Failed to download file: ${res.statusCode}');
        }
      } catch (e) {
        _showSnackBar(context, 'Failed to download file: $e');
      } finally {
        isDownloading.value = false;
      }
    }

    Future<void> _downloadFileIOS(String url, String fileName, FlutterLocalNotificationsPlugin notificationsPlugin) async {
      isDownloading.value = true;

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'download_channel',
        'Download Channel',
        channelDescription: 'Notifications for file downloads',
        importance: Importance.high,
        priority: Priority.high,
        showProgress: true,
        onlyAlertOnce: true,
      );

      const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

      try {
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/$fileName';
        final file = File(filePath);

        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          await file.writeAsBytes(response.bodyBytes);

          await notificationsPlugin.show(
            0,
            'Download Complete',
            'File saved to $filePath',
            platformChannelSpecifics,
            payload: filePath,
          );

          _showSnackBar(context, 'Find it in the Files/On My iPhone/Teacher App/TeachrNote.');
        } else {
          await notificationsPlugin.show(
            0,
            'Download Failed',
            'Failed to download file: ${response.statusCode}',
            platformChannelSpecifics,
          );
          _showSnackBar(context, 'Failed to download file: ${response.statusCode}');
        }
      } catch (e) {
        await notificationsPlugin.show(
          0,
          'Download Failed',
          'Failed to download file',
          platformChannelSpecifics,
        );
        _showSnackBar(context, 'Failed to download file: $e');
      } finally {
        isDownloading.value = false;
      }
    }

    Future<void> _handleDownload(NoteAttachment attachment) async {

      try {
        if (attachment.fileSize == "0") {
          _showSnackBar(context, 'File not uploaded properly');
        } else {

          String originalUrl = attachment.url; // e.g., "https://sms.arnoldcentralschool.org/SACSv4test/uploads/remark/03-09-2025"
          String reformattedDateStr;
          String baseDownloadUrl = originalUrl;

          RegExp dateRegExp = RegExp(r'(\d{2}-\d{2}-\d{4})');
          Match? dateMatch = dateRegExp.firstMatch(originalUrl);

          if (dateMatch != null && dateMatch.group(0) != null) {
            String extractedDate = dateMatch.group(0)!;
            try {
              // Parse the extracted date (dd-MM-yyyy)
              DateFormat inputFormat = DateFormat('dd-MM-yyyy');
              DateTime parsedDate = inputFormat.parse(extractedDate);
              DateFormat outputFormat = DateFormat('yyyy-MM-dd');
              reformattedDateStr = outputFormat.format(parsedDate); // e.g., "2025-09-03"
              print('Original Date from URL: $extractedDate');
              print('Reformatted Date: $reformattedDateStr');
              baseDownloadUrl = originalUrl.replaceFirst(extractedDate, reformattedDateStr);
              print('Potentially modified base URL for download: $baseDownloadUrl');

            } catch (e) {
              print('Error parsing or formatting date from URL: $e');
              reformattedDateStr = "N/A"; // Or handle as an error
            }
          } else {
            print('Date not found in URL path or format is unexpected.');
            reformattedDateStr = "N/A";
          }
          String downloadUrl = '$baseDownloadUrl';
          print('Download URL: $downloadUrl');

          if (Platform.isAndroid) {
            await _downloadFileAndroid(downloadUrl, context, attachment.imageName, flutterLocalNotificationsPlugin);
          } else if (Platform.isIOS) {
            await _downloadFileIOS(downloadUrl, attachment.imageName, flutterLocalNotificationsPlugin);
          } else {
            _showSnackBar(context, 'Unsupported platform');
          }
        }
      } catch (e) {
        _showSnackBar(context, 'Failed to download file: $e');
      }
    }

    Future<void> onOpenAttachment(String url) async {
      // Similar to your remark implementation
      print("Edit Open TN => $url");
      final uri = Uri.tryParse(url);
      if (uri == null) {
        _showSnackBar(context, 'Invalid attachment URL');
        return;
      }

      try {
        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          _showSnackBar(context, 'Could not open attachment');
        }
      } catch (e) {
        _showSnackBar(context, 'Error opening attachment: $e');
      }
    }

    // Upload new attachment
    Future<void> _uploadNewAttachment() async {
      try {
        final result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          withData: true,
        );

        if (result != null && result.files.isNotEmpty) {
          isUploading.value = true;
          int successCount = 0;
          final List<String> uploadedThisCall = [];
          final List<NoteAttachment> tempNewAttachments = [];

          for (final file in result.files) {
            if (file.bytes == null) continue;

            try {
              final uploaded = await teacherNoteService.uploadTeacherNoteDocument(
                random_no: note.notesId ?? '',
                shortName: auth.teacherVerification?.shortName ?? '',
                fileBytes: file.bytes!,
                uploadDate: formatDateForApi(note.date ?? DateFormat('yyyy-MM-dd').format(DateTime.now())),
                filename: file.name,
              );

              if (uploaded) {
                successCount++;
                uploadedThisCall.add(file.name);

                // Create attachment for display
                final newAttachment = NoteAttachment(
                  noteId: note.notesId ?? '',
                  imageName: file.name,
                  fileSize: ((file.size / 1024).toStringAsFixed(2)),
                  url: "uploading", // Mark as uploading
                );
                tempNewAttachments.add(newAttachment);
              } else {
                _showSnackBar(context, 'Upload failed for ${file.name}');
              }
            } catch (e) {
              _showSnackBar(context, 'Error uploading ${file.name}: $e');
            }
          }

          if (successCount > 0) {
            // Update state for immediate UI display
            newlyUploadedAttachments.value = [
              ...newlyUploadedAttachments.value,
              ...tempNewAttachments
            ];

            newlyUploadedFileNames.value = [
              ...newlyUploadedFileNames.value,
              ...uploadedThisCall
            ];

            _showSnackBar(context, 'Successfully uploaded $successCount file(s)');
            refreshTrigger.value++; // Force UI refresh

            // Refresh from server to get proper URLs (optional)
            Future.delayed(const Duration(seconds: 1), () {
              _loadExistingAttachments();
            });
          }
        }
      } catch (e) {
        _showSnackBar(context, 'Upload failed: $e');
      } finally {
        isUploading.value = false;
      }
    }

// Delete attachment
    Future<void> _deleteAttachment(NoteAttachment attachment) async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Delete?"),
          content: Text("Are you sure to delete ${attachment.imageName}?"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text("Cancel")
            ),
            TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text("Delete")
            ),
          ],
        ),
      );

      if (confirmed == true) {
        try {
          // Store original for rollback
          final originalAttachments = List<NoteAttachment>.from(existingAttachments.value);

          // Immediate UI update only - NO SERVER CALL
          existingAttachments.value = existingAttachments.value
              .where((a) => a.imageName != attachment.imageName)
              .toList();

          // Add to deleted attachments set (will be processed during update)
          deletedAttachments.value = {...deletedAttachments.value, attachment.imageName};

          // Remove from newly uploaded if it was uploaded in this session
          newlyUploadedFileNames.value = newlyUploadedFileNames.value
              .where((n) => n != attachment.imageName)
              .toList();

          newlyUploadedAttachments.value = newlyUploadedAttachments.value
              .where((a) => a.imageName != attachment.imageName)
              .toList();

          _showSnackBar(context, 'Attachment marked for deletion. Click Update to save changes.');

        } catch (e) {
          _showSnackBar(context, 'Error deleting attachment: $e');
        }
      }
    }

// Save/Update teacher note
    Future<void> onEdit() async {
      if (formKey.currentState?.saveAndValidate() ?? false) {
        isUploading.value = true;

        try {
          final formData = formKey.currentState?.value ?? {};
          final description = formData['description']?.toString().trim() ?? '';

          // Validate description
          if (_descriptionController.text.isEmpty) {
            _showSnackBar(context, 'Description cannot be empty');
            return;
          }

          print('📝 Updating teacher note...');

          // Get current server attachments to compare
          final currentServerAttachments = await teacherNoteService.getTeacherNoteAttachments(
            noteId: note.notesId ?? '',
            noteDate: formatDateForApi(note.date ?? ''),
            shortName: auth.teacherVerification?.shortName ?? '',
          );

          final currentServerFilenames = currentServerAttachments.map((a) => a.imageName).toSet();

          // Files to delete = files marked for deletion + files on server but not in current UI
          final filesToDelete = {
            ...deletedAttachments.value,
            ...currentServerFilenames.difference(
                existingAttachments.value.map((a) => a.imageName).toSet()
            )
          };

          // Handle file names - ensure proper JSON format
          String fileNamePayload = "";
          if (newlyUploadedFileNames.value.isNotEmpty) {
            fileNamePayload = json.encode(newlyUploadedFileNames.value);
            print('📤 Files to add (JSON): $fileNamePayload');
          }

          // Handle delete files - ensure proper JSON format
          String deleteFilesPayload = "";
          if (filesToDelete.isNotEmpty) {
            deleteFilesPayload = json.encode(filesToDelete.toList());
            print('🗑️ Files to delete (JSON): $deleteFilesPayload');
          }

          // Make the update API call
          final res = await teacherNoteService.updateTeacherNote(
            app_version: '1.70',
            noteId: note.notesId ?? '',
            description: _descriptionController.text,
            noteDate: formatDateForApi(note.date ?? ''),
            academicYr: auth.academicYr ?? '',
            teacherId: auth.regId ?? '',
            shortName: auth.teacherVerification?.shortName ?? '',
            classId: note.classId ?? '',
            sectionId: note.sectionId ?? '',
            subjectId: note.subjectId ?? '',
            fileName: fileNamePayload,
            deleteFiles: deleteFilesPayload,
          );

          print('📡 API Response: $res');

          if (res['status'] == true) {
            // Clear all temporary states only on successful update
            newlyUploadedFileNames.value = [];
            newlyUploadedAttachments.value = [];
            deletedAttachments.value = {};

            _showSnackBar(context, res['success_msg'] ?? "✅ Teacher Note Updated Successfully!");

            // Call the callback to refresh parent
            onNoteUpdated?.call();

            // Navigate back
            if (context.mounted) {
              context.pop();
            }
          } else {
            final errorMsg = res['error_msg'] ?? "❌ Failed to update teacher note";
            _showSnackBar(context, errorMsg);
            print('❌ Update failed: $errorMsg');

            // Don't clear states on failure so user can retry
          }
        } catch (e, st) {
          print("❌ Exception in onEdit: $e");
          print("Stack trace: $st");
          _showSnackBar(context, "Error updating teacher note: ${e.toString()}");
        } finally {
          isUploading.value = false;
        }
      } else {
        // Form validation failed
        final errors = formKey.currentState?.errors;
        print('❌ Form validation errors: $errors');
        _showSnackBar(context, 'Please fix the form errors');
      }
    }

    void resetForm() {
      _descriptionController.text = note.description!;
    }

    Widget _buildAttachmentItem(NoteAttachment attachment, bool isNewUpload) {
      final fileName = attachment.imageName;
      final fileUrl = attachment.fullUrl;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Card(
          elevation: 2,
          color: isNewUpload ? Colors.blue.shade50 : null,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                _getFileIcon(fileName),
                if (isNewUpload)
                  const Icon(Icons.new_releases, color: Colors.blue, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileName,
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${attachment.fileSize} KB",
                        style: TextStyle(
                            fontSize: 12.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                if ((fileName.endsWith('.jpg') ||
                    fileName.endsWith('.png')) &&
                    fileName.isNotEmpty &&
                    !isNewUpload) // Only allow viewing for non-new files
                  IconButton(
                    icon: const Icon(Icons.remove_red_eye,
                        color: Colors.green, size: 20),
                    onPressed: () => onOpenAttachment(fileUrl),
                    tooltip: "View",
                  ),
                IconButton(
                  icon: const Icon(Icons.download,
                      color: Colors.blue, size: 20),
                  onPressed: isDownloading.value || isNewUpload
                      ? null // Disable download for new files (no proper URL yet)
                      : () => _handleDownload(attachment),
                  tooltip: isNewUpload ? "Download after update" : "Download",
                ),
                IconButton(
                  icon: const Icon(Icons.delete,
                      color: Colors.red, size: 20),
                  onPressed: () => _deleteAttachment(attachment),
                  tooltip: "Delete",
                ),
              ],
            ),
          ),
        ),
      );
    }


    // Build attachment section
    Widget _buildAttachmentSection() {
      final _ = refreshTrigger.value;

      // Combine existing and newly uploaded attachments for display
      final allAttachments = [
        ...existingAttachments.value,
        ...newlyUploadedAttachments.value,
      ];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Attachments",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              if (isDownloading.value)
                const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2))
              else if (isUploading.value)
                const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2))
              else
                IconButton(
                  icon: const Icon(Icons.attach_file, color: Colors.blue),
                  onPressed: _uploadNewAttachment,
                ),
            ],
          ),

          if (isUploading.value)
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: LinearProgressIndicator(),
            )
          else if (loadingAttachments.value)
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: LinearProgressIndicator(),
            )
          else if (allAttachments.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Existing attachments section
                  if (existingAttachments.value.isNotEmpty) ...[
                    const Text("Existing Attachments",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    SizedBox(height: 8.h),
                    ...existingAttachments.value.map((attachment) => _buildAttachmentItem(attachment, false)).toList(),
                    SizedBox(height: 16.h),
                  ],

                  // Newly uploaded files section
                  if (newlyUploadedAttachments.value.isNotEmpty) ...[
                    Text("New files to add (${newlyUploadedAttachments.value.length}):",
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.blue)),
                    SizedBox(height: 8.h),
                    ...newlyUploadedAttachments.value.map((attachment) => _buildAttachmentItem(attachment, true)).toList(),
                  ],
                ],
              )
            else
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text("No attachments",
                    style: TextStyle(color: Colors.grey, fontSize: 14)),
              ),
        ],
      );
    }

// Helper method to build individual attachment items

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Teacher Note",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 208, 28, 127),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20.w),
          margin: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
          child: SingleChildScrollView(
            child: FormBuilder(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Read-only fields
                  _buildReadOnlyField("Class", _getClassDisplayText()),
                  SizedBox(height: 10.h),
                  _buildReadOnlyField(
                      "Subject", note.subjectname ?? 'Not specified'),
                  SizedBox(height: 10.h),
                  _buildReadOnlyField("Date", _getFormattedDate()),
                  SizedBox(height: 10.h),

                  // Editable description
                  const Text("*Description",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 5.h),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Type here...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                    ),
                  ),
                  // FormBuilderTextField(
                  //   name: 'description',
                  //   maxLines: 3,
                  //   initialValue: _descriptionController,
                  //   validator: FormBuilderValidators.required(
                  //       errorText: 'Description is mandatory'),
                  //   decoration: InputDecoration(
                  //     hintText: "Type here...",
                  //     border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10.r)),
                  //   ),
                  // ),

                  SizedBox(height: 20.h),
                  _buildAttachmentSection(),
                  SizedBox(height: 20.h),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 78, 157, 222),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.r)),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          onPressed: isUploading.value ? null : onEdit,
                          icon: isUploading.value
                              ? SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2, color: Colors.white))
                              : Icon(Icons.save,
                                  size: 16.sp, color: Colors.white),
                          label: Text(
                            isUploading.value ? "Updating..." : "Update",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade400,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.r)),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          onPressed: resetForm,
                          icon: Icon(Icons.refresh,
                              size: 16.sp, color: Colors.black),
                          label: const Text("Reset",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper methods
  Widget _buildReadOnlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 5.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.grey.shade100,
          ),
          child: Text(value, style: TextStyle(fontSize: 14.sp)),
        ),
      ],
    );
  }

  Widget _getFileIcon(String fileName) {
    if (fileName.contains('.jpg') || fileName.contains('.png')) {
      return const Icon(Icons.image, color: Colors.redAccent, size: 24);
    } else if (fileName.contains('.pdf')) {
      return const Icon(Icons.picture_as_pdf, color: Colors.red, size: 24);
    } else if (fileName.contains('.doc') || fileName.contains('.docx')) {
      return const Icon(Icons.description, color: Colors.blue, size: 24);
    } else {
      return const Icon(Icons.insert_drive_file, color: Colors.blue, size: 24);
    }
  }

  String _getClassDisplayText() {
    if (note.classname != null && note.sectionname != null) {
      return "${note.classname} ${note.sectionname}";
    } else if (note.classname != null) {
      return note.classname!;
    } else {
      return 'Not specified';
    }
  }

  String _getFormattedDate() {
    if (note.date != null) {
      try {
        return DateFormat('dd-MM-yyyy').format(DateTime.parse(note.date!));
      } catch (e) {
        return note.date!;
      }
    }
    return 'Not specified';
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ));
  }
}
