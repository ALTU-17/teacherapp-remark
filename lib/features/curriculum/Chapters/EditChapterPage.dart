import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/chapter.dart';
import '../providers/create_chapter_provider.dart';

class EditChapterPage extends HookConsumerWidget {
  final Chapter chapter;

  const EditChapterPage({super.key, required this.chapter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();

    // Controllers
    final lessonNumberCtrl = TextEditingController(text: chapter.chapterNo);
    final nameCtrl = TextEditingController(text: chapter.name);
    final subSubjectCtrl = TextEditingController(text: chapter.subSubject ?? '');
    final descriptionCtrl = TextEditingController(text: chapter.description ?? '');

    Future<void> _submitForm() async {
      if (!_formKey.currentState!.validate()) return;

      final auth = ref.read(authProvider).requireValue;
      final service = ref.read(chapterServiceProvider);

      final result = await service.editChapter(
        shortName: auth.teacherVerification?.shortName ?? '',
        classId: chapter.classId??'',
        chapterNo: lessonNumberCtrl.text,
        chapterId: chapter.chapterId ?? '',
        name: nameCtrl.text,
        loginType: 'T',
        description: descriptionCtrl.text,
        regId: auth.regId ?? '',
        smId: chapter.subjectId ?? '',
        academicYr: auth.academicYr ?? '',
        subSubject: subSubjectCtrl.text,
      );

      if (result['status'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['success_msg'] ?? "Chapter updated!")),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['error_msg'] ?? "Update failed")),
        );
      }
    }

    void _resetForm() {
      lessonNumberCtrl.text = chapter.chapterNo ?? '';
      nameCtrl.text = chapter.name ?? '';
      subSubjectCtrl.text = chapter.subSubject ?? '';
      descriptionCtrl.text = chapter.description ?? '';
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40.h,
        title: const Text("Edit Chapter", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 208, 28, 127),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Colors.pink, Colors.blue], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 150.h),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Non-editable Class & Subject
                      Row(
                        children: [
                          _buildNonEditableField(label: "*Class", value: chapter.className ?? ''),
                          SizedBox(width: 20.w),
                          _buildNonEditableField(label: "*Subject", value: chapter.subName ?? ''),
                        ],
                      ),
                      SizedBox(height: 15.h),

                      // Editable fields
                      _buildFormField(
                        label: "*Lesson Number",
                        hintText: "Enter lesson number",
                        controller: lessonNumberCtrl,
                        keyboardType: TextInputType.number,
                        isRequired: true,
                      ),
                      SizedBox(height: 15.h),

                      _buildFormField(
                        label: "*Name",
                        hintText: "Enter chapter name",
                        controller: nameCtrl,
                        isRequired: true,
                      ),
                      SizedBox(height: 15.h),

                      _buildFormField(
                        label: "Sub-Subject",
                        hintText: "Enter sub-subject",
                        controller: subSubjectCtrl,
                      ),
                      SizedBox(height: 15.h),

                      Text("Description", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8.h),
                      TextFormField(
                        controller: descriptionCtrl,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Type here...",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                          contentPadding: EdgeInsets.all(12.w),
                        ),
                      ),
                      SizedBox(height: 30.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
                            ),
                            onPressed: _submitForm,
                            child: Text("Update", style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white24,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
                            ),
                            onPressed: _resetForm,
                            child: Text("Reset", style: TextStyle(fontSize: 16.sp, color: Colors.black)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNonEditableField({required String label, required String value}) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
        SizedBox(width: 10.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(value, style: TextStyle(fontSize: 14.sp)),
        ),
      ],
    );
  }

  Widget _buildFormField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
            contentPadding: EdgeInsets.all(10.w),
          ),
          validator: isRequired
              ? (value) {
            if (value == null || value.isEmpty) {
              return "Please enter ${label.replaceAll('*', '').trim()}"; // Remove * from label in error
            }
            return null;
          }
              : null,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'[*]')), // Deny the asterisk character
          ],
        ),
      ],
    );
  }
}
