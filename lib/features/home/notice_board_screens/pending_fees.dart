import 'dart:io';

import 'package:excel/excel.dart' hide Border;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Border;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../views/teacher_id.dart';

class PendingFeeStudent {
  final int studentId;
  final String firstName;
  final String midName;
  final String lastName;
  final int rollNo;
  final int installment;
  final int pendingFee;

  PendingFeeStudent({
    required this.studentId,
    required this.firstName,
    required this.midName,
    required this.lastName,
    required this.rollNo,
    required this.installment,
    required this.pendingFee,
  });

  String get fullName =>
      [firstName, lastName].where((e) => e.isNotEmpty).join(" ");

  factory PendingFeeStudent.fromJson(Map<String, dynamic> json) {
    int _toInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }
    return PendingFeeStudent(
      studentId: _toInt(json["student_id"]),
      firstName: json["first_name"]?.toString() ?? "",
      midName: json["mid_name"]?.toString() ?? "",
      lastName: json["last_name"]?.toString() ?? "",
      rollNo: _toInt(json["roll_no"]),
      installment: _toInt(json["installment"]),
      pendingFee: _toInt(json["pending_fee"]),
    );
  }
}

class PendingFeeGroup {
  final int studentId;
  final String fullName;
  final int rollNo;
  final List<PendingFeeStudent> installments;

  PendingFeeGroup({
    required this.studentId,
    required this.fullName,
    required this.rollNo,
    required this.installments,
  });
}

final pendingFeesProvider = FutureProvider<List<PendingFeeGroup>>((ref) async {
  final api = ref.watch(staffApiProvider);
  try {
    return await api.getPendingFees();
  } catch (e) {
    print("Error in pendingFeesProvider: $e");
    return []; // Return empty list on error
  }
});

class PendingFeesScreen extends ConsumerStatefulWidget {
  const PendingFeesScreen({super.key});

  @override
  ConsumerState<PendingFeesScreen> createState() => _PendingFeesScreenState();
}

class _PendingFeesScreenState extends ConsumerState<PendingFeesScreen> {
  int? expandedStudentId;

  // Validation function
  String? _validateStudentData(PendingFeeGroup student) {
    if (student.fullName.trim().isEmpty) {
      return "Student name is missing";
    }
    if (student.rollNo <= 0) {
      return "Invalid roll number";
    }
    if (student.installments.isEmpty) {
      return "No installments found";
    }

    // Validate each installment
    for (final installment in student.installments) {
      if (installment.pendingFee < 0) {
        return "Invalid pending fee amount";
      }
      if (installment.installment <= 0) {
        return "Invalid installment number";
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(pendingFeesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE91E63), Color(0xFF2196F3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Header Section (Same as library/birthday screen)
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        // Back Button
                        Container(
                          width: 45.w,
                          height: 48.h,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.white,
                              size: 24.w,
                            ),
                            padding: EdgeInsets.zero,
                            splashRadius: 20.w,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        // Pending Fees Icon
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
                                "Pending Fees",
                                style: TextStyle(
                                  fontSize: 22.sp,
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
                              SizedBox(height: 4.h),
                              Text(
                                "View students with pending fees",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white.withOpacity(0.9),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
            // Stats Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: async.when(
                loading: () => _buildStatsLoading(),
                error: (err, _) => _buildStatsError(err.toString()),
                data: (groups) {
                  // Handle null or empty groups with proper null safety
                  final safeGroups = groups ?? [];

                  if (safeGroups.isEmpty) {
                    return _buildStatsCard(0, 0.0, 0);
                  }

                  final totalStudents = safeGroups.length;

                  final totalAmount = safeGroups.fold<double>(0, (sum, student) {
                    final installments = student.installments;
                    if (installments == null || installments.isEmpty) {
                      return sum;
                    }
                    return sum + installments.fold<double>(
                        0,
                            (studentSum, ins) => studentSum + (ins.pendingFee)
                    );
                  });

                  final totalInstallments = safeGroups.fold<int>(
                      0,
                          (sum, student) => sum + (student.installments?.length ?? 0)
                  );

                  return _buildStatsCard(totalStudents, totalAmount, totalInstallments);
                },
              ),
            ),

            SizedBox(height: 1),

            // Content Section
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: async.when(
                    loading: () => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Color(0xFFD01C7F),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Loading pending fees...",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    error: (err, _) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline_rounded,
                              size: 60,
                              color: Colors.red.shade400,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Failed to load data",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              err.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () {
                                ref.refresh(pendingFeesProvider);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFD01C7F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                              child: Text(
                                "Try Again",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    data: (groups) {
                      // Handle null data
                      final safeGroups = groups ?? [];

                      if (safeGroups.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.credit_score_outlined,
                                size: 80,
                                color: Colors.blue.shade200.withOpacity(0.7),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "No Pending Fees",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "All fees are up to date",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      // Validate all students before displaying
                      final validationErrors = <PendingFeeGroup, String>{};
                      for (final student in safeGroups) {
                        final error = _validateStudentData(student);
                        if (error != null) {
                          validationErrors[student] = error;
                        }
                      }

                      // Show validation errors if any
                      // if (validationErrors.isNotEmpty) {
                      //   return Center(
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(20.0),
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Icon(
                      //             Icons.warning_amber_rounded,
                      //             size: 60,
                      //             color: Colors.orange.shade400,
                      //           ),
                      //           SizedBox(height: 16),
                      //           Text(
                      //             "Data Validation Issues",
                      //             style: TextStyle(
                      //               fontSize: 18,
                      //               fontWeight: FontWeight.w600,
                      //               color: Colors.grey.shade700,
                      //             ),
                      //           ),
                      //           SizedBox(height: 8),
                      //           Text(
                      //             "${validationErrors.length} student(s) have invalid data",
                      //             style: TextStyle(
                      //               fontSize: 14,
                      //               color: Colors.grey.shade500,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   );
                      // }

                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        itemCount: safeGroups.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 4),
                        itemBuilder: (context, i) {
                          final g = safeGroups[i];
                          final pendingInstallments = g.installments.where((e) => e.pendingFee > 0).toList();

                          String pendingInstallmentText(List<PendingFeeStudent> list) {
                            if (list.isEmpty) return "No pending installments";
                            final numbers = list.map((e) => e.installment).toList()..sort();
                            return "Installments: ${numbers.join(', ')}";
                          }

                          final isExpanded = expandedStudentId == g.studentId;
                          final totalPending = g.installments.fold<double>(
                              0, (sum, ins) => sum + (ins.pendingFee));

                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                            child: Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              elevation: 2,
                              shadowColor: Colors.grey.withOpacity(0.2),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  setState(() {
                                    expandedStudentId = isExpanded ? null : g.studentId;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: isExpanded
                                          ? Color(0xFFD01C7F).withOpacity(0.3)
                                          : Colors.grey.shade100,
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      // Header section
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
                                        child: Row(
                                          children: [
                                            // Roll number badge
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xFFEF2C42),
                                                    Color(0xFF764BA2),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                                borderRadius: BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xFFD01C7F).withOpacity(0.2),
                                                    blurRadius: 8,
                                                    offset: Offset(0, 4),
                                                  ),
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  g.rollNo.toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 16),
                                            // Student info
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    g.fullName,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.grey.shade800,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    pendingInstallmentText(pendingInstallments),
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.red.shade600,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Total amount and expand icon
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 6,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.red.shade50,
                                                    borderRadius: BorderRadius.circular(12),
                                                    border: Border.all(
                                                      color: Colors.red.shade100,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "₹${totalPending.toStringAsFixed(2)}",
                                                    style: TextStyle(
                                                      color: Colors.red.shade700,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Icon(
                                                  isExpanded
                                                      ? Icons.keyboard_arrow_up_rounded
                                                      : Icons.keyboard_arrow_down_rounded,
                                                  color: Color(0xFFD01C7F),
                                                  size: 28,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Divider
                                      if (g.installments.isNotEmpty)
                                        Divider(
                                          height: 1,
                                          color: Colors.grey.shade200,
                                          indent: 16,
                                          endIndent: 16,
                                        ),
                                      // Expanded content
                                      if (isExpanded && g.installments.isNotEmpty)
                                        AnimatedContainer(
                                          duration: const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                          child: Column(
                                            children: [
                                              SizedBox(height: 12),
                                              // Installment table header
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 8,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        "Installment Details",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.grey.shade600,
                                                          letterSpacing: 0.5,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "Amount",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.grey.shade600,
                                                          letterSpacing: 0.5,
                                                        ),
                                                        textAlign: TextAlign.right,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Installment list
                                              ...g.installments.asMap().entries.map((entry) {
                                                final index = entry.key;
                                                final ins = entry.value;
                                                return Container(
                                                  margin: const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 4,
                                                  ),
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      borderRadius: BorderRadius.circular(12),
                                                      onTap: () {},
                                                      child: Container(
                                                        padding: const EdgeInsets.all(12),
                                                        decoration: BoxDecoration(
                                                          color: index.isEven
                                                              ? Colors.grey.shade50
                                                              : Colors.white,
                                                          borderRadius: BorderRadius.circular(12),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            // Installment number
                                                            Expanded(
                                                              flex: 2,
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    width: 36,
                                                                    height: 36,
                                                                    decoration: BoxDecoration(
                                                                      color: Color(0xFFD01C7F).withOpacity(0.1),
                                                                      shape: BoxShape.circle,
                                                                    ),
                                                                    child: Center(
                                                                      child: Text(
                                                                        ins.installment.toString(),
                                                                        style: TextStyle(
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.bold,
                                                                          color: Color(0xFFD01C7F),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 12),
                                                                  Expanded(
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                          "Installment ${ins.installment}",
                                                                          style: TextStyle(
                                                                            fontSize: 15,
                                                                            fontWeight: FontWeight.w500,
                                                                            color: Colors.black87,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            // Amount
                                                            Expanded(
                                                              child: Text(
                                                                "₹${(ins.pendingFee).toDouble().toStringAsFixed(2)}",
                                                                style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors.red.shade600,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                                textAlign: TextAlign.right,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                              SizedBox(height: 16),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsLoading() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Loading...",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Fetching fee statistics",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsError(String error) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade300.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: Colors.red.shade300,
            size: 24,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Failed to load stats",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  error.length > 30 ? "${error.substring(0, 30)}..." : error,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(int students, double amount, int installments) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            value: students.toString(),
            label: "Students",
            icon: Icons.people_rounded,
          ),
          Container(
            height: 40,
            width: 1,
            color: Colors.white.withOpacity(0.2),
          ),
          GestureDetector(
            onTap: () async {
              final data = await ref.read(pendingFeesProvider.future);
              if (data != null && data.isNotEmpty) {
                await _downloadExcel(data);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("No data to download"),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            },
            child: _buildStatItem(
              value: "",
              label: "Download list",
              icon: Icons.download_rounded,
            ),
          ),
          Container(
            height: 40,
            width: 1,
            color: Colors.white.withOpacity(0.2),
          ),
          _buildStatItem(
            value: installments.toString(),
            label: "Installments",
            icon: Icons.receipt_long_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String value,
    required String label,
    required IconData icon,
  }) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white.withOpacity(0.9),
              size: 18,
            ),
            SizedBox(width: 2),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Future<void> _downloadExcel(List<PendingFeeGroup> groups) async {
    try {
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Preparing Excel file..."),
          duration: Duration(seconds: 1),
        ),
      );

      final excel = Excel.createExcel();
      final sheet = excel['Sheet1'];

      // Add headers
      sheet.appendRow([
        'Roll No',
        'Student Name',
        'Installment',
        'Pending Amount',
      ]);

      // Add data rows
      for (final g in groups) {
        final pendingInstallments = g.installments.where((e) => e.pendingFee > 0).toList();

        if (pendingInstallments.isEmpty) {
          // Add row with no installments
          sheet.appendRow([
            g.rollNo,
            g.fullName,
            'No pending',
            '0',
          ]);
        } else {
          for (final ins in pendingInstallments) {
            sheet.appendRow([
              g.rollNo,
              g.fullName,
              ins.installment,
              ins.pendingFee,
            ]);
          }
        }
      }

      final fileBytes = excel.save();

      if (fileBytes == null) {
        throw Exception("Failed to generate Excel file");
      }

      if (Platform.isIOS) {
        final directory = await getApplicationDocumentsDirectory();
        final dirPath = '${directory.path}/TeacherApp';
        final dir = Directory(dirPath);
        if (!await dir.exists()) {
          await dir.create(recursive: true);
        }

        final filePath = '$dirPath/pending_fees.xlsx';
        final file = File(filePath);
        await file.writeAsBytes(fileBytes);

        await Share.shareXFiles(
          [XFile(file.path)],
          text: "Pending Fees Report",
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('File saved in Documents/TeacherApp/'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      } else {
        // Android
        final dir = Directory("/storage/emulated/0/Download/TeacherApp/Pending Fee");
        if (!await dir.exists()) {
          await dir.create(recursive: true);
        }

        final filePath = "${dir.path}/pending_fees_${DateTime.now().millisecondsSinceEpoch}.xlsx";
        final file = File(filePath);
        await file.writeAsBytes(fileBytes);

        await Share.shareXFiles(
          [XFile(file.path)],
          text: "Pending Fees Report",
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("File saved: ${dir.path}"),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    } catch (e) {
      print("Error downloading Excel: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to download: ${e.toString()}"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }
}