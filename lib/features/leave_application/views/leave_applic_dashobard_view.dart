// Make sure to create this screen

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:teacherapp/features/home/providers/academic_year_provider.dart';
import 'package:teacherapp/features/leave_application/providers/leave_provider.dart';
import 'package:teacherapp/router/routers.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class LeaveApplicationDashBoardView extends ConsumerWidget {
  const LeaveApplicationDashBoardView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final leave = ref.watch(leavePProvider);
    final leaveP = ref.watch(leavePProvider.notifier);
    // final academicYr = ref.read(authProvider).requireValue.academicYr;
    final acdYear = ref.watch(academicYearProvider).requireValue;
    onDelete(Leave leave) {
      leaveP.deleteLeaveApplication(leave);
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          "Leave Application ",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 226, 25, 99),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
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
            Expanded(
              child: leave.when(
                data: (state) {
                  if (state.leaves.isEmpty) {
                    return Center(
                      child: Text(
                        'Leave applications not found',
                        style: TextStyle(color: Colors.black, fontSize: 16.sp),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                    itemCount: state.leaves.length,
                    itemBuilder: (context, index) {
                      final leaveData = state.leaves[index];
                      return LeaveCard(leave: leaveData, onDelete: onDelete);
                    },
                  );
                },
                error: (error, stackTrace) =>
                    Center(child: Text(error.toString())),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          context.push(LeaveApplicationRoute().location);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (_) => const LeaveApplicationView()),
          // );
        },
        child: const Icon(Icons.add, color: Colors.black, size: 30),
      ),
    );
  }
}
