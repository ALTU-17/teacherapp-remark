import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../views/teacher_id.dart';

class WeeklyLessonPending {
  final String pendingClasses;
  final String week;
  final int teacherId;
  final String name;
  final String phone;

  WeeklyLessonPending({
    required this.pendingClasses,
    required this.week,
    required this.teacherId,
    required this.name,
    required this.phone,
  });

  factory WeeklyLessonPending.fromJson(Map<String, dynamic> json) {
    // FIX 1: Safe parsing for all fields with proper null/type handling
    int teacherId;
    try {
      teacherId = int.parse(json["teacher_id"]?.toString() ?? "0");
    } catch (_) {
      teacherId = 0;
    }

    // FIX 2: Handle pending_classes being null, "null" string, or missing
    final rawPending = json["pending_classes"];
    String pendingClasses = "";
    if (rawPending != null &&
        rawPending.toString().toLowerCase() != "null" &&
        rawPending.toString().trim().isNotEmpty) {
      pendingClasses = rawPending.toString();
    }

    // FIX 7: Properly extract week from the JSON
    String week = "";
    final rawWeek = json["week"];
    if (rawWeek != null &&
        rawWeek.toString().toLowerCase() != "null" &&
        rawWeek.toString().trim().isNotEmpty) {
      week = rawWeek.toString();
    }

    return WeeklyLessonPending(
      pendingClasses: pendingClasses,
      teacherId: teacherId,
      name: json["name"]?.toString() ?? "Unknown",
      phone: json["phone"]?.toString() ?? "",
      week: week,
    );
  }

  String get initials {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return "?";
    final parts = trimmed.split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return trimmed.length >= 2
        ? trimmed.substring(0, 2).toUpperCase()
        : trimmed.toUpperCase();
  }

  // FIX 3: Robust classList that handles all edge cases
  List<String> get classList {
    if (pendingClasses.isEmpty ||
        pendingClasses.toLowerCase() == 'null' ||
        pendingClasses.trim() == ',') {
      return [];
    }
    return pendingClasses
        .split(",")
        .map((c) => c.trim())
        .where((c) => c.isNotEmpty && c.toLowerCase() != 'null')
        .toList();
  }

  // FIX 4: Helper to quickly check if teacher actually has upcoming plans
  bool get hasPendingClasses => classList.isNotEmpty;
}

// FIX 8: Create a wrapper class to hold both the list and the week
class WeeklyLessonPendingResponse {
  final List<WeeklyLessonPending> list;
  final String week;
  final List<String> createdList;

  WeeklyLessonPendingResponse({
    required this.list,
    required this.week,
    this.createdList = const [],
  });

  factory WeeklyLessonPendingResponse.fromJson(Map<String, dynamic> json) {
    // Extract the list of upcoming classes
    final list = (json["list"] as List?)
        ?.map((item) => WeeklyLessonPending.fromJson(item as Map<String, dynamic>))
        .toList() ?? [];

    // Extract week from root level
    final week = json["week"]?.toString() ?? "";

    // Extract createdList if needed
    final createdList = (json["createdList"] as List?)
        ?.map((item) => item.toString())
        .toList() ?? [];

    return WeeklyLessonPendingResponse(
      list: list,
      week: week,
      createdList: createdList,
    );
  }

  // FIX 9: Filter teachers with actual upcoming classes
  List<WeeklyLessonPending> get filteredList =>
      list.where((t) => t.hasPendingClasses).toList();

  // Helper to check if there are any upcoming classes
  bool get hasPendingClasses => filteredList.isNotEmpty;
}


final weeklyLessonPendingProvider =
FutureProvider.autoDispose<WeeklyLessonPendingResponse>((ref) async {
  final api = ref.watch(staffApiProvider);

  final response = await api.getWeeklyLessonPending();

  return WeeklyLessonPendingResponse(
    list: response.list
        .where((t) => t.hasPendingClasses)
        .toList(),
    week: response.week,
    createdList: response.createdList,
  );
});

class WeeklyLessonPlansScreen extends ConsumerStatefulWidget {
  const WeeklyLessonPlansScreen({super.key});

  @override
  ConsumerState<WeeklyLessonPlansScreen> createState() =>
      _WeeklyLessonPlansScreenState();
}

class _WeeklyLessonPlansScreenState
    extends ConsumerState<WeeklyLessonPlansScreen> {
  int? expandedTeacherId;

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(weeklyLessonPendingProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          // App Bar with gradient
          SliverAppBar(
            expandedHeight: 130.h, // Increased height to accommodate week info
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
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
                    padding:
                    EdgeInsets.symmetric(horizontal: 45.w, vertical: 0.h),
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
                                Icons.assignment_outlined,
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
                                    "Lesson Plans",
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          color:
                                          Colors.black.withOpacity(0.3),
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  // FIX 11: Display the week in the app bar
                                  async.when(
                                    data: (response) => Text(
                                      "Week: ${response.week}",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white.withOpacity(0.9),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    loading: () => Text(
                                      "Loading week...",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white.withOpacity(0.7),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    error: (_, __) => Text(
                                      "Week information unavailable",
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
                  color: Color(0xFFF8F9FA),
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
            child: async.when(
              loading: () => Container(
                height: 400.h,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 40.w,
                        height: 40.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFFEF2C42)),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Loading Upcoming Plans...",
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
                        "Failed to load data",
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
                        onPressed: () =>
                            ref.refresh(weeklyLessonPendingProvider),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF667EEA),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.w,
                            vertical: 12.h,
                          ),
                        ),
                        child: Text("Retry"),
                      ),
                    ],
                  ),
                ),
              ),
              data: (response) {
                final list = response.filteredList;
                if (list.isEmpty) {
                  return _buildEmptyState();
                }

                return Padding(
                  padding:
                  EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.w),
                  child: Column(
                    children: [
                      // FIX 12: Display the week as a header card
                      Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        padding: EdgeInsets.symmetric(
                          horizontal: 50.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 20.w,
                              color: Color(0xFF667EEA),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Upcoming Week",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    response.week,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFF667EEA).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ...list.map((t) => _buildTeacherCard(t)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeacherCard(WeeklyLessonPending teacher) {
    final isExpanded = expandedTeacherId == teacher.teacherId;
    final pendingCount = teacher.classList.length;
    final primaryColor = _getTeacherColor(teacher.teacherId);

    // FIX 6: Guard — don't render card if no upcoming classes
    if (!teacher.hasPendingClasses) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            setState(() {
              expandedTeacherId = isExpanded ? null : teacher.teacherId;
            });
          },
          child: Column(
            children: [
              // Teacher Header
              Padding(
                padding: EdgeInsets.only(
                    left: 15.w, right: 15.w, bottom: 10.w, top: 10),
                child: Row(
                  children: [
                    // Teacher Avatar
                    // Container(
                    //   width: 56.w,
                    //   height: 56.h,
                    //   decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //       colors: [
                    //         primaryColor,
                    //         primaryColor.withOpacity(0.8),
                    //       ],
                    //       begin: Alignment.topLeft,
                    //       end: Alignment.bottomRight,
                    //     ),
                    //     shape: BoxShape.circle,
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: primaryColor.withOpacity(0.3),
                    //         blurRadius: 8,
                    //         offset: Offset(0, 4),
                    //       ),
                    //     ],
                    //   ),
                    //   child: Center(
                    //     child: Text(
                    //       teacher.initials,
                    //       style: TextStyle(
                    //         fontSize: 18.sp,
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(width: 16.w),

                    // Teacher Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   teacher.name,
                          //   style: TextStyle(
                          //     fontSize: 16.sp,
                          //     fontWeight: FontWeight.w600,
                          //     color: Colors.grey.shade800,
                          //   ),
                          //   maxLines: 1,
                          //   overflow: TextOverflow.ellipsis,
                          // ),
                          // SizedBox(height: 4.h),
                          // // FIX 13: Display week next to teacher info too
                          // Center(
                          //   child: Text(
                          //     "Week: ${teacher.week}",
                          //     style: TextStyle(
                          //       fontSize: 12.sp,
                          //       color: Colors.grey.shade500,
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: 4.h),
                          Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade50,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: Colors.orange.shade100,
                                ),
                              ),
                              child: Text(
                                "$pendingCount upcoming ${pendingCount == 1 ? 'class' : 'classes'}",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.orange.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Expanded Content
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 0,
                ),
                child: Column(
                  children: [
                    Divider(
                      height: 1,
                      color: Colors.grey.shade200,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row(
                          //   children: [
                          //     Icon(
                          //       Icons.warning_amber_outlined,
                          //       size: 18.w,
                          //       color: Colors.orange.shade600,
                          //     ),
                          //     SizedBox(width: 8.w),
                          //     Text(
                          //       "upcoming Weekly Lesson Plans",
                          //       style: TextStyle(
                          //         fontSize: 15.sp,
                          //         fontWeight: FontWeight.w600,
                          //         color: Colors.grey.shade800,
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          // Classes List
                          ...teacher.classList.asMap().entries.map((entry) {
                            final index = entry.key;
                            final className = entry.value;
                            return Container(
                              margin: EdgeInsets.only(bottom: 4.h),
                              child: Material(
                                color: index.isEven
                                    ? Colors.grey.shade50
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12.r),
                                  onTap: () {},
                                  child: Padding(
                                    padding: EdgeInsets.all(12.w),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 32.w,
                                          height: 32.h,
                                          decoration: BoxDecoration(
                                            color:
                                            primaryColor.withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text(
                                              (index + 1).toString(),
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 12.w),
                                        Expanded(
                                          child: Text(
                                            className,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.grey.shade800,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.w,
                                            vertical: 4.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.red.shade50,
                                            borderRadius:
                                            BorderRadius.circular(8.r),
                                            border: Border.all(
                                              color: Colors.red.shade100,
                                            ),
                                          ),
                                          child: Text(
                                            "upcoming",
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.red.shade700,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          SizedBox(height: 40.h),
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: Color(0xFFE3F2FD),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF667EEA).withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.check_circle_outline_rounded,
                size: 60.w,
                color: Color(0xFF667EEA).withOpacity(0.6),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            "All Caught Up!",
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "No upcoming weekly lesson plans found.\nAll teachers have submitted their schedules.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade500,
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Color _getTeacherColor(int teacherId) {
    final colors = [
      Color(0xFF667EEA),
      Color(0xFF764BA2),
      Color(0xFFF093FB),
      Color(0xFFF5576C),
      Color(0xFF4FACFE),
      Color(0xFF00F2FE),
      Color(0xFF43E97B),
      Color(0xFF38F9D7),
      Color(0xFFFA709A),
      Color(0xFFFEE140),
    ];
    return colors[teacherId % colors.length];
  }
}