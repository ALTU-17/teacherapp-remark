import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teacherapp/features/curriculum/LessonPlanHeading/providers/lesson_plan_heading_provider.dart';
import 'package:teacherapp/features/curriculum/LessonPlanHeading/services/lesson_plan_heading_service.dart';


import '../../../providers/api_client_provider.dart';
import '../../auth/providers/auth_provider.dart';
import 'CreateLessonPlanHeadingPage.dart';
import 'EditLessonPlanHeadingPage.dart';

class LessonPlanHeadingPage extends HookConsumerWidget {
  const LessonPlanHeadingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final headingsAsync = ref.watch(lessonPlanHeadingProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 50.h,
        title: const Text(
          "Lesson Plan Headings",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: const Color.fromARGB(255, 208, 28, 127),
        centerTitle: true,
        elevation: 5,
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: headingsAsync.when(
            data: (headings) {
              if (headings.isEmpty) {
                return const Center(child: Text("No Headings found"));
              }
              return Column(
                children: [
                  SizedBox(height: 10.h), // For AppBar

                  Expanded(
                    child: ListView.builder(
                      itemCount: headings.length,
                      itemBuilder: (context, index) {
                        final heading = headings[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 20.r,
                                    backgroundColor: Colors.blueAccent,
                                    child: Text(
                                      heading.sequence,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Text(
                                      heading.title,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if(heading.isUsed != 'Y')
                                      IconButton(
                                        icon: const Icon(Icons.edit, color: Colors.blue),
                                        tooltip: "Edit Heading",
                                        onPressed: () async {
                                          final changed = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => EditLessonPlanHeadingPage(
                                                id: heading.id,
                                                heading: heading.title,
                                                sequence: heading.sequence,
                                                changeDaily: heading.changeDaily == "Y",
                                              ),
                                            ),
                                          );
                                          if (changed == true) {
// Either invalidate to refresh next read, or refresh immediately:
// ref.invalidate(lessonPlanHeadingProvider);
// refresh on next watch
                                            ref.refresh(lessonPlanHeadingProvider); // refresh now and rebuild
                                          }
                                        },
                                      ),

                                      if(heading.isUsed != 'Y')
                                      IconButton(
                                          icon: const Icon(Icons.delete, color: Colors.red),
                                          tooltip: "Delete Heading",
                                          onPressed: () async {
                                            final confirmed = await showDialog<bool>(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: const Text("Confirm Delete"),
                                                content: Text('Delete "${heading.title}"?'),
                                                actions: [
                                                  TextButton(
                                                    child: const Text("Cancel"),
                                                    onPressed: () => Navigator.pop(ctx, false),
                                                  ),
                                                  TextButton(
                                                    child: const Text("Delete"),
                                                    onPressed: () => Navigator.pop(ctx, true),
                                                  ),
                                                ],
                                              ),
                                            );
                                            if (confirmed == true && context.mounted) {

                                              final auth = ref.read(authProvider).requireValue;
                                              final dio = await ref.read(apiClientProvider.future);
                                              final service = LessonPlanHeadingService(
                                                  dio, auth.teacherVerification?.teacherapkUrl ?? '');
                                              final success = await service.deleteHeading(
                                                shortName: auth.teacherVerification?.shortName ?? '',
                                                id: heading.id,
                                              );
                                              if (success) {
                                                ref.invalidate(lessonPlanHeadingProvider);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text("Lesson Plan Heading Deleted!")));
                                              } else {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text("Delete failed!")));
                                              }
                                            }
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
            error: (e, __) => Center(child: Text('Error: $e')),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 208, 28, 127),
        tooltip: "Add Lesson Plan Heading",
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CreateLessonPlanHeadingPage()),
        ).then((_) => ref.invalidate(lessonPlanHeadingProvider)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
