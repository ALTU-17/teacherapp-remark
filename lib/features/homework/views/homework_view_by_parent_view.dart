import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teacherapp/features/homework/models/models.dart';
import 'package:teacherapp/features/homework/providers/homework_view_provider.dart';

class HomeworkViewByParentView extends HookConsumerWidget {
  final Homework? homework;
  const HomeworkViewByParentView(this.homework, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch homeworkViewProvider for loading/error states
    final homeview = ref.watch(homeworkViewProvider(homework));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40.h,
        title: Text(
          "HomeWork Viewed By",
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 170.h),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: RichText(
                text: TextSpan(
                  text: "Description: ",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: homework?.description ?? 'No Description',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: homeview.when(
                data: (data) => data.isEmpty
                    ? Center(
                        child: Text(
                          "No students found",
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp),
                        ),
                      )
                    : Column(
                        children: [
                          // Header Row
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 8.h),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.h, horizontal: 12.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 60.w,
                                    child: Text(
                                      "Roll No",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Student Name",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 60.w,
                                    child: Text(
                                      "Viewed",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // List of students
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final student = data[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4.h), // reduced outer space
                                  child: Container(
                                    constraints: BoxConstraints(
                                        minHeight: 10.h), // set minimum height
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.h,
                                          horizontal:
                                              18.w), // increased inner padding
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 60.w,
                                            child: Text(
                                              student.rollNo ?? "",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              ('${student.firstName ?? ''} ${student.lastName ?? ''}')
                                                  .trim(),
                                              style: TextStyle(fontSize: 14.sp),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 60.w,
                                            //

                                            child: Image.asset(
                                              student.readStatus == '1'
                                                  ? 'assets/user_check.jpeg'
                                                  : 'assets/person_off.webp',
                                              width: 24, // size similar to Icon
                                              height: 24,
                                            ),
                                            //

                                            // child: Icon(
                                            //   student.readStatus == '1'
                                            //       ? Icons.verified_user
                                            //       : Icons.person_off,
                                            //   color: student.readStatus == '1'
                                            //       ? Colors.blue
                                            //       : Colors.red,
                                            // ),
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
                      ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(
                  child: Text(
                    "Error loading students: $error",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
