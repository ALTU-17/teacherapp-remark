import 'dart:io';

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
import 'dart:math' as math;
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
import '../models/models.dart';

class EditAddTeacherNoteView extends HookConsumerWidget {
  final Note? note;
  const EditAddTeacherNoteView({this.note, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fromKey = useTextFieldGlobalKey();
    final sharedRandomNo = useState<String>('');
    final selectedClass = useState<List<ClassInfo>?>(null);
    final selectedSubject = useState<MultiSub?>(null);
    final selectAll = useState<bool>(false);
    final uploadedFiles = useState<List<String>>([]);
    final isUploading = useState<bool>(false);
    final isDownloading = useState<bool>(false);

    final classes = ref.watch(classPProvider);
    final mulsubjects = ref.watch(multiSubjectPProvider);
    final mulsubjectsP = ref.read(multiSubjectPProvider.notifier);
    final teacherNoteP = ref.read(teacherNoteProvider.notifier);
    final teacherNoteState = ref.watch(teacherNoteProvider);
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    String generateRandomNo() {
      if (sharedRandomNo.value.isEmpty) {
        final random = math.Random();
        sharedRandomNo.value = (1000 + random.nextInt(9000)).toString();
        print('Generated new random number: ${sharedRandomNo.value}');
      }
      return sharedRandomNo.value;
    }

    void resetRandomNo() {
      sharedRandomNo.value = '';
      print('Random number reset');
    }

    // File upload function
    Future<void> _uploadFiles(List<PlatformFile> filesToUpload) async {
      if (selectedClass.value?.isEmpty == true) {
        _showSnackBar(context, 'Please select a class first');
        return;
      }

      isUploading.value = true;
      int successCount = 0;
      int failCount = 0;
      final currentRandomNo = generateRandomNo();
      print('Using random number for upload: $currentRandomNo');

      try {
        for (final file in filesToUpload) {
          try {
            List<int>? fileBytes = file.bytes;

            if (fileBytes == null && file.path != null) {
              File ioFile = File(file.path!);
              if (await ioFile.exists()) {
                fileBytes = await ioFile.readAsBytes();
              }
            }

            if (fileBytes == null) {
              failCount++;
              _showSnackBar(context, 'Could not read file: ${file.name}');
              continue;
            }

            final ci = selectedClass.value!.first;
            final auth = ref.read(authProvider).requireValue;

            print('Uploading file: ${file.name}, size: ${fileBytes.length} bytes, randomNo: $currentRandomNo');

            final uploaded = await teacherNoteP.uploadTeacherNoteDocument(
              random_no: currentRandomNo,
              shortName: auth.teacherVerification?.shortName ?? '',
              fileBytes: fileBytes,
              uploadDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
              filename: file.name,
            );

            if (uploaded) {
              successCount++;
              uploadedFiles.value = [...uploadedFiles.value, file.name];
              print('Successfully uploaded: ${file.name}');
            } else {
              failCount++;
              _showSnackBar(context, 'Upload failed for ${file.name}');
            }
          } catch (e) {
            failCount++;
            print('Error uploading ${file.name}: $e');
            _showSnackBar(context, 'Error uploading ${file.name}: $e');
          }
        }

        if (successCount > 0) {
          _showSnackBar(context, 'Successfully uploaded $successCount file(s)');
        }
        if (failCount > 0) {
          _showSnackBar(context, 'Failed to upload $failCount file(s)');
        }

      } catch (e) {
        print('Upload process error: $e');
        _showSnackBar(context, 'Upload process failed: $e');
      } finally {
        isUploading.value = false;
      }
    }

    // File picking and automatic upload
    Future<void> _pickAndUploadFiles() async {
      if (selectedClass.value?.isEmpty == true) {
        _showSnackBar(context, 'Please select a class first');
        return;
      }

      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx', 'txt'],
        );

        if (result != null && result.files.isNotEmpty) {
          List<PlatformFile> validFiles = result.files.where((file) => file.name.isNotEmpty).toList();

          if (validFiles.isEmpty) {
            _showSnackBar(context, 'No valid files selected');
            return;
          }

          _showSnackBar(context, 'Uploading ${validFiles.length} file(s)...');
          await _uploadFiles(validFiles);
        } else {
          _showSnackBar(context, 'No files selected');
        }
      } catch (e) {
        print('File picking error: $e');
        _showSnackBar(context, 'Failed to pick files: $e');
      }
    }



    // Save function for create mode
    Future<void> onSave() async {
      final validate = fromKey.currentState?.saveAndValidate() ?? false;
      if (selectedClass.value != null && validate) {
        isUploading.value = true;

        try {
          // Get the same random number used for file upload
          final currentRandomNo = generateRandomNo();
          print('Using random number for save: $currentRandomNo');

          bool allSuccess = true;

          final smId = selectedSubject.value?.id ?? '';
          final subjectId = smId.isEmpty ? '0' : smId;

          for (ClassInfo e in selectedClass.value ?? []) {
            // Create the body with proper values and SAME random number
            final x = CreateNoteBody(
              academicYear: ref.read(academicYearProvider).requireValue.selectedYear,
              shortName: ref.read(authProvider).requireValue.teacherVerification?.shortName,
              randomNo: currentRandomNo,
              teacherId: ref.read(authProvider).requireValue.regId,
              description: fromKey.currentState?.value['description'],
              strArray: "${e.classId}^${e.sectionId}",
              loginType: 'T',
              publish: 'N',
              dailyNoteDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
              operation: 'create',
              subjectId: subjectId,
              filename: uploadedFiles.value, // List of filenames
            );

            final response = await teacherNoteP.createTeacherNoteWithFiles(x);

            final success = response['status'] == true;

            if (!success) {
              allSuccess = false;
            }
          }

          if (allSuccess) {
            _showSnackBar(context, 'Teacher note created successfully');
            fromKey.currentState?.reset();
            // Clear states
            selectedClass.value = null;
            selectedSubject.value = null;
            selectAll.value = false;
            uploadedFiles.value = [];

            context.pop();
          } else {
            _showSnackBar(context, 'Failed to create teacher note');
          }
        } catch (e) {
          _showSnackBar(context, 'Error creating teacher note: $e');
        } finally {
          isUploading.value = false;
        }
      } else {
        _showSnackBar(context, 'Please fill all required fields');
      }
    }

    // Delete file in create mode
    Future<void> _deleteFile(String filename) async {
      uploadedFiles.value = uploadedFiles.value.where((f) => f != filename).toList();
      _showSnackBar(context, "Removed $filename from upload list");
    }

    void resetForm() {
      fromKey.currentState?.reset();
      selectedClass.value = null;
      selectedSubject.value = null;
      selectAll.value = false;
      uploadedFiles.value = [];
    }

    // Build class selection widget
    Widget _buildClassSelection() {
      return classes.when(
        data: (data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: selectAll.value,
                    onChanged: (value) {
                      selectAll.value = value ?? false;

                      if (selectAll.value) {
                        // ✅ Select all classes
                        selectedClass.value = data;
                        mulsubjectsP.multiOnChange(data);
                        fromKey.currentState?.fields['str_array']?.didChange(data);
                      } else {
                        // ❌ Unselect all (same as reset behavior)
                        fromKey.currentState?.reset(); // 👈 this clears all checkbox values

                        selectedClass.value = [];
                        mulsubjectsP.multiOnChange([]);
                        selectAll.value = false;
                      }
                    },
                  ),

                  const Text("Select All", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              FormBuilderCheckboxGroup<ClassInfo>(
                name: 'str_array',
                validator: FormBuilderValidators.required(errorText: 'Class is mandatory'),
                options: data.map((e) => FormBuilderFieldOption(
                  value: e,
                  child: Text("${e.className}${e.sectionName}"),
                )).toList(),
                decoration: const InputDecoration(border: InputBorder.none),
                onChanged: (v) {
                  selectedClass.value = v;
                  mulsubjectsP.multiOnChange(v);
                  final allSelected = v != null && v.isNotEmpty && v.length == data.length;
                  selectAll.value = allSelected;
                },
              ),
            ],
          );
        },
        error: (error, stackTrace) => const Text("Error loading classes", style: TextStyle(color: Colors.red)),
        loading: () => const Center(child: CircularProgressIndicator()),
      );
    }

    // Build subject selection widget
    Widget _buildSubjectSelection() {
      return mulsubjects.when(
        data: (data) {
          return FormBuilderDropdown<MultiSub>(
            name: 'subject',
            hint: const Text("Select Subject"),
            items: data.map((subject) => DropdownMenuItem(
              value: subject,
              child: Text(subject.name ?? ""),
            )).toList(),
            onChanged: (value) => selectedSubject.value = value,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
            ),
          );
        },
        error: (error, stackTrace) => const Text("Error loading subjects", style: TextStyle(color: Colors.red)),
        loading: () => const Center(child: CircularProgressIndicator()),
      );
    }

    // Build attachment section for create mode
    Widget _buildAttachmentSection() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Attachments", style: TextStyle(fontWeight: FontWeight.bold)),
              if (isUploading.value)
                const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
              else
                IconButton(
                  icon: const Icon(Icons.attach_file, color: Colors.blue),
                  onPressed: _pickAndUploadFiles,
                  tooltip: "Add attachments",
                ),
            ],
          ),

          if (uploadedFiles.value.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Uploaded files (${uploadedFiles.value.length}):",
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
                  ...uploadedFiles.value.map((filename) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, size: 18, color: Colors.green),
                        const SizedBox(width: 8),
                        Expanded(child: Text(filename, style: TextStyle(fontSize: 13.sp))),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red, size: 18),
                          onPressed: () => _deleteFile(filename),
                          tooltip: "Remove from list",
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Teacher Note",
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
              key: fromKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Class Selection
                  const Text("*Class", style: TextStyle(fontWeight: FontWeight.bold)),
                  _buildClassSelection(),

                  // Subject Selection
                  const Text("Subject", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 5.h),
                  _buildSubjectSelection(),

                  SizedBox(height: 10.h),

                  // Date Picker
                  const Text("*Date", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 5.h),
                  FormBuilderDateTimePicker(
                    name: 'dailynote_date',
                    format: DateFormat('dd-MM-yyyy'),
                    inputType: InputType.date,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    valueTransformer: (v) => v?.toString().split(" ").first,
                    validator: FormBuilderValidators.required(errorText: 'Date is mandatory'),
                    decoration: InputDecoration(
                      hintText: "Select Date",
                      prefixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // Description
                  const Text("*Description", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 5.h),
                  FormBuilderTextField(
                    name: 'description',
                    maxLines: 3,
                    validator: FormBuilderValidators.required(errorText: 'Description is mandatory'),
                    decoration: InputDecoration(
                      hintText: "Type here...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Attachment Section
                  _buildAttachmentSection(),
                  SizedBox(height: 20.h),

                  // Save & Reset Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 78, 157, 222),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          onPressed: (isUploading.value || teacherNoteState.isLoading) ? null : onSave,
                          icon: (isUploading.value || teacherNoteState.isLoading)
                              ? SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                              : Icon(Icons.save, size: 16.sp, color: Colors.white),
                          label: Text(
                            (isUploading.value || teacherNoteState.isLoading)
                                ? "Creating..."
                                : "Save",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade400,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          onPressed: resetForm,
                          icon: Icon(Icons.refresh, size: 16.sp, color: Colors.black),
                          label: const Text("Reset", style: TextStyle(color: Colors.black, fontSize: 14)),
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

  String _formatFileSize(int bytes) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB"];
    int i = (math.log(bytes) / math.log(1024)).floor();
    return '${(bytes / math.pow(1024, i)).toStringAsFixed(1)} ${suffixes[i]}';
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ));
  }
}

extension FileSizeFormatter on int {
  String formatFileSize() {
    if (this <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB"];
    int i = (math.log(this) / math.log(1024)).floor();
    return '${(this / math.pow(1024, i)).toStringAsFixed(1)} ${suffixes[i]}';
  }
}