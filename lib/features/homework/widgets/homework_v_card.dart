import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/models.dart';

class HomeworkStatusMapper {
  static const completed = 'Completed';
  static const assigned = 'Assigned';
  static const partial = 'Partial';

  /// Backend → UI
  static String fromApi(String? value) {
    if (value == null) return assigned;

    final v = value.toLowerCase().trim();

    // numeric
    if (v == '2') return completed;
    if (v == '1') return partial;
    if (v == '0') return assigned;

    // text
    if (v == 'complete') return completed;
    if (v == 'partial') return partial;
    if (v == 'assigned') return assigned;

    return assigned;
  }

  /// UI → API (ALWAYS words)
  static String toApi(String label) {
    switch (label) {
      case completed:
        return 'Complete';
      case partial:
        return 'Partial';
      default:
        return 'Assigned';
    }
  }
}


class HomeworkVCard extends HookConsumerWidget {
  final HomeworkStudentStatus hStatus;
  final void Function(HomeworkStatus status) onChangeStatus;
  final String? selectedStatus;

  const HomeworkVCard(
      this.hStatus,
      this.onChangeStatus, {
        super.key,
        this.selectedStatus,
      });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// UI states
    final isSelected = useState<bool>(false);
    final isCommentVisible = useState<bool>(false);
    final commentController = useTextEditingController(
      text: hStatus.comment ?? '',
    );

    /// Dropdown values
    const statusOptions = ['Completed', 'Assigned', 'Partial'];

    final currentStatus = useState<String>(
      HomeworkStatusMapper.fromApi(
        selectedStatus ?? hStatus.homeworkStatus,
      ),
    );


    String mapLabelToApiValue(String label) {
      switch (label) {
        case 'Completed':
          return 'Complete';   // API expects this
        case 'Partial':
          return 'Partial';
        default:
          return 'Assigned';
      }
    }


    String normalizeStatus(String? apiValue) {
      switch (apiValue?.toLowerCase().trim()) {
        case 'complete':
          return 'Completed';
        case 'partial':
          return 'Partial';
        case 'assigned':
          return 'Assigned';
        default:
          return 'Assigned';
      }
    }
    useEffect(() {
      final apiStatus = selectedStatus ?? hStatus.homeworkStatus;

      currentStatus.value = normalizeStatus(apiStatus);

      return null;
    }, [hStatus.studentId]);


    void onChangeDropDown(String? newValue) {
      if (newValue == null) return;

      currentStatus.value = newValue;
      isSelected.value = true;

      onChangeStatus(
        HomeworkStatus(
          homeworkId: hStatus.homeworkId,
          studentId: hStatus.studentId,
          homeworkStatus: HomeworkStatusMapper.toApi(newValue),
          teachercomment: commentController.text,
        ),
      );
    }


    void onChangeCheckBox(bool? value) {
      isSelected.value = value ?? false;

      onChangeStatus(
        HomeworkStatus(
          homeworkId: hStatus.homeworkId,
          studentId: hStatus.studentId,
          homeworkStatus: HomeworkStatusMapper.toApi(currentStatus.value),
          teachercomment: commentController.text,
        ),
      );
    }


    void onCommentChange(String? value) {
      onChangeStatus(
        HomeworkStatus(
          homeworkId: hStatus.homeworkId,
          studentId: hStatus.studentId,
          homeworkStatus: HomeworkStatusMapper.toApi(currentStatus.value),
          teachercomment: value ?? '',
        ),
      );
    }


    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      margin: EdgeInsets.symmetric(vertical: 6.h),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TOP ROW
            Row(
              children: [
                Checkbox(
                  value: isSelected.value,
                  onChanged: onChangeCheckBox,
                ),

                /// STUDENT NAME
                Expanded(
                  child: Text(
                    "${hStatus.firstName ?? ''} ${hStatus.lastName ?? ''}",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                /// STATUS DROPDOWN
                DropdownButton<String>(
                  value: currentStatus.value,
                  underline: const SizedBox(),
                  onChanged: onChangeDropDown,
                  items: statusOptions.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                /// COMMENT ICON
                GestureDetector(
                  onTap: () =>
                  isCommentVisible.value = !isCommentVisible.value,
                  child: Icon(
                    Icons.note_add,
                    size: 22.sp,
                    color: Colors.red,
                  ),
                ),
              ],
            ),

            SizedBox(height: 6.h),

            /// PARENT COMMENT
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Parent Comment:",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    (hStatus.parentComment?.isEmpty ?? true)
                        ? "No comments"
                        : hStatus.parentComment!,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ],
            ),

            SizedBox(height: 8.h),

            /// EXISTING TEACHER COMMENT
            // if(hStatus.comment?.isEmpty ?? false)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Teacher Comment:",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    (hStatus.comment?.isEmpty ?? true)
                        ? "No comments"
                        : hStatus.comment!,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ],
            ),

            /// COMMENT INPUT
            if (isCommentVisible.value) ...[
              SizedBox(height: 10.h),
              FormBuilderTextField(
                name: 'teacher_comment_${hStatus.studentId}',
                controller: commentController,
                onChanged: onCommentChange,
                style: TextStyle(fontSize: 12.sp),
                decoration: InputDecoration(
                  hintText: "Type comment...",
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 12.w,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
