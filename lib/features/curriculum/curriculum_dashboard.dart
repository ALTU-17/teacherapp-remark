import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/services.dart';

import 'Chapters/ChaptersPage.dart';
import 'LessonPlanHeading/LessonPlanHeadingPage.dart';
import 'Providers/curriculum_role_provider.dart';
import 'LessonPlan/view/LessonPlanPage.dart';
import 'WebViewCurriculum/LessonPlanTemplatePage.dart';

class CurriculumPage extends HookConsumerWidget {
  const CurriculumPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleInfoAsync = ref.watch(curriculumRolePProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        toolbarHeight: 80.h,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Curriculum",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              "Manage your curriculum resources",
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFE91E63),
                const Color(0xFF3F51B5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 160.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFE91E63).withOpacity(0.05),
                const Color(0xFF3F51B5).withOpacity(0.05),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: roleInfoAsync.when(
            loading: () => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40.w,
                    height: 40.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        const Color(0xFFE91E63),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Loading Curriculum...",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            error: (e, _) => Center(
              child: Container(
                margin: EdgeInsets.all(24.w),
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 48.w,
                      color: Colors.red.shade400,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Failed to load data',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Error: $e',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton.icon(
                      onPressed: () => ref.refresh(curriculumRolePProvider),
                      icon: Icon(Icons.refresh, size: 18.w),
                      label: Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE91E63),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 10.h,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            data: (roleInfo) {
              // Basic curriculum items with colors
              final curriculumItems = <CurriculumItem>[
                CurriculumItem(
                  title: "Chapters",
                  icon: Icons.menu_book,
                  color: const Color(0xFF4CAF50),
                  description: "Create and manage chapters",
                ),
                CurriculumItem(
                  title: "Lesson Plan Template",
                  icon: Icons.description,
                  color: const Color(0xFF2196F3),
                  description: "Create and manage templates",
                ),
                CurriculumItem(
                  title: "Lesson Plan",
                  icon: Icons.assignment,
                  color: const Color(0xFFFF9800),
                  description: "Browse, create and manage lesson plans",
                ),
              ];

              // Add Lesson Plan Heading only for curri coordinator
              if (roleInfo != null && roleInfo.role == "curri coordinator") {
                curriculumItems.insert(
                  1,
                  CurriculumItem(
                    title: "Lesson Plan Heading",
                    icon: Icons.format_list_numbered,
                    color: const Color(0xFF9C27B0),
                    description: "Manage lesson plan headings",
                  ),
                );
              }

              return Stack(
                children: [
                  // Decorative circles in background
                  Positioned(
                    top: -50.h,
                    right: -50.w,
                    child: Container(
                      width: 150.w,
                      height: 150.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFE91E63).withOpacity(0.05),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -30.h,
                    left: -30.w,
                    child: Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF3F51B5).withOpacity(0.05),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Role Badge
                        if (roleInfo != null) ...[
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 18.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.badge_outlined,
                                  size: 16.w,
                                  color: const Color(0xFFE91E63),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Role: ${roleInfo.role}',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                        ],


                        SizedBox(height: 20.h),

                        // Grid/List View
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: curriculumItems.length,
                            itemBuilder: (context, index) {
                              final item = curriculumItems[index];
                              return _buildCurriculumCard(item, context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCurriculumCard(CurriculumItem item, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        elevation: 2,
        shadowColor: item.color.withOpacity(0.2),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            switch (item.title) {
              case "Chapters":
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChaptersPage()),
                );
                break;
              case "Lesson Plan Heading":
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LessonPlanHeadingPage()),
                );
                break;
              case "Lesson Plan Template":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LessonPlanTemplatePage(),
                  ),
                );
                break;
              case "Lesson Plan":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LessonPlanPage(),
                  ),
                );
                break;
            }
          },
          child: Container(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Icon Container with gradient
                Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        item.color,
                        item.color.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                    boxShadow: [
                      BoxShadow(
                        color: item.color.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    item.icon,
                    color: Colors.white,
                    size: 28.w,
                  ),
                ),
                SizedBox(width: 16.w),

                // Title and Description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        item.description,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Arrow Icon with animation
                Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: item.color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16.w,
                    color: item.color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CurriculumItem {
  final String title;
  final IconData icon;
  final Color color;
  final String description;

  CurriculumItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.description,
  });
}