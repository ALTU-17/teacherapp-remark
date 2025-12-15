import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teacherapp/features/home/providers/academic_year_provider.dart';
import 'package:teacherapp/features/teacher_note/providers/providers.dart';
import 'package:teacherapp/router/routers.dart';
import '../widgets/widgets.dart';

class TeacherNoteDashBoardView extends HookConsumerWidget {
  const TeacherNoteDashBoardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(teacherNoteProvider);
    final acdYear = ref.watch(academicYearProvider).requireValue;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 50.h,
        title: Text(
          "Teacher Note ",
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: notes.when(
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
                  child: notes.when(
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (err, _) => Center(child: Text('Error: $err')),
                    data: (notes) => notes.isNotEmpty
                        ? ListView.builder(
                    padding:
                    EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final note = data[index];
                      return NoteCard(note: note);
                    },
                  ): Center(
                        child: Text('Teacher Notes not found',
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
          EditAddTeacherNoteRoute().location,
          extra: null,
        ),
        backgroundColor: const Color.fromARGB(221, 168, 160, 160),
        child: const Icon(Icons.add, size: 30, color: Colors.black),
      ),
    );
  }
}