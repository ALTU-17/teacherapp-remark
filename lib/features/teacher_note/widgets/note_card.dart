import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/features/teacher_note/providers/providers.dart';
import 'package:teacherapp/router/routers.dart';

import '../models/note.dart';
import '../views/EditNote.dart';

class NoteCard extends HookConsumerWidget {
  final Note note;
  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showActions = useState(false);
    final showEditActions = useState(false);
    final noteP = ref.read(teacherNoteProvider.notifier);
    final isPublishing = useState(false);

    onDelete() async {
      if (await noteP.deleteNote(note)) {
        Utils.toast("Deleted !");
      }
    }

    onPublish(BuildContext context, WidgetRef ref) async {
      if (isPublishing.value) return;

      final shouldPublish = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Publish Note'),
          content: const Text('Do you want to publish the Note?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Publish', style: TextStyle(color: Colors.green)),
            ),
          ],
        ),
      );

      if (shouldPublish == true) {
        isPublishing.value = true;

        try {
          final success = await ref.read(teacherNoteProvider.notifier).publishNote(note);
          if (success) {
            Fluttertoast.showToast(msg: "Note Published Successfully!");
            ref.invalidate(teacherNoteProvider);
          } else {
            Fluttertoast.showToast(msg: "Failed to publish note.");
          }
        } catch (e) {
          Fluttertoast.showToast(msg: "Error publishing note: $e");
        } finally {
          isPublishing.value = false;
        }
      }
    }

    void showDeleteConfirmationDialog(BuildContext context) async {
      final x = await showDialog<bool?>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Note"),
            content: const Text("Are you sure you want to delete this Note?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Delete", style: TextStyle(color: Colors.red)),
              ),
            ],
          );
        },
      );
      if (x ?? false) {
        await onDelete();
      }
    }

    return Stack(
      children: [
        Card(
          margin: EdgeInsets.symmetric(vertical: 8.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Opacity(
              opacity: isPublishing.value ? 0.6 : 1.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// **Class & Subject Row**
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.class_, color: Colors.blue, size: 18),
                          SizedBox(width: 5.w),
                          Text(
                            "Class: ${note.classname}",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.menu_book, color: Colors.red, size: 18),
                          SizedBox(width: 8.w),
                          Text(
                            note.subjectname ?? "",
                            style: TextStyle(fontSize: 14.sp, color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, color: Colors.green, size: 18),
                          SizedBox(width: 5.w),
                          Text(
                            note.date != null
                                ? DateFormat('dd-MM-yyyy').format(DateTime.parse(note.date!))
                                : "",
                            style: TextStyle(fontSize: 14.sp, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Divider(color: Colors.grey.shade300, thickness: 1),

                  /// **Description**
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          "Description: ${note.description}",
                          style: TextStyle(fontSize: 14.sp, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey.shade300, thickness: 1),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          "Create on: ${note.date != null
                              ? DateFormat('dd-MM-yyyy').format(DateTime.parse(note.date!))
                              : ""}",
                          style: TextStyle(fontSize: 14.sp, color: Colors.black),
                        ),
                      ),
                    ],
                  ),

                  /// **Action Buttons**
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (note.publish == 'Y' || showActions.value) ...[
                        if (note.publish == 'N') ...[
                          /// **✔ Check Button**
                          IconButton(
                            icon: const Icon(Icons.check, color: Colors.green),
                            onPressed: isPublishing.value ? null : () {
                              showActions.value = false;
                              showEditActions.value = false;
                              onPublish(context, ref);
                            },
                          ),

                          /// **✏ Edit Button**
                          IconButton(
                            icon: Icon(Icons.edit,
                                color: isPublishing.value ? Colors.grey : Colors.blue),
                            onPressed: isPublishing.value ? null : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditTeacherNoteView(
                                    note: note,
                                    onNoteUpdated: () {
                                      ref.read(teacherNoteProvider.notifier).refreshNotes();
                                    },
                                  ),
                                ),
                              );
                            },
                          ),

                          /// **🗑 Delete Button**
                          IconButton(
                            icon: Icon(Icons.delete,
                                color: isPublishing.value ? Colors.grey : Colors.red),
                            onPressed: isPublishing.value ? null : () => showDeleteConfirmationDialog(context),
                          ),
                        ] else ...[
                          /// **👀 View Button**
                          IconButton(
                            icon: const Icon(Icons.remove_red_eye, color: Colors.purple),
                            onPressed: () {
                              context.push(TeacherNoteViewRoute().location, extra: note);
                              showActions.value = false;
                            },
                          ),

                          /// **📖 Read Button**
                          IconButton(
                            icon: const Icon(Icons.menu_book, color: Colors.purple),
                            onPressed: () {
                              context.push(TeacherNoteViewedByRoute().location, extra: note);
                              showActions.value = false;
                            },
                          ),
                        ],
                      ] else
                        IconButton(
                          icon: Icon(Icons.more_horiz,
                              color: isPublishing.value ? Colors.grey : Colors.red),
                          onPressed: isPublishing.value ? null : () {
                            showActions.value = true;
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // Loading overlay
        if (isPublishing.value)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8.r,
                        offset: Offset(0, 2.h),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 25.w,
                        height: 25.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Publishing...',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  String formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return "";
    try {
      DateTime parsedDate = DateTime.parse(dateString.split(" ").first);
      return DateFormat("dd-MM-yyyy").format(parsedDate);
    } catch (e) {
      return dateString;
    }
  }
}