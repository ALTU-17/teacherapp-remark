import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/features/homework/providers/providers.dart';
import 'package:teacherapp/router/routers.dart';

import '../models/models.dart';
import 'package:intl/intl.dart';

class HomeworkNoteCard extends HookConsumerWidget {
  final Homework homework;

  const HomeworkNoteCard({super.key, required this.homework});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showActions = useState(false);
    final homeworkP = ref.read(homeWorkPProvider.notifier);
    final showEditActions = useState(false);
    final commentCount = useState<int?>(null);
    final isLoadingCommentCount = useState(false);

    Future<void> _fetchCommentCount() async {
      if (homework.homeworkId == null) return;

      isLoadingCommentCount.value = true;
      try {
        final count = await homeworkP.getCommentCount(homework.homeworkId!);
        commentCount.value = count;
      } catch (e) {
        Utils.debLog('Error fetching comment count: $e');
        commentCount.value = 0;
      } finally {
        isLoadingCommentCount.value = false;
      }
    }

    // Fetch comment count when widget is built
    useEffect(() {
      if (homework.homeworkId != null && homework.publish == 'Y') {
        _fetchCommentCount();
      }
      return null;
    }, [homework.homeworkId, homework.publish]);

    onDelete() async {
      if (await homeworkP.deleteHomeWork(homework)) {
        Utils.toast("Deleted !");
      }
    }

    onPublish(BuildContext context, WidgetRef ref) async {
      final shouldPublish = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Publish Homework'),
          content: const Text('Do you want to publish this homework?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Publish'),
            ),
          ],
        ),
      );


      if (shouldPublish == true) {

        final success = await ref.read(homeWorkPProvider.notifier).publishHomework(homework);
        if (success) {
          Utils.toast('Published successfully');
          // optional: ref.invalidate(homeWorkPProvider);
        } else {
          Utils.toast('Failed to publish');
        }
      }
    }


    void showDeleteConfirmationDialog(BuildContext context) async {
      final x = await showDialog<bool?>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm Delete"),
            content:
                const Text("Are you sure you want to delete this homework?"),
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
        await onDelete();
      }
    }

    final displayCommentCount =
        commentCount.value ?? int.tryParse(homework.commentCount ?? '0') ?? 0;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
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
                      "Class: ${homework.clsName} ${homework.secName}",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),

                /// **Subject**
                Row(
                  children: [
                    const Icon(Icons.menu_book, color: Colors.red, size: 18),
                    SizedBox(width: 8.w),
                    Text(
                      homework.subName ?? "",style: TextStyle(fontSize: 14.sp, color: Colors.black),
                    ),
                  ],
                ),

              ],
            ),

            // SizedBox(height: 6.h),

            Divider(color: Colors.grey.shade300, thickness: 1),

            /// **Description**
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    "Description: ${homework.description}",
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                    "Assign on: ${formatDate(homework.startDate)}",
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
                    "Submit on: ${formatDate(homework.endDate)}",
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                  ),
                ),
                if (homework.publishDate != null && homework.publishDate!.isNotEmpty)
                  Text("Publish on: "+
                    formatDate(homework.publishDate),
                    style: TextStyle(fontSize: 14.sp, color: Colors.green),
                  ),
              ],

            ),

            /// **Action Buttons**
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (homework.publish == 'Y' || showActions.value) ...[
                  if (homework.publish == 'N') ...[
                    /// **✔ Check Button**
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () {
                        showActions.value = false;
                        showEditActions.value = false;
                        onPublish(context,ref);
                      },
                    ),

                    /// **✏ Edit Button**
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        context.push(
                          EditAddHomeWorkRoute().location,
                          extra: homework,
                        );
                      },
                    ),

                    /// **🗑 Delete Button**
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => showDeleteConfirmationDialog(context),
                    ),
                  ] else ...[
                    /// **👀 View Button**
                    IconButton(
                      icon: const Icon(Icons.remove_red_eye,
                          color: Colors.purple),
                      onPressed: () {
                        context.push(HomeWorkViewRoute().location,
                            extra: homework);
                        showActions.value = false;
                      },
                    ),

                    /// **📖 Read Button**
                    IconButton(
                      icon: const Icon(Icons.menu_book, color: Colors.purple),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ViewedByHomeWork(),
                        //   ),
                        // );
                        context.push(HomeWorkParentViewRoute().location,
                            extra: homework);
                        showActions.value = false;
                      },
                    ),

                    /// **Parents Comment Count**
                    // if (displayCommentCount > 0 || isLoadingCommentCount.value)
                    // if (homework.commentCount == 0 || isLoadingCommentCount.value)
                      Row(
                        children: [
                          Text(
                            "Parents Comment  ",
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          if (isLoadingCommentCount.value)
                            SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  const Color.fromARGB(255, 232, 84, 74),
                                ),
                              ),
                            )
                          else
                            // CircleAvatar(
                            //   maxRadius: 13.r,
                            //   backgroundColor:
                            //   const Color.fromARGB(255, 232, 84, 74),
                            //   child: Text(
                            //     displayCommentCount.toString(),
                            //     style: TextStyle(
                            //       fontSize: 10.sp,
                            //       color: Colors.white,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                            CircleAvatar(
                              maxRadius: 13.r,
                              backgroundColor:
                                  const Color.fromARGB(255, 232, 84, 74),
                              child: Text(
                                "${homework.commentCount}",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      )
                  ],
                ] else
                  IconButton(
                    icon: const Icon(Icons.more_horiz, color: Colors.red),
                    onPressed: () {
                      showActions.value = true;
                      showEditActions.value = homework.secName == "SST";
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
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
