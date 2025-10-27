import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/features/auth/models/models.dart';
import 'package:teacherapp/features/home/providers/academic_year_provider.dart';
import 'package:teacherapp/features/homework/models/models.dart';
import 'package:teacherapp/features/homework/providers/class_provider.dart';
import 'package:teacherapp/features/homework/providers/homework_provider.dart';
import 'package:teacherapp/features/homework/providers/subjects_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class EditAddHomeWorkView extends HookConsumerWidget {
  final Homework? h;
  const EditAddHomeWorkView(this.h, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use hooks for state management
    final fromKey = useTextFieldGlobalKey();
    final selectedClass = useState<ClassInfo?>(null);
    final selectedSubject = useState<Subject?>(null);
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // State for attachment management
    final pickedFiles = useState<List<PlatformFile>>([]);
    final isUploading = useState<bool>(false);
    final isDownloading = useState<bool>(false);
    final existingAttachments = useState<List<String>>([]);
    final loadingAttachments = useState<bool>(false);
    final refreshTrigger = useState<int>(0);

    final clasess = ref.watch(classPProvider);
    final clasessP = ref.read(classPProvider.notifier);
    final subjects = ref.watch(subjectPProvider);
    final subjectsP = ref.read(subjectPProvider.notifier);
    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;
    final homeworkP = ref.read(homeWorkPProvider.notifier);
    final homework = ref.watch(homeWorkPProvider);

    void _loadAttachments() async {
      loadingAttachments.value = true;
      try {
        final documentUrls = await homeworkP.getDocument(h!);
        existingAttachments.value = documentUrls;
      } catch (e) {
        // Handle error
      } finally {
        loadingAttachments.value = false;
      }
    }
    // Load existing attachments for edit mode
    useEffect(() {
      if (h != null) {
        _loadAttachments();
      }
      return null;
    }, [h]);

    void _pickFiles() async {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.any,
          withData: true,
        );

        if (result != null && result.files.isNotEmpty) {
          // Verify that files have bytes
          for (var file in result.files) {
            if (file.bytes == null) {
              print('Warning: File ${file.name} has no bytes data');
            }
          }
          pickedFiles.value = [...pickedFiles.value, ...result.files];
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking files: $e')),
        );
      }
    }

    void _uploadNewAttachment() async {
      _pickFiles();
    }

    String _formatFileSize(int bytes) {
      if (bytes < 1024) {
        return "${bytes.toStringAsFixed(0)} B";
      } else if (bytes < 1024 * 1024) {
        return "${(bytes / 1024).toStringAsFixed(2)} KB";
      } else if (bytes < 1024 * 1024 * 1024) {
        return "${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB";
      } else {
        return "${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB";
      }
    }

    Widget _getFileIcon(String fileName) {
      if (fileName.toLowerCase().contains('.jpg') ||
          fileName.toLowerCase().contains('.png') ||
          fileName.toLowerCase().contains('.jpeg')) {
        return const Icon(Icons.image, color: Colors.redAccent, size: 24);
      } else if (fileName.toLowerCase().contains('.pdf')) {
        return const Icon(Icons.picture_as_pdf, color: Colors.red, size: 24);
      } else if (fileName.toLowerCase().contains('.doc') ||
          fileName.toLowerCase().contains('.docx')) {
        return const Icon(Icons.description, color: Colors.blue, size: 24);
      } else {
        return const Icon(Icons.insert_drive_file, color: Colors.blue, size: 24);
      }
    }

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

      var directory =
      Directory("/storage/emulated/0/Download/TeacherApp/Homework");
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
            'File saved to Download/TeacherApp/Homework/$name',
            platformChannelSpecifics,
            payload: path,
          );

          _showSnackBar(context, 'File downloaded successfully');
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

          _showSnackBar(context, 'Find it in the Files/On My iPhone/Teacher App/Homework.');
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

    Future<void> _handleDownload(String url,String imageName) async {

      try {
        // if (attachment.fileSize == "0") {
        //   _showSnackBar(context, 'File not uploaded properly');
        // } else {

          String originalUrl = url; // e.g., "https://sms.arnoldcentralschool.org/SACSv4test/uploads/remark/03-09-2025"
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
          print('Homework Download URL: $downloadUrl');

          if (Platform.isAndroid) {
            await _downloadFileAndroid(downloadUrl, context, imageName, flutterLocalNotificationsPlugin);
          } else if (Platform.isIOS) {
            await _downloadFileIOS(downloadUrl, imageName, flutterLocalNotificationsPlugin);
          } else {
            _showSnackBar(context, 'Unsupported platform');
          }
        // }
      } catch (e) {
        _showSnackBar(context, 'Failed to download file: $e');
      }
    }

    Future<void> onOpenAttachment(String url) async {
      // Similar to your remark implementation
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

    // void _handleDownload(String url) async {
    //   isDownloading.value = true;
    //   try {
    //     final filename = url.split("/").last;
    //     await Utils().onDownload(filename, [url], subfolder: 'TeacherApp/Homework');
    //   } finally {
    //     isDownloading.value = false;
    //   }
    // }

    void onDelete(String filename) async {
      final x = await showDialog<bool?>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm Delete"),
            content: const Text("Are you sure you want to delete this attachment?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Delete"),
              ),
            ],
          );
        },
      );
      if (x ?? false) {
        await homeworkP.deleteDocument(h!, filename);
        _loadAttachments(); // Reload attachments after deletion
        refreshTrigger.value++; // Trigger UI refresh
        return;
      }
    }

    onSave() async {
      final s = fromKey.currentState?.saveAndValidate() ?? false;

      if (selectedClass.value != null && selectedSubject.value != null && s) {
        // Get files from both FormBuilderFilePicker and manually picked files
        final formFiles = fromKey.currentState?.value['files'] as List<PlatformFile>? ?? [];
        final allFiles = [...formFiles, ...pickedFiles.value];

        final d = {
          ...fromKey.currentState?.value ?? {},
          ...selectedClass.value?.toJson() ?? {},
          ...selectedSubject.value?.toJson() ?? {},
        };
        final x = CreateHomeworkBody.fromJson(d);
        final y = x.copyWith(files: allFiles);
        if (await homeworkP.createHomework(y)) {
          return context.pop();
        }
        return;
      }
    }

    onEdit() async {
      if (fromKey.currentState?.saveAndValidate() ?? false) {
        isUploading.value = true;

        try {
          print('=== EDIT HOMEWORK DEBUG ===');
          print('Homework ID: ${h?.homeworkId}');

          // Get files from both FormBuilderFilePicker and manually picked files
          final formFiles = fromKey.currentState?.value['files'] as List<PlatformFile>? ?? [];
          final allFiles = [...formFiles, ...pickedFiles.value];

          print('Total files to upload: ${allFiles.length}');
          print('Form files: ${formFiles.length}');
          print('Picked files: ${pickedFiles.value.length}');

          if (pickedFiles.value.isNotEmpty) {
            print('Picked file names: ${pickedFiles.value.map((f) => f.name).toList()}');
          }

          final d = {
            ...h?.toJson() ?? {},
            ...fromKey.currentState?.value ?? {},
          };

          print('Form data: $d');

          final x = CreateHomeworkBody.fromJson(d);
          final y = x.copyWith(files: allFiles);

          print('Calling updateHomework...');
          final success = await homeworkP.updateHomework(y);
          print('updateHomework result: $success');

          if (success) {
            print('Update successful, clearing picked files and reloading attachments');
            pickedFiles.value = [];
            _loadAttachments();
            _showSnackBar(context, 'Homework updated successfully');
            return context.pop();
          } else {
            _showSnackBar(context, 'Failed to update homework - server returned false');
          }
        } catch (e, stackTrace) {
          print('Error in onEdit: $e');
          print('Stack trace: $stackTrace');
          _showSnackBar(context, 'Error updating homework: $e');
        } finally {
          isUploading.value = false;
        }
      } else {
        _showSnackBar(context, 'Please fill all required fields');
      }
    }

    // Function to reset only submission date and description fields
    void resetForm() {
      fromKey.currentState?.fields['end_date']?.didChange(null);
      fromKey.currentState?.fields['description']?.didChange('');
      pickedFiles.value = [];
    }

    onDownload(String filename) async {
      final documentUrls = await homeworkP.getDocument(h!);
      await Utils().onDownload(filename, documentUrls, subfolder: 'TeacherApp/Homework');
    }

    // Build attachment section for create mode
    Widget _buildCreateAttachmentSection() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Attachments", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.h),
          FormBuilderFilePicker(
            name: "files",
            maxFiles: 5,
            withData: true,
            previewImages: true,
            typeSelectors: [
              TypeSelector(
                type: FileType.any,
                selector: Row(
                  children: <Widget>[
                    Icon(Icons.attach_file, color: Colors.blue),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Add attachments", style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              ),
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
        ],
      );
    }

    // Build attachment section for edit mode
    Widget _buildEditAttachmentSection() {
      final _ = refreshTrigger.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Attachments", style: TextStyle(fontWeight: FontWeight.bold)),
              if (isDownloading.value)
                const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
              else if (isUploading.value)
                const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
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
          else if (existingAttachments.value.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: existingAttachments.value.map((url) {
                  final fileName = url.split("/").last;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            _getFileIcon(fileName),
                            const SizedBox(width: 12),
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
                                ],
                              ),
                            ),
                            if ((fileName.toLowerCase().contains('.jpg') ||
                                fileName.toLowerCase().contains('.png')) &&
                                fileName.isNotEmpty)
                              IconButton(
                                icon: const Icon(Icons.remove_red_eye,
                                    color: Colors.green, size: 20),
                                onPressed: () => onOpenAttachment(url),
                                tooltip: "View",
                              ),
                            IconButton(
                              icon: const Icon(Icons.download,
                                  color: Colors.blue, size: 20),
                              onPressed: isDownloading.value
                                  ? null
                                  : () => _handleDownload(url,fileName),
                              tooltip: "Download",
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.red, size: 20),
                              onPressed: () => onDelete(fileName),
                              tooltip: "Delete",
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )
            else
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text("No attachments",
                    style: TextStyle(color: Colors.grey, fontSize: 14)),
              ),

          // New file selection for edit mode
          if (pickedFiles.value.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("New files to add (${pickedFiles.value.length}):",
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
                  ...pickedFiles.value.map((file) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            _getFileIcon(file.name),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    file.name,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    _formatFileSize(file.size),
                                    style: TextStyle(
                                        fontSize: 12.sp, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.red, size: 20),
                              onPressed: () {
                                pickedFiles.value = pickedFiles.value
                                    .where((f) => f.name != file.name)
                                    .toList();
                              },
                              tooltip: "Remove",
                            ),
                          ],
                        ),
                      ),
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
        title: Text(
          "${h != null ? "Edit" : "Create"} Homework ",
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
                  const Text(
                    "*Class",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  clasess.when(
                    data: (data) {
                      final x = ClassInfo(
                        classId: h?.classId,
                        className: h?.clsName,
                        sectionId: h?.sectionId,
                        sectionName: h?.secName,
                      );
                      return FormBuilderRadioGroup<ClassInfo>(
                        name: 'class',
                        initialValue: h != null ? x : null,
                        enabled: h == null,
                        validator: FormBuilderValidators.required(
                          errorText: 'Class is mandatory',
                        ),
                        options: data
                            .map(
                              (e) => FormBuilderFieldOption(
                            value: e,
                            child: Text("${e.className}${e.sectionName}"),
                          ),
                        )
                            .toList(),
                        decoration: const InputDecoration(border: InputBorder.none),
                        onChanged: (v) {
                          selectedClass.value = v;
                          subjectsP.onChange(v);
                        },
                      );
                    },
                    error: (error, stackTrace) => const SizedBox.shrink(),
                    loading: () => const SizedBox.shrink(),
                  ),

                  SizedBox(height: 5.h),

                  // Subject Dropdown
                  const Text(
                    "*Subject",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.h),
                  Container(
                      child: subjects.when(
                        data: (data) {
                          if (h != null) {
                            return FormBuilderTextField(
                              name: "_",
                              enabled: false,
                              initialValue: h?.subName,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                            );
                          }
                          return FormBuilderDropdown<Subject>(
                            name: 'subject',
                            validator: FormBuilderValidators.required(
                                errorText: 'Subject is mandatory'),
                            hint: const Text("Select Subject"),
                            items: data.map((subject) {
                              return DropdownMenuItem(
                                value: subject,
                                child: Text(subject.name ?? ""),
                              );
                            }).toList(),
                            onChanged: (value) => selectedSubject.value = value,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                          );
                        },
                        error: (error, stackTrace) => const SizedBox.shrink(),
                        loading: () => const SizedBox.shrink(),
                      )),
                  SizedBox(height: 10.h),

                  // Date Picker
                  const Text(
                    "*Submission Date",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.h),

                  FormBuilderDateTimePicker(
                    name: 'end_date',
                    initialValue:
                    h?.endDate == null ? null : DateTime.parse(h!.endDate!),
                    format: DateFormat('dd-MM-yyyy'),
                    inputType: InputType.date,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    valueTransformer: (v) => v.toString().split(" ").first,
                    validator: FormBuilderValidators.required(
                        errorText: 'Submission date is mandatory'),
                    decoration: InputDecoration(
                      hintText: "Submission Date",
                      prefixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  // Description
                  const Text(
                    "*Description",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.h),
                  FormBuilderTextField(
                    name: 'description',
                    maxLines: 3,
                    initialValue: h?.description,
                    validator: FormBuilderValidators.required(
                        errorText: 'Description is mandatory'),
                    decoration: InputDecoration(
                      hintText: "Type here...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // Attachment Section
                  if (h != null) _buildEditAttachmentSection(),
                  if (h == null) _buildCreateAttachmentSection(),

                  // Visible FormBuilderFilePicker for additional file selection
                  // SizedBox(height: 10.h),
                  // FormBuilderFilePicker(
                  //   name: "files",
                  //   maxFiles: 5,
                  //   withData: true,
                  //   previewImages: true,
                  //   typeSelectors: [
                  //     TypeSelector(
                  //       type: FileType.any,
                  //       selector: Row(
                  //         children: <Widget>[
                  //           Icon(Icons.add_circle),
                  //           Padding(
                  //             padding: const EdgeInsets.only(left: 8.0),
                  //             child: Text("Add attachments"),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  SizedBox(height: 10.h),

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
                          onPressed: (isUploading.value || isDownloading.value || homework.isLoading)
                              ? null
                              : h != null ? onEdit : onSave,
                          icon: (isUploading.value || isDownloading.value || homework.isLoading)
                              ? SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                              : Icon(Icons.save, size: 16.sp, color: Colors.white),
                          label: Text(
                            (isUploading.value || isDownloading.value || homework.isLoading)
                                ? "Processing..."
                                : h != null ? "Update" : "Save",
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
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ));
  }
}