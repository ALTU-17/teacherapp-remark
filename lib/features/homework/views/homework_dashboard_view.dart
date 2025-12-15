import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:teacherapp/features/homework/providers/providers.dart';
import 'package:teacherapp/router/routers.dart';

import '../../home/providers/academic_year_provider.dart';
import '../widgets/widgets.dart';

class HomeworkDashboardView extends HookConsumerWidget {
  const HomeworkDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homework = ref.watch(homeWorkPProvider);
    final acdYear = ref.watch(academicYearProvider).requireValue;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 50.h,
        title: Text(
          "Homework",
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: homework.when(
        data: (data) {
          return Container(
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
                SizedBox(height: 160.h),
                Expanded(
                  child:homework.when(
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (err, _) => Center(child: Text('Error: $err')),
                    data: (homework) => homework.isNotEmpty
                        ? ListView.builder(
                    padding:
                    EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final homework = data[index];
                      return HomeworkNoteCard(homework: homework);
                    },
                  ): Center(
                      child: Text('Homework not found',
                      style: TextStyle(fontSize: 16.sp))),
                ),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => SizedBox.shrink(),
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(
          EditAddHomeWorkRoute().location,
          extra: null,
        ),
        backgroundColor: const Color.fromARGB(221, 168, 160, 160),
        child: const Icon(Icons.add, size: 30, color: Colors.black),
      ),
    );
  }
}