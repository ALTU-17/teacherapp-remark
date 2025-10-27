import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/models.dart';

class HomeworkVCard extends HookConsumerWidget {
  final HomeworkStudentStatus hStatus;
  final void Function(HomeworkStatus status) onChangeStatus;
  final String? selectedStatus;

  const HomeworkVCard(this.hStatus, this.onChangeStatus,
      {this.selectedStatus, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = useState<bool>(false);
    final isCommentVisible = useState<bool>(false);
    final commentText = useTextEditingController();
    final statusOptions = const ['Assigned', 'Completed', 'Partial'];

    final currentStatus = useState<String>(
        selectedStatus ?? hStatus.homeworkStatus ?? 'Assigned');

    /// Initialize the local dropdown value once per student
    useEffect(() {
      final status = selectedStatus ?? hStatus.homeworkStatus;
      if (statusOptions.contains(status)) {
        currentStatus.value = status!;
      } else {
        currentStatus.value = 'Assigned';
      }
      return null;
    }, [hStatus.studentId]);

    void onChangeDropDown(String? newValue) {
      if (newValue == null) return;

      currentStatus.value = newValue;
      isSelected.value = newValue != hStatus.homeworkStatus;

      onChangeStatus(
        HomeworkStatus.fromJson(hStatus.toJson()).copyWith(
          homeworkStatus: newValue,
          teachercomment: commentText.text,
        ),
      );
    }

    void onChangeCheckBox(bool? value) {
      isSelected.value = value ?? false;

      onChangeStatus(
        HomeworkStatus.fromJson(hStatus.toJson()).copyWith(
          homeworkStatus: isSelected.value ? currentStatus.value : null,
          teachercomment: commentText.text,
        ),
      );
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                  value: isSelected.value,
                  onChanged: onChangeCheckBox,
                ),
                Expanded(
                  child: Text(
                    '${hStatus.firstName ?? ''} ${hStatus.lastName ?? ''}'
                        .trim(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                DropdownButton<String>(
                  value: currentStatus.value,
                  underline: const SizedBox(),
                  onChanged: onChangeDropDown,
                  items: statusOptions.map((String status) {
                    return DropdownMenuItem<String>(
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
                GestureDetector(
                  onTap: () {
                    isCommentVisible.value = !isCommentVisible.value;
                  },
                  child: Icon(
                    Icons.note_add,
                    color: Colors.red,
                    size: 22.sp,
                  ),
                ),
              ],
            ),

            /// Parent Comment
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    "Parent Comment:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    hStatus.parentComment?.isEmpty ?? true
                        ? "No comments"
                        : hStatus.parentComment!,
                    style: TextStyle(fontSize: 12.sp, color: Colors.black87),
                  ),
                ),
              ],
            ),

            /// Teacher Comment Field
            if (isCommentVisible.value) ...[
              SizedBox(height: 10.h),
              SizedBox(
                height: 45.h,
                child: FormBuilderTextField(
                  controller: commentText,
                  name: '',
                  style: TextStyle(fontSize: 12.sp),
                  decoration: InputDecoration(
                    hintText: "Type Comment...",
                    hintStyle:
                        TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 20.w,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
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
