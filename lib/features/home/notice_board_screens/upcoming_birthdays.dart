import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import '../views/teacher_id.dart';

class BirthdayStudent {
  final int studentId;
  final String firstName;
  final String midName;
  final String lastName;
  final String dob;
  final String className;
  final String sectionName;

  BirthdayStudent({
    required this.studentId,
    required this.firstName,
    required this.midName,
    required this.lastName,
    required this.dob,
    required this.className,
    required this.sectionName,
  });

  factory BirthdayStudent.fromJson(Map<String, dynamic> json) {
    return BirthdayStudent(
      studentId: json['student_id'] ?? 0,
      firstName: json['first_name']?.toString() ?? '',
      midName: json['mid_name']?.toString() ?? '',
      lastName: json['last_name']?.toString() ?? '',
      dob: json['dob']?.toString() ?? '', // Add null safety
      className: json['class_name']?.toString() ?? '',
      sectionName: json['section_name']?.toString() ?? '',
    );
  }

  String get fullName =>
      [firstName, midName, lastName].where((e) => e.isNotEmpty).join(' ');

  String get initials {
    final first = firstName.isNotEmpty ? firstName[0] : '';
    final last = lastName.isNotEmpty ? lastName[0] : '';
    return '$first$last'.toUpperCase();
  }
}

class BirthdayStaff {
  final int teacherId;
  final String name;
  final String birthday;
  final String phone;
  final String email;
  final String designation;

  BirthdayStaff({
    required this.teacherId,
    required this.name,
    required this.birthday,
    required this.phone,
    required this.email,
    required this.designation,
  });

  factory BirthdayStaff.fromJson(Map<String, dynamic> json) {
    return BirthdayStaff(
      teacherId: json['teacher_id'] ?? 0,
      name: json['name']?.toString() ?? '',
      birthday: json['birthday']?.toString() ?? '', // Add null safety
      phone: json['phone']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      designation: json['designation']?.toString() ?? '',
    );
  }

  String get initials {
    if (name.isEmpty) return "";
    return name.split(" ").map((e) => e.isNotEmpty ? e[0] : "").take(2).join().toUpperCase();
  }
}


final birthdayProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final api = ref.watch(staffApiProvider);
  return api.getBirthdays();
});

const headerColor = Color(0xFFD01C7F);
const todayColor = Color(0xFFFF6B6B);
const tomorrowColor = Color(0xFFFFA726);
const yesterdayColor = Color(0xFF78909C);
const backgroundColor = Color(0xFFF8F9FA);
const staffColor = Color(0xFF4285F4);
const studentColor = Color(0xFFEA4335);

class BirthdayScreen extends ConsumerStatefulWidget {
  const BirthdayScreen({super.key});

  @override
  ConsumerState<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends ConsumerState<BirthdayScreen> {
  // Expanded states for each category
  bool isTodayStaffExpanded = false;
  bool isTomorrowStaffExpanded = false;
  bool isYesterdayStaffExpanded = false;
  bool isTodayStudentsExpanded = false;
  bool isTomorrowStudentsExpanded = false;
  bool isYesterdayStudentsExpanded = false;

  @override
  Widget build(BuildContext context) {
    final birthdayAsync = ref.watch(birthdayProvider);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          // App Bar with gradient
          SliverAppBar(
            expandedHeight: 160.h,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFE91E63),
                      Color(0xFF9C27B0),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(left: 50, bottom: 30.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '      Birthdays 🎂',
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '     Celebrating our students and staff',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        _buildStatsRow(ref),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20.h),
              child: Container(
                height: 20.h,
                decoration: BoxDecoration(
                  color: backgroundColor,
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
            child: birthdayAsync.when(
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
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE91E63)),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Loading Birthdays...",
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
              error: (e, _) => Container(
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
                        "Failed to load birthdays",
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
                      ),
                      SizedBox(height: 24.h),
                      ElevatedButton(
                        onPressed: () => ref.refresh(birthdayProvider),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE91E63),
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
              data: (data) {
                final students = data["students"];
                final staff = data["staff"];

                final todayStudents = students["today"] as List<BirthdayStudent>? ?? [];
                final tomorrowStudents = students["tomorrow"] as List<BirthdayStudent>? ?? [];
                final yesterdayStudents = students["yesterday"] as List<BirthdayStudent>? ?? [];

                final todayStaff = staff["today"] as List<BirthdayStaff>? ?? [];
                final tomorrowStaff = staff["tomorrow"] as List<BirthdayStaff>? ?? [];
                final yesterdayStaff = staff["yesterday"] as List<BirthdayStaff>? ?? [];

                final allEmpty =
                    todayStudents.isEmpty &&
                        tomorrowStudents.isEmpty &&
                        yesterdayStudents.isEmpty &&
                        todayStaff.isEmpty &&
                        tomorrowStaff.isEmpty &&
                        yesterdayStaff.isEmpty;

                if (allEmpty) return _buildEmptyState();

                return Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      // Staff Cards
                      _buildExpandableCard(
                        title: "Staff Birthdays",
                        subtitle: "Celebrating our teaching staff",
                        icon: Icons.person_pin_rounded,
                        isExpanded: isTodayStaffExpanded,
                        onExpand: () => setState(() => isTodayStaffExpanded = !isTodayStaffExpanded),
                        todayList: todayStaff,
                        tomorrowList: tomorrowStaff,
                        yesterdayList: yesterdayStaff,
                        isStaff: true,
                      ),
                      SizedBox(height: 1.h),

                      // Students Cards
                      _buildExpandableCard(
                        title: "Student Birthdays",
                        subtitle: "Celebrating our students",
                        icon: Icons.school_outlined,
                        isExpanded: isTodayStudentsExpanded,
                        onExpand: () => setState(() => isTodayStudentsExpanded = !isTodayStudentsExpanded),
                        todayList: todayStudents,
                        tomorrowList: tomorrowStudents,
                        yesterdayList: yesterdayStudents,
                        isStaff: false,
                      ),
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

  Widget _buildExpandableCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isExpanded,
    required VoidCallback onExpand,
    required List todayList,
    required List tomorrowList,
    required List yesterdayList,
    required bool isStaff,
  }) {
    final totalCount = todayList.length + tomorrowList.length + yesterdayList.length;
    final primaryColor = isStaff ? staffColor : studentColor;
    final lightColor = isStaff ? staffColor.withOpacity(0.1) : studentColor.withOpacity(0.1);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        elevation: 4,
        child: Column(
          children: [
            // Header
            InkWell(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              onTap: onExpand,
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: lightColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 24.w,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: primaryColor.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        "$totalCount ${isStaff ? 'staff' : 'students'}",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 1.w),
                    AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0,
                      duration: Duration(milliseconds: 300),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: primaryColor,
                        size: 28.w,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Expanded Content
            if (isExpanded)
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Column(
                  children: [
                    Divider(height: 1, color: Colors.grey.shade200),
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        children: [
                          // Today Section
                          if (todayList.isNotEmpty)
                            _buildDateSection(
                              title: "🎉 Today",
                              list: todayList,
                              color: isStaff != true ? todayColor : staffColor,
                              isStaff: isStaff,
                            ),

                          // Tomorrow Section
                          if (tomorrowList.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: 24.h),
                              child: _buildDateSection(
                                title: "🎈 Tomorrow",
                                list: tomorrowList,
                                color: tomorrowColor,
                                isStaff: isStaff,
                              ),
                            ),

                          // Yesterday Section
                          if (yesterdayList.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: 24.h),
                              child: _buildDateSection(
                                title: "✨ Yesterday",
                                list: yesterdayList,
                                color: yesterdayColor,
                                isStaff: isStaff,
                              ),
                            ),

                          // Empty message if all lists are empty
                          if (todayList.isEmpty && tomorrowList.isEmpty && yesterdayList.isEmpty)
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 32.h),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.cake_outlined,
                                    size: 48.w,
                                    color: Colors.grey.shade400,
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    "No birthdays this week",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSection({
    required String title,
    required List list,
    required Color color,
    required bool isStaff,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4.w,
              height: 24.h,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(width: 12.w),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 4.h,
              ),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: color.withOpacity(0.2),
                ),
              ),
              child: Text(
                "${list.length} ${isStaff ? 'staff' : 'students'}",
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // List items
        ...list.map((item) {
          return Container(
            margin: EdgeInsets.only(bottom: 12.h),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              elevation: 1,
              child: InkWell(
                borderRadius: BorderRadius.circular(12.r),
                onTap: () {
                  // Handle item tap
                },
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Row(
                    children: [
                      // Avatar
                      Container(
                        width: 48.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              color,
                              color.withOpacity(0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: color.withOpacity(0.2),
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            isStaff ? (item as BirthdayStaff).initials : (item as BirthdayStudent).initials,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),

                      // Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isStaff ? (item as BirthdayStaff).name : (item as BirthdayStudent).fullName,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            if (isStaff)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (item as BirthdayStaff).designation,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    "Birthday: ${_formatDate((item as BirthdayStaff).birthday)}",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: color,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )
                            else
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Class ${(item as BirthdayStudent).className} - ${(item as BirthdayStudent).sectionName}",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    "Birthday: ${_formatDate((item as BirthdayStudent).dob)}",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: color,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),

                      // Action Button
                      IconButton(
                        onPressed: () {
                          // Send wish
                        },
                        icon: Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.celebration_outlined,
                            size: 18.w,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildStatsRow(WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final birthdayAsync = ref.watch(birthdayProvider);

        return birthdayAsync.when(
          loading: () => Container(
            height: 40.h,
            child: Center(
              child: SizedBox(
                width: 20.w,
                height: 20.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ),
          error: (_, __) => SizedBox.shrink(),
          data: (data) {
            final students = data["students"];
            final staff = data["staff"];

            final todayStudents = students["today"] as List? ?? [];
            final tomorrowStudents = students["tomorrow"] as List? ?? [];
            final yesterdayStudents = students["yesterday"] as List? ?? [];

            final todayStaff = staff["today"] as List? ?? [];
            final tomorrowStaff = staff["tomorrow"] as List? ?? [];
            final yesterdayStaff = staff["yesterday"] as List? ?? [];

            final todayCount = todayStudents.length + todayStaff.length;
            final tomorrowCount = tomorrowStudents.length + tomorrowStaff.length;
            final yesterdayCount = yesterdayStudents.length + yesterdayStaff.length;
            final total = todayCount + tomorrowCount + yesterdayCount;

            return Padding(
              padding: EdgeInsets.only(right: 40, bottom: 0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(todayCount.toString(), "Today", Colors.white),
                  _buildStatItem(tomorrowCount.toString(), "Tomorrow", Colors.white),
                  _buildStatItem(yesterdayCount.toString(), "Yesterday", Colors.white),
                  _buildStatItem(total.toString(), "Total", Colors.white),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: color,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: color.withOpacity(0.9),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          SizedBox(height: 100.h),
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: Color(0xFFFCE4EC),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFE91E63).withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.cake_outlined,
                size: 60.w,
                color: Color(0xFFE91E63).withOpacity(0.6),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            "No Birthdays This Week",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Check back later to celebrate student birthdays!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    // Add null/empty check
    if (dateString.isEmpty || dateString == "null" || dateString == "NULL") {
      return "Date not available";
    }

    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(Duration(days: 1));
      final tomorrow = today.add(Duration(days: 1));
      final dateDay = DateTime(date.year, date.month, date.day);

      const monthNames = [
        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
      ];

      if (dateDay == today) {
        return "Today";
      } else if (dateDay == yesterday) {
        return "Yesterday";
      } else if (dateDay == tomorrow) {
        return "Tomorrow";
      } else {
        String month = monthNames[date.month - 1]; // Fix: subtract 1 for correct month index
        return "${date.day} $month";
      }
    } catch (e) {
      print("Error parsing date: $dateString, error: $e");
      return dateString.isNotEmpty ? dateString : "Date not available";
    }
  }

}