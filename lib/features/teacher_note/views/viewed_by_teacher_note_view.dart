// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../models/note.dart';
// import '../providers/providers.dart';

// class ViewedByTeacherNoteView extends StatefulHookConsumerWidget {
//   final Note note;

//   const ViewedByTeacherNoteView({super.key, required this.note});

//   @override
//   ConsumerState<ViewedByTeacherNoteView> createState() =>
//       _ViewedByTeacherNoteView();
// }

// class _ViewedByTeacherNoteView extends ConsumerState<ViewedByTeacherNoteView> {
//   final TextEditingController _searchController = TextEditingController();
//   List<dynamic> filteredData = [];

//   @override
//   void initState() {
//     super.initState();
//   }

//   /// **Search Function**
//   void _filterData(String query, List<dynamic> data) {
//     setState(() {
//       if (query.isEmpty) {
//         filteredData = List.from(data);
//       } else {
//         // Try to filter based on common fields that might exist
//         filteredData = data.where((item) {
//           if (item is Map<String, dynamic>) {
//             // Check for common name fields
//             final name = item['name'] ??
//                 item['student_name'] ??
//                 item['studentName'] ??
//                 '';
//             final id =
//                 item['id']?.toString() ?? item['student_id']?.toString() ?? '';
//             return name
//                     .toString()
//                     .toLowerCase()
//                     .contains(query.toLowerCase()) ||
//                 id.contains(query.toLowerCase());
//           }
//           return false;
//         }).toList();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final noteViewAsync = ref.watch(noteViewPProvider(widget.note));

//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         toolbarHeight: 50.h,
//         title: Text(
//           "Teacher Note Viewed By",
//           style: TextStyle(fontSize: 17.sp, color: Colors.white),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.pink, Colors.blue],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           children: [
//             SizedBox(height: 160.h),

//             /// Description (shown at top if present)
//             if ((widget.note.description ?? '').trim().isNotEmpty)
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.w),
//                 child: Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.all(12.w),
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 230, 204, 204),
//                     borderRadius: BorderRadius.circular(10.r),
//                   ),
//                   child: Text(
//                     widget.note.description ?? '',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: Colors.black87,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),

//             SizedBox(height: 10.h),

//             /// **Data Display based on noteView**
//             Expanded(
//               child: noteViewAsync.when(
//                 loading: () => const Center(
//                   child: CircularProgressIndicator(color: Colors.white),
//                 ),
//                 error: (error, stackTrace) => Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.error_outline,
//                         color: Colors.white,
//                         size: 48.sp,
//                       ),
//                       SizedBox(height: 16.h),
//                       Text(
//                         "Error loading data",
//                         style: TextStyle(color: Colors.white, fontSize: 16.sp),
//                       ),
//                       SizedBox(height: 8.h),
//                       Text(
//                         error.toString(),
//                         style:
//                             TextStyle(color: Colors.white70, fontSize: 12.sp),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//                 data: (noteViewData) {
//                   if (noteViewData.isEmpty) {
//                     return Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.info_outline,
//                             color: Colors.white,
//                             size: 48.sp,
//                           ),
//                           SizedBox(height: 16.h),
//                           Text(
//                             "No data available",
//                             style:
//                                 TextStyle(color: Colors.white, fontSize: 16.sp),
//                           ),
//                           SizedBox(height: 8.h),
//                           Text(
//                             "This note has no view data yet",
//                             style: TextStyle(
//                                 color: Colors.white70, fontSize: 12.sp),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     );
//                   }

//                   // Initialize filtered data
//                   filteredData = List.from(noteViewData);

//                   return Column(
//                     children: [
//                       /// Search Box
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 20.w),
//                         child: TextField(
//                           controller: _searchController,
//                           onChanged: (query) =>
//                               _filterData(query, noteViewData),
//                           decoration: InputDecoration(
//                             hintText: "Search...",
//                             hintStyle:
//                                 TextStyle(color: Colors.grey, fontSize: 14.sp),
//                             prefixIcon:
//                                 const Icon(Icons.search, color: Colors.grey),
//                             filled: true,
//                             fillColor: const Color.fromARGB(255, 232, 219, 219),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.r),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 20.h),

//                       /// Data List
//                       Expanded(
//                         child: filteredData.isEmpty
//                             ? Center(
//                                 child: Text(
//                                   "No results found",
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 16.sp),
//                                 ),
//                               )
//                             : ListView.builder(
//                                 padding: EdgeInsets.symmetric(horizontal: 20.w),
//                                 itemCount: filteredData.length,
//                                 itemBuilder: (context, index) {
//                                   final item = filteredData[index];
//                                   return _dataTile(item, index);
//                                 },
//                               ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// **Data Tile - Generic display for any data structure**
//   Widget _dataTile(dynamic item, int index) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 5.h),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8.r),
//         ),
//         child: ListTile(
//           leading: CircleAvatar(
//             backgroundColor: Colors.blue.shade100,
//             child: Text(
//               (index + 1).toString(),
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue.shade800,
//               ),
//             ),
//           ),
//           title: Text(
//             _extractTitle(item),
//             style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
//           ),
//           subtitle: _extractSubtitle(item) != null
//               ? Text(
//                   _extractSubtitle(item)!,
//                   style:
//                       TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
//                 )
//               : null,
//           trailing: _extractTrailingIcon(item),
//         ),
//       ),
//     );
//   }

//   /// Extract title from various data structures
//   String _extractTitle(dynamic item) {
//     if (item is Map<String, dynamic>) {
//       return item['name']?.toString() ??
//           item['student_name']?.toString() ??
//           item['studentName']?.toString() ??
//           item['title']?.toString() ??
//           item['description']?.toString() ??
//           'Item ${item['id'] ?? 'Unknown'}';
//     }
//     return item.toString();
//   }

//   /// Extract subtitle from various data structures
//   String? _extractSubtitle(dynamic item) {
//     if (item is Map<String, dynamic>) {
//       return item['date']?.toString() ??
//           item['publish_date']?.toString() ??
//           item['classname']?.toString() ??
//           item['subjectname']?.toString();
//     }
//     return null;
//   }

//   /// Extract trailing icon based on data
//   Widget _extractTrailingIcon(dynamic item) {
//     if (item is Map<String, dynamic>) {
//       // Check for viewed status or other relevant fields
//       final viewed = item['viewed'] ?? item['is_viewed'] ?? false;
//       final status = item['status']?.toString().toLowerCase();

//       if (viewed == true || status == 'viewed' || status == 'read') {
//         return Icon(Icons.visibility, color: Colors.green);
//       } else if (viewed == false ||
//           status == 'not_viewed' ||
//           status == 'unread') {
//         return Icon(Icons.visibility_off, color: Colors.grey);
//       }
//     }

//     // Default icon
//     return Icon(Icons.info_outline, color: Colors.blue);
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/note.dart';
import '../providers/note_view_provider.dart';

class ViewedByTeacherNoteView extends HookConsumerWidget {
  final Note? note;
  const ViewedByTeacherNoteView(this.note, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch homeworkViewProvider for loading/error states
    final noteview = ref.watch(noteViewPProvider(note));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40.h,
        title: Text(
          "Teacher Note Viewed By",
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
                      text: note?.description ?? 'No Description',
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
              child: noteview.when(
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
