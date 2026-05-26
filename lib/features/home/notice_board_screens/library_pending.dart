import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import '../views/teacher_id.dart';

class PendingLibraryBook {
  final int memberId;
  final String memberType;
  final int bookId;
  final String copyId;
  final String issueDate;
  final String dueDate;
  final String returnDate;
  final String bookTitle;
  final int categoryId;
  final String author;
  final String publisher;
  final int daysBorrow;
  final String location;
  final String issueType;

  PendingLibraryBook({
    required this.memberId,
    required this.memberType,
    required this.bookId,
    required this.copyId,
    required this.issueDate,
    required this.dueDate,
    required this.returnDate,
    required this.bookTitle,
    required this.categoryId,
    required this.author,
    required this.publisher,
    required this.daysBorrow,
    required this.location,
    required this.issueType,
  });

  factory PendingLibraryBook.fromJson(Map<String, dynamic> json) {
    return PendingLibraryBook(
      memberId: json["member_id"],
      memberType: json["member_type"],
      bookId: json["book_id"],
      copyId: json["copy_id"],
      issueDate: json["issue_date"],
      dueDate: json["due_date"],
      returnDate: json["return_date"],
      bookTitle: json["book_title"],
      categoryId: json["category_id"],
      author: json["author"],
      publisher: json["publisher"],
      daysBorrow: json["days_borrow"],
      location: json["location_of_book"],
      issueType: json["issue_type"],
    );
  }

  /// Helper: How many days overdue?
  int get overdueDays {
    final due = DateTime.tryParse(dueDate);
    if (due == null) return 0;

    final today = DateTime.now();
    final difference = today.difference(due).inDays;
    return difference > 0 ? difference : 0;
  }

Future<void> feychData() async {
    final response = await http.get(Uri.parse("http://dummy/api/for/interview"));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      print("interview => $data");
    } else {
      throw Exception("Failed to load data");
    }
}

  bool get isOverdue => overdueDays > 0;

  Color get statusColor {
    if (isOverdue) {
      if (overdueDays > 7) return Color(0xFFD32F2F); // Dark red for very late
      return Color(0xFFF44336); // Red for overdue
    }
    final due = DateTime.tryParse(dueDate);
    if (due != null) {
      final daysUntilDue = due.difference(DateTime.now()).inDays;
      if (daysUntilDue <= 2) return Color(0xFFFF9800); // Orange for due soon
    }
    return Color(0xFF4CAF50); // Green for OK
  }

  String get statusText {
    if (isOverdue) {
      if (overdueDays > 7) return "VERY LATE";
      return "OVERDUE";
    }
    final due = DateTime.tryParse(dueDate);
    if (due != null) {
      final daysUntilDue = due.difference(DateTime.now()).inDays;
      if (daysUntilDue <= 2) return "DUE SOON";
    }
    return "PENDING";
  }

  IconData get statusIcon {
    if (isOverdue) return Icons.warning_rounded;
    return Icons.timer_outlined;
  }

  String get initials {
    final words = bookTitle.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return bookTitle.length >= 2
        ? bookTitle.substring(0, 2).toUpperCase()
        : bookTitle.toUpperCase();
  }
}

final pendingLibraryProvider =
FutureProvider<List<PendingLibraryBook>>((ref) async {
  final api = ref.watch(staffApiProvider);
  return api.getPendingBooksForReturn();
});

class LibraryPendingScreen extends ConsumerWidget {
  const LibraryPendingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(pendingLibraryProvider);

    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
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
                      Color(0xFFEF2C42),
                      Color(0xFF764BA2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(left:50,bottom: 40.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 45.w,
                              height: 45.h,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ),
                              child: Icon(
                                Icons.library_books_outlined,
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
                                    "Pending Returns",
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
                                  SizedBox(height: 2.h),
                                  Text(
                                    "Books awaiting return to library",
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
                        SizedBox(height: 5.h),
                        _buildStatsRow(async),

                      ],

                    ),

                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30.h),
              child: Container(
                height: 25.h,
                decoration: BoxDecoration(
                  color: Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
              ),
            ),
          ),

          // Content Section
          SliverToBoxAdapter(
            child: async.when(
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
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEF2C42)),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Loading Library Records...",
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
              error: (err, _) => Container(
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
                        "Failed to load library data",
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
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24.h),
                      ElevatedButton(
                        onPressed: () => ref.refresh(pendingLibraryProvider),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF6A11CB),
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
              data: (books) {
                if (books.isEmpty) {
                  return _buildEmptyState();
                }

                // Sort books: overdue first, then due soon, then others
                final sortedBooks = List<PendingLibraryBook>.from(books)
                  ..sort((a, b) {
                    if (a.isOverdue && !b.isOverdue) return -1;
                    if (!a.isOverdue && b.isOverdue) return 1;
                    if (a.isOverdue && b.isOverdue) {
                      return b.overdueDays.compareTo(a.overdueDays);
                    }
                    return a.dueDate.compareTo(b.dueDate);
                  });
                return Padding(
                  padding: EdgeInsets.only(left: 16.w,right: 16.w,bottom: 16.w),
                  child: Column(
                    children: sortedBooks.map((book) => _buildBookCard(book)).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(AsyncValue<List<PendingLibraryBook>> async) {
    return async.when(
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
      data: (books) {
        final totalBooks = books.length;
        final overdueBooks = books.where((b) => b.isOverdue).length;
        final dueSoonBooks = books.where((b) {
          if (b.isOverdue) return false;
          final due = DateTime.tryParse(b.dueDate);
          if (due != null) {
            final daysUntilDue = due.difference(DateTime.now()).inDays;
            return daysUntilDue <= 2;
          }
          return false;
        }).length;

        return Padding(
          padding: EdgeInsets.only(right:40,bottom: 0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                totalBooks.toString(),
                "Total",
                Colors.white,
                Icons.book_outlined,
              ),
              _buildStatItem(
                overdueBooks.toString(),
                "Overdue",
                Colors.white,
                Icons.warning_outlined,
              ),
              _buildStatItem(
                dueSoonBooks.toString(),
                "Due Soon",
                Colors.white,
                Icons.timer_outlined,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatItem(String value, String label, Color color, IconData icon) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18.w,
              color: color,
            ),
            SizedBox(width: 6.w),
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
          ],
        ),
        // SizedBox(height: 2.h),
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

  Widget _buildBookCard(PendingLibraryBook book) {
    final daysText = book.isOverdue
        ? "${book.overdueDays} days overdue"
        : "Due in ${_daysUntil(book.dueDate)} days";

    return Container(
      margin: EdgeInsets.only(bottom: 10.h,top: 10),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            // Handle book tap
            // _showBookDetails(context, book);
          },
          child: Stack(
            children: [
              // Status Indicator Ribbon
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: book.statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.r),
                      bottomLeft: Radius.circular(12.r),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        book.statusIcon,
                        size: 14.w,
                        color: book.statusColor,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        book.statusText,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: book.statusColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Book Cover/Initials
                        // Container(
                        //   width: 60.w,
                        //   height: 80.h,
                        //   decoration: BoxDecoration(
                        //     gradient: LinearGradient(
                        //       colors: [
                        //         Color(0xFFEF2C42),
                        //         Color(0xFF2575FC),
                        //       ],
                        //       begin: Alignment.topLeft,
                        //       end: Alignment.bottomRight,
                        //     ),
                        //     borderRadius: BorderRadius.circular(8.r),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.blue.shade200,
                        //         blurRadius: 6,
                        //         offset: Offset(0, 3),
                        //       ),
                        //     ],
                        //   ),
                        //   child: Center(
                        //     child: Text(
                        //       book.initials,
                        //       style: TextStyle(
                        //         fontSize: 20.sp,
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(width: 16.w),

                        // Book Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.bookTitle,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 6.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.person_outline,
                                    size: 14.w,
                                    color: Colors.grey.shade500,
                                  ),
                                  SizedBox(width: 6.w),
                                  Expanded(
                                    child: Text(
                                      "by ${book.author}",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.grey.shade600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                  SizedBox(width: 20.w),

                                  Icon(
                                    Icons.business_outlined,
                                    size: 14.w,
                                    color: Colors.grey.shade500,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    book.publisher,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(height: 4.h),
                              // Row(
                              //   children: [
                              //
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    // Additional Info Grid
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              _buildInfoItem(
                                "Accession no",
                                book.copyId,
                                Icons.confirmation_number_outlined,
                              ),
                              SizedBox(width: 16.w),
                              _buildInfoItem(
                                "Location",
                                book.location,
                                Icons.location_on_outlined,
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              _buildInfoItem(
                                "Issue Date",
                                _formatDate(book.issueDate),
                                Icons.date_range_outlined,
                              ),
                              SizedBox(width: 16.w),
                              _buildInfoItem(
                                "Due Date",
                                _formatDate(book.dueDate),
                                Icons.calendar_today_outlined,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10.h),

                    // Status & Actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: book.statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: book.statusColor.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                book.isOverdue
                                    ? Icons.warning_amber_outlined
                                    : Icons.timer_outlined,
                                size: 14.w,
                                color: book.statusColor,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                daysText,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: book.statusColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                // Send reminder
                              },
                              icon: Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.notifications_outlined,
                                  size: 18.w,
                                  color: Colors.blue.shade600,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     // Mark as returned
                            //   },
                            //   style: ElevatedButton.styleFrom(
                            //     backgroundColor: Color(0xFF4CAF50),
                            //     foregroundColor: Colors.white,
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(10.r),
                            //     ),
                            //     padding: EdgeInsets.symmetric(
                            //       horizontal: 20.w,
                            //       vertical: 10.h,
                            //     ),
                            //   ),
                            //   child: Row(
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: [
                            //       Icon(Icons.check, size: 16.w),
                            //       SizedBox(width: 6.w),
                            //       Text("Mark Returned"),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 14.w,
                color: Colors.grey.shade500,
              ),
              SizedBox(width: 6.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          SizedBox(height: 40.h),
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: Color(0xFFE8F5E9),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF4CAF50).withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.auto_stories_outlined,
                size: 60.w,
                color: Color(0xFF4CAF50).withOpacity(0.6),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            "Library is Up to Date!",
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "No pending book returns found.\nAll books have been returned on time.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade500,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: () {
              // Refresh or view all books
            },
            icon: Icon(Icons.refresh_outlined, size: 18.w),
            label: Text("Refresh"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6A11CB),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 12.h,
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _daysUntil(String dateString) {
    final date = DateTime.tryParse(dateString);
    if (date == null) return 0;
    final today = DateTime.now();
    return date.difference(today).inDays;
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return "${date.day}/${date.month}/${date.year}";
    } catch (e) {
      return dateString;
    }
  }

  void _showBookDetails(BuildContext context, PendingLibraryBook book) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: EdgeInsets.symmetric(vertical: 12.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              // Details content would go here
              // (Implementation omitted for brevity)
              Expanded(
                child: Center(
                  child: Text(
                    "Book Details View",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}