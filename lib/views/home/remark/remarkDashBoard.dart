import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:teacherapp/views/home/remark/service/remark_service.dart';
import 'package:teacherapp/features/auth/providers/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:teacherapp/views/home/remark/provider/remark_provider.dart';

import '../../../common/textSanitizer.dart';
import 'addRemark.dart';
import 'editRemark.dart';
import 'model/remark.dart';
import 'viewRemark.dart';

class RemarkDashBoardView extends HookConsumerWidget {
  const RemarkDashBoardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remarksAsync = ref.watch(remarkListProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40.h,
        title: Text(
          "Remarks",
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 140.h),
            Expanded(
              child: remarksAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(child: Text('Error: $err')),
                data: (remarks) => remarks.isNotEmpty
                    ? ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 5.h),
                        itemCount: remarks.length,
                        itemBuilder: (context, index) {
                          return RemarkNoteCard(
                            remark: remarks[index],
                          );
                        },
                      )
                    : Center(
                        child: Text('Remarks not found',
                            style: TextStyle(fontSize: 16.sp))),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddRemark()),
          ).then((res) {
            if (res == true) {
              ref.invalidate(remarkListProvider);
            }
          });
        },
        backgroundColor: const Color.fromARGB(221, 168, 160, 160),
        child: const Icon(Icons.add, size: 30, color: Colors.black),
      ),
    );
  }
}

class RemarkNoteCard extends HookConsumerWidget {
  final Remark remark;
  final Function(String)? onDelete;

  const RemarkNoteCard({super.key, required this.remark, this.onDelete});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showActions = useState(false);
    String cleanedNote = TextSanitizer.cleanText(remark.remarkDesc??'');
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row - class, subject and date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.class_, color: Colors.blue, size: 18),
                    SizedBox(width: 5.w),
                    Text(
                      "Class: ${remark.className ?? ''} ${remark.secName ?? ''}",
                      style: TextStyle(fontSize: 14.sp, color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.menu_book, color: Colors.red, size: 18),
                    SizedBox(width: 8.w),
                    Text(
                      remark.subName ?? '',
                      style: TextStyle(fontSize: 14.sp, color: Colors.black),
                    ),
                  ],
                ),
                if (remark.publishDate != null && remark.publishDate!.isNotEmpty)
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.green, size: 18),
                      SizedBox(width: 5.w),
                      Text(
                        formatDate(remark.publishDate),
                        style: TextStyle(fontSize: 14.sp, color: Colors.black),
                      ),
                    ],
                  ),
              ],
            ),

            const SizedBox(height: 4),
            Divider(color: Colors.grey.shade300, thickness: 1),

            // Student name
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: Text(
                "Student Name: ${remark.firstName ?? ''} ${remark.midName ?? ''} ${remark.lastName ?? ''}",
                style: TextStyle(fontSize: 14.sp, color: Colors.black),
              ),
            ),

            Divider(color: Colors.grey.shade300, thickness: 1),

            // Subject of Remark
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: Text(
                "Subject of Remark: ${remark.remarkSubject}",
                style: TextStyle(fontSize: 14.sp, color: Colors.black),
              ),
            ),

            Divider(color: Colors.grey.shade300, thickness: 1),

            // Remark description
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: Text(
                "Remark: ${cleanedNote}",
                style: TextStyle(fontSize: 14.sp, color: Colors.black),
              ),
            ),

            Divider(color: Colors.grey.shade300, thickness: 1),

            // Remark type and status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Type: ${remark.remarkType}",
                  style: TextStyle(fontSize: 14.sp, color: Colors.black),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: remark.isPublished ? Colors.green : Colors.orange,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    remark.acknowledge == 'Y' ? 'Acknowledge' : remark.isPublished ? "Published" : "Draft",
                    style: TextStyle(fontSize: 12.sp, color: Colors.white),
                  ),
                ),
              ],
            ),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (showActions.value) ...[
                  // Always show view button
                  IconButton(
                    icon:
                        const Icon(Icons.remove_red_eye, color: Colors.purple),
                    tooltip: "View",
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ViewRemark(remark: remark),
                        ),
                      );
                      showActions.value = false;
                    },
                  ),

                  // Show edit and delete buttons only if NOT published
                  if (!remark.isPublished) ...[
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      tooltip: "Edit",
                      onPressed: () async {
                        final changed = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => EditRemark(remark: remark),
                          ),
                        );
                        if (changed == true) {
                          ref.invalidate(remarkListProvider);
                        }
                        showActions.value = false;
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      tooltip: "Delete",
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Delete Remark"),
                            content: const Text(
                                "Are you sure you want to delete this remark?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text("Delete",
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );
                        if (confirm != true) return;

                        final remarkService = ref.read(remarkServiceProvider);
                        final auth = ref.read(authProvider).requireValue;

                        final res = await remarkService.deleteRemark(
                          remarkId: remark.remarkId,
                          academicYr: auth.academicYr ?? '',
                          teacherId: auth.regId ?? '',
                          classId: remark.classId,
                          sectionId: remark.sectionId,
                          subjectId: remark.subjectId ?? '',
                          remarkDesc: remark.remarkDesc,
                          studentId: remark.studentId,
                          remarkDate: remark.remarkDate,
                          remarkSubject: remark.remarkSubject,
                          shortName: auth.teacherVerification?.shortName ?? '',
                        );

                        if (res['status'] == true) {
                          if (onDelete != null) onDelete!(remark.remarkId);
                          ref.invalidate(remarkListProvider);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Remark deleted successfully')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(res['error_msg'] ?? 'Failed to delete remark')),
                          );
                        }

                      },
                    ),
                  ],

                  // Show publish button only if NOT published
                  if (!remark.isPublished && remark.remarkType !='Observation' )
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      tooltip: "Publish",
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Publish Remark"),
                            content: const Text(
                                "Are you sure you want to publish this remark?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text("Publish",
                                    style: TextStyle(color: Colors.green)),
                              ),
                            ],
                          ),
                        );
                        if (confirm != true) return;

                        _publishRemark(context, ref, remark);
                        showActions.value = false;
                      },
                    ),
                ] else ...[
                  if (!remark.isPublished)
                    IconButton(
                      icon: const Icon(Icons.more_horiz, color: Colors.red),
                      tooltip: "More Options",
                      onPressed: () {
                        showActions.value = true;
                      },
                    )
                  else
                    IconButton(
                      icon: const Icon(Icons.remove_red_eye,
                          color: Colors.purple),
                      tooltip: "View",
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ViewRemark(remark: remark),
                          ),
                        );
                        showActions.value = false;
                      },
                    ),
                  if(remark.acknowledge == 'Y')
                  IconButton(
                      icon: const Icon(Icons.thumb_up_sharp,
                          color: Colors.black),
                      tooltip: "Acknowledge",
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ViewRemark(remark: remark),
                          ),
                        );
                        showActions.value = false;
                      },
                    ),
                ]
              ],
            )
          ],
        ),
      ),
    );
  }

  void _publishRemark(
      BuildContext context, WidgetRef ref, Remark remark) async {
    final remarkService = ref.read(remarkServiceProvider);
    final auth = ref.read(authProvider).requireValue;

    try {
      final result = await remarkService.publishRemark(
        remarkId: remark.remarkId,
        teacherId: auth.regId ?? '',
        studentId: remark.studentId,
        shortName: auth.teacherVerification?.shortName ?? '',
      );

      if (result['status'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Remark Published!")),
        );
        // Refresh the remarks list
        ref.invalidate(remarkListProvider);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(result['error_msg'] ?? 'Failed to publish remark')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error publishing remark: $e')),
      );
    }
  }
  String formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return "";
    try {
      // Parse input (e.g., "2025-09-26 00:00:00")
      DateTime parsedDate = DateTime.parse(dateString.split(" ").first);
      return DateFormat("dd-MM-yyyy").format(parsedDate);
    } catch (e) {
      return dateString; // fallback if parsing fails
    }
  }
}
