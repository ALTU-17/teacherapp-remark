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
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          // App Bar with gradient
          SliverAppBar(
            expandedHeight: 118.h,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFEF2C42),
                      Color(0xFF764BA2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 45.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 45.w,
                              height: 48.h,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ),
                              child: Icon(
                                Icons.comment_rounded,
                                color: Colors.white,
                                size: 24.w,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Remarks",
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(height: 4.h),
                                  remarksAsync.when(
                                    data: (data) => Text(
                                      "${data.length} remark${data.length != 1 ? 's' : ''} available",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white.withOpacity(0.9),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    loading: () => Text(
                                      "Loading remarks...",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white.withOpacity(0.7),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    error: (_, __) => Text(
                                      "Unable to load remarks",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white.withOpacity(0.7),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 60.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30.h),
              child: Container(
                height: 30.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: remarksAsync.when(
              loading: () => Container(
                height: 400.h,
                padding: EdgeInsets.all(24.w),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 40.w,
                        height: 40.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFFEF2C42),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Loading Remarks...",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              error: (err, _) => Container(
                height: 400.h,
                padding: EdgeInsets.all(24.w),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        size: 60.w,
                        color: Colors.red.shade400,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Failed to load remarks",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Please check your connection",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey.shade500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24.h),
                      ElevatedButton(
                        onPressed: () => ref.refresh(remarkListProvider),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF667EEA),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.w,
                            vertical: 12.h,
                          ),
                        ),
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                ),
              ),
              data: (remarks) {
                if (remarks.isEmpty) {
                  return _buildEmptyState(context);
                }

                // Count published and draft remarks
                final publishedCount = remarks.where((r) => r.isPublished).length;
                final draftCount = remarks.length - publishedCount;

                return Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.w),
                  child: Column(
                    children: [
                      // Stats Card
                      Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem(
                              icon: Icons.comment_rounded,
                              value: "${remarks.length}",
                              label: "Total",
                              color: const Color(0xFF667EEA),
                            ),
                            Container(
                              width: 1,
                              height: 30.h,
                              color: Colors.grey.shade200,
                            ),
                            _buildStatItem(
                              icon: Icons.check_circle_rounded,
                              value: "$publishedCount",
                              label: "Published",
                              color: Colors.green.shade600,
                            ),
                            Container(
                              width: 1,
                              height: 30.h,
                              color: Colors.grey.shade200,
                            ),
                            _buildStatItem(
                              icon: Icons.drafts_rounded,
                              value: "$draftCount",
                              label: "Draft",
                              color: Colors.orange.shade600,
                            ),
                          ],
                        ),
                      ),
                      // Remarks List
                      ...remarks.map((remark) =>
                          RemarkNoteCard(
                            remark: remark,
                            onDelete: (id) {
                              ref.invalidate(remarkListProvider);
                            },
                          )
                      ).toList(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
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
        backgroundColor: const Color(0xFFEF2C42),
        elevation: 4,
        child: const Icon(Icons.add_rounded, size: 30, color: Colors.white),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16.w,
              color: color,
            ),
            SizedBox(width: 6.w),
            Text(
              value,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      height: 400.h,
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF667EEA).withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.comment_outlined,
                size: 60.w,
                color: const Color(0xFF667EEA).withOpacity(0.6),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            "No Remarks Found",
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "You haven't created any remarks yet.\nTap the + button to add your first remark.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade500,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddRemark()),
              ).then((res) {
                if (res == true) {
                  // Refresh will happen via provider
                }
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF667EEA),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 32.w,
                vertical: 12.h,
              ),
            ),
            icon: const Icon(Icons.add_rounded),
            label: const Text("Create First Remark"),
          ),
        ],
      ),
    );
  }
}

// Updated RemarkNoteCard with modern styling
class RemarkNoteCard extends HookConsumerWidget {
  final Remark remark;
  final Function(String)? onDelete;

  const RemarkNoteCard({super.key, required this.remark, this.onDelete});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showActions = useState(false);
    String cleanedNote = TextSanitizer.cleanText(remark.remarkDesc ?? '');

    return Container(
      margin: EdgeInsets.only(bottom: 5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: remark.isPublished ? Colors.green.shade100 : Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: remark.isPublished ? Colors.green.shade50 : Colors.grey.shade50,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.class_rounded,
                          color: Colors.blue.shade700,
                          size: 16.w,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "${remark.className ?? ''} ${remark.secName ?? ''}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: remark.isPublished ? Colors.green : Colors.orange,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    remark.acknowledge == 'Y'
                        ? 'Acknowledged'
                        : remark.isPublished ? "Published" : "Draft",
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.fromLTRB(12,5,12,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Subject
                Row(
                  children: [
                    Icon(Icons.menu_book_rounded, color: Colors.red.shade400, size: 16.w),
                    SizedBox(width: 8.w),
                    Text(
                      remark.subName ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.calendar_today_rounded, color: Colors.green.shade600, size: 16.w),
                    SizedBox(width: 6.w),
                    Text(
                      formatDate(remark.publishDate),
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                // Student Name
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.person_rounded, color: Colors.blue.shade700, size: 18.w),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          "${remark.firstName ?? ''} ${remark.midName ?? ''} ${remark.lastName ?? ''}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10.h),

                // Subject of Remark
                Row(
                  children: [
                    Icon(Icons.subject_rounded, color: Colors.purple.shade400, size: 16.w),
                    SizedBox(width: 8.w),
                    Text(
                      "Subject: ",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        remark.remarkSubject ?? '',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),

                // Remark Description
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Remark:",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        cleanedNote,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                ),


                // Action Buttons
                // Divider(color: Colors.grey.shade200),
                // SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // View button always visible
                    _buildActionButton(
                      icon: Icons.remove_red_eye_rounded,
                      color: Colors.purple,
                      tooltip: "View",
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ViewRemark(remark: remark),
                          ),
                        );
                      },
                    ),

                    if (showActions.value && !remark.isPublished) ...[
                      _buildActionButton(
                        icon: Icons.edit_rounded,
                        color: Colors.blue,
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
                      _buildActionButton(
                        icon: Icons.delete_rounded,
                        color: Colors.red,
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
                          showActions.value = false;
                        },
                      ),
                      if (!remark.isPublished && remark.remarkType != 'Observation')
                        _buildActionButton(
                          icon: Icons.check_rounded,
                          color: Colors.green,
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
                    ],

                    if (!showActions.value && !remark.isPublished)
                      _buildActionButton(
                        icon: Icons.more_horiz_rounded,
                        color: Colors.grey,
                        tooltip: "More Options",
                        onPressed: () {
                          showActions.value = true;
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      icon: Icon(icon, color: color, size: 22.w),
      tooltip: tooltip,
      onPressed: onPressed,
      padding: EdgeInsets.all(6.w),
      constraints: const BoxConstraints(),
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
          const SnackBar(
            content: Text("Remark Published!"),
            backgroundColor: Colors.green,
          ),
        );
        ref.invalidate(remarkListProvider);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['error_msg'] ?? 'Failed to publish remark'),
            backgroundColor: Colors.red,
          ),
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
      DateTime parsedDate = DateTime.parse(dateString.split(" ").first);
      return DateFormat("dd-MM-yyyy").format(parsedDate);
    } catch (e) {
      return dateString;
    }
  }
}