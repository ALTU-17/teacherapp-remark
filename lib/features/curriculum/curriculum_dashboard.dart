import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


import 'Chapters/ChaptersPage.dart';
import 'LessonPlanHeading/LessonPlanHeadingPage.dart';
import 'Providers/curriculum_role_provider.dart';
import 'WebViewCurriculum/LessonPlanPage.dart';
import 'WebViewCurriculum/LessonPlanTemplatePage.dart';

class CurriculumPage extends HookConsumerWidget {
  const CurriculumPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleInfoAsync = ref.watch(curriculumRolePProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40.h,
        title: const Text(
          "Curriculum",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 208, 28, 127),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: roleInfoAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
              child: Text('Error: $e', style: const TextStyle(color: Colors.white))),
          data: (roleInfo) {
            // Basic curriculum items
            final curriculumItems = <CurriculumItem>[
              CurriculumItem(title: "Chapters", icon: Icons.menu_book),
              CurriculumItem(title: "Lesson Plan Template", icon: Icons.description),
              CurriculumItem(title: "Lesson Plan", icon: Icons.assignment),
            ];

            // Add Lesson Plan Heading only for curri coordinator
            if (roleInfo != null && roleInfo.role == "curri coordinator") {
              curriculumItems.insert(
                1,
                CurriculumItem(
                  title: "Lesson Plan Heading",
                  icon: Icons.format_list_numbered,
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 140.h),
              itemCount: curriculumItems.length,
              itemBuilder: (context, index) {
                final item = curriculumItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 3,
                  child: ListTile(
                    leading:
                    Icon(item.icon, size: 28.sp, color: Colors.blueAccent),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      switch (item.title) {
                        case "Chapters":
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => ChaptersPage()));
                          break;
                        case "Lesson Plan Heading":
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => LessonPlanHeadingPage()));
                          break;
                        case "Lesson Plan Template":
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LessonPlanTemplatePage()));
                          break;
                        case "Lesson Plan":
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LessonPlanPage()));
                          break;
                      }
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class CurriculumItem {
  final String title;
  final IconData icon;
  CurriculumItem({required this.title, required this.icon});
}
