import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final List<String> options;
  final Function(String?)? onChanged;
  final bool isRequired;
  final bool readOnly;
  final String name;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.options,
    this.onChanged,
    required this.name,
    this.isRequired = false,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 130.w,
            child: RichText(
              text: TextSpan(
                text: label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5.sp,
                  color: Colors.black,
                ),
                children: isRequired
                    ? [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(color: Colors.red, fontSize: 14.sp),
                        )
                      ]
                    : [],
              ),
            ),
          ),
          Expanded(
            child: IgnorePointer(
              ignoring: readOnly,
              child: Opacity(
                opacity: readOnly ? 0.72 : 1,
                child: FormBuilderDropdown(
                  name: name,
                  initialValue: initialValue,
                  items: options.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item, style: TextStyle(fontSize: 12.sp)),
                    );
                  }).toList(),
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    filled: readOnly,
                    fillColor: readOnly ? Colors.grey.shade100 : null,
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
