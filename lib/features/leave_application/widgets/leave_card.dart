import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';
import '../views/leave_application_view.dart';

class LeaveCard extends StatelessWidget {
  final Function(Leave val) onDelete; // Add this callback
  final Leave leave;
  const LeaveCard({
    super.key,
    required this.onDelete,
    required this.leave, // Add this parameter
  });

  @override
  Widget build(BuildContext context) {
    // Get status from data (assuming it comes as "A", "P", "H", or "R")
    final status = leave.status ?? 'A';

    // Convert status code to full name and color
    final statusInfo = _getStatusInfo(status);
    final isApproved = status == 'P';
    final isRejected = status == 'R';
    final isHold = status == 'H';
    final isApplied = status == 'A';
    final DateFormat formatter = DateFormat('dd-MM-yyyy');

    // Determine if edit/delete buttons should be visible
    final showEditDeleteButtons = isApplied || isHold;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      elevation: 3,
      color: isApproved
          ? const Color.fromARGB(255, 231, 204, 236)
          : isRejected
              ? const Color.fromARGB(255, 236, 204, 204)
              : Colors.white,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Leave Days: ",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      leave.noOfDays?.toString() ?? '0',
                      style: TextStyle(fontSize: 14.sp, color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Status: ",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      statusInfo['name'],
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: statusInfo['color'],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 6.h),

            /// **Leave Type**
            Row(
              children: [
                Text(
                  "Leave Type: ",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  leave.name?.toString() ?? '',
                  style: TextStyle(fontSize: 14.sp, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 6.h),

            /// **Start Date & End Date**
            Row(
              children: [
                Text(
                  "Start Date: ",
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  leave.leaveStartDate != null
                      ? formatter.format(
                          DateTime.parse(leave.leaveStartDate.toString()))
                      : '',
                  style: TextStyle(fontSize: 12.sp, color: Colors.black),
                ),
                SizedBox(width: 15.w),
                Text(
                  "End Date: ",
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  leave.leaveEndDate != null
                      ? formatter
                          .format(DateTime.parse(leave.leaveEndDate.toString()))
                      : '',
                  style: TextStyle(fontSize: 12.sp, color: Colors.black),
                ),
              ],
            ),
            if (isRejected &&
                leave.reasonForRejection != null &&
                leave.reasonForRejection.toString().isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 6.h),
                  Text(
                    "Rejection Reason: ",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                  Text(
                    leave.reasonForRejection.toString(),
                    style: TextStyle(fontSize: 12.sp, color: Colors.red),
                  ),
                ],
              ),

            /// **Edit/Delete Buttons - Only show for Applied (A) or Hold (H) status**
            if (showEditDeleteButtons)
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => EditLeaveApplicationView(
                      //       leaveApplication: {
                      //         'leave_app_id': leaveData['leaveAppId'],
                      //         'leave_start_date': leaveData['startDate'],
                      //         'leave_end_date': leaveData['endDate'],
                      //         'no_of_days': leaveData['leaveDays'],
                      //         'reason': leaveData['reason'],
                      //         'status': leaveData['status'],
                      //         'name': leaveData['leaveType'],
                      //         'leave_type_id': leaveData['leaveTypeId'],
                      //         'reason_for_rejection':
                      //             leaveData['reasonForRejection'],
                      //       },
                      //     ),
                      //   ),
                      // );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LeaveApplicationView(leave: leave),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _showDeleteConfirmationDialog(context);
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getStatusInfo(String status) {
    switch (status) {
      case "A":
        return {'name': 'Applied', 'color': Colors.blue};
      case "P":
        return {'name': 'Approved', 'color': Colors.green};
      case "H":
        return {'name': 'Hold', 'color': Colors.orange};
      case "R":
        return {'name': 'Rejected', 'color': Colors.red};
      default:
        return {'name': 'Unknown', 'color': Colors.grey};
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context) async {
    final x = await showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text(
              "Are you sure you want to delete this leave application?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
    if (x ?? false) {
      await onDelete(leave);
    }
  }
}
