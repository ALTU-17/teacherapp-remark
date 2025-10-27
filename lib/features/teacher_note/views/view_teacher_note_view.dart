import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/features/home/providers/academic_year_provider.dart';
import 'package:teacherapp/features/teacher_note/providers/providers.dart';

import '../models/note.dart';

class ViewTeacherNoteView extends HookConsumerWidget {
  final Note note;

  const ViewTeacherNoteView({super.key, required this.note});

  Future<void> _downloadFile(BuildContext context, String url) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = "${dir.path}/${url.split("/").last}";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Downloading...")),
      );

      await Dio().download(url, filePath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Downloaded to $filePath")),
      );

      await OpenFilex.open(filePath); // Open after download
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Download failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teacherP = ref.read(teacherNoteProvider.notifier);
    final acdYear = ref.watch(academicYearProvider).requireValue;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40.h,
        title: Text(
          "Teacher Note ",
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink, Colors.blue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.w, 170.h, 10.w, 40.h),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _infoTable([
                    {
                      "Class:":
                          "${note.classname ?? ""} ${note.sectionname ?? ""}"
                    },
                    {"Subject:": note.subjectname ?? ""},
                    {
                      "Created Date:": note.date != null
                          ? DateFormat('dd-MM-yyyy')
                              .format(DateTime.parse(note.date!))
                          : ""
                    },
                    {
                      "Published Date:": note.publishDate != null
                          ? DateFormat('dd-MM-yyyy').format(note.publishDate!)
                          : ""
                    },
                    {"Description:": note.description ?? ""},
                  ]),
                  FutureBuilder<List<String>>(
                    future: teacherP.getDocument(note),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox();
                      }

                      final files = snapshot.data ?? [];
                      if (files.isEmpty) return const SizedBox();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(color: Colors.grey.shade300, thickness: 1),
                          SizedBox(height: 8.h),
                          Text(
                            "Attachments:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          ...files.map(
                            (fileUrl) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              child: Row(
                                children: [
                                  const Icon(Icons.attach_file,
                                      color: Colors.blue),
                                  Expanded(
                                    child: Text(
                                      fileUrl.split("/").last,
                                      style: TextStyle(fontSize: 14.sp),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.download_rounded,
                                        color: Colors.green),
                                    onPressed: () =>
                                        _downloadFile(context, fileUrl),
                                  ),
                                  if ((fileUrl.endsWith('.jpg') ||
                                      fileUrl.endsWith('.png')) &&
                                      fileUrl.isNotEmpty)
                                  IconButton(
                                    icon: const Icon(Icons.remove_red_eye,
                                        color: Color.fromARGB(255, 49, 48, 48)),
                                    onPressed: () {
                                      // Utils.debLog(fileName);
                                      Utils.openFileView(fileUrl);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTable(List<Map<String, String>> data) {
    return Column(
      children: data.map(
        (row) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120.w,
                  child: Text(
                    row.keys.first,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    row.values.first,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                  ),
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}
