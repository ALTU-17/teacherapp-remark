import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/create_chapter_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CreateChapterPage extends HookConsumerWidget {
  const CreateChapterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();

    final lessonNumberCtrl = TextEditingController();
    final nameCtrl = TextEditingController();
    final subSubjectCtrl = TextEditingController();
    final descriptionCtrl = TextEditingController();

    final selectedClass = useValueNotifier<String?>(null);
    final selectedSubject = useValueNotifier<String?>(null);

    final selectedClassValue = useValueListenable(selectedClass);
    final selectedSubjectValue = useValueListenable(selectedSubject);


    final classesAsync = ref.watch(classesProvider);
    final subjectsAsync = selectedClassValue == null
        ? AsyncValue.data(<Map<String, String>>[])
        : ref.watch(subjectsProvider(selectedClassValue));

    Future<void> _submit(bool publish) async {
      if (!_formKey.currentState!.validate()) return;
      if (selectedClass.value == null || selectedSubject.value == null) {
        _showSnack(context, "Please select both class & subject");
        return;
      }
      final auth = ref.read(authProvider).requireValue;
      final service = ref.read(chapterServiceProvider);

      final result = await service.createChapter(
        shortName: auth.teacherVerification?.shortName ?? '',
        classId: selectedClass.value!,
        lessonNumber: lessonNumberCtrl.text,
        name: nameCtrl.text,
        loginType: 'T',
        description: descriptionCtrl.text,
        regId: auth.regId ?? '',
        smId: selectedSubject.value!,
        publish: publish,
        academicYr: auth.academicYr ?? '',
        subSubject: subSubjectCtrl.text,
      );

      if (result['status'] == true) {
        _showSnack(context, result['success_msg'] ?? "Chapter saved!");
        Navigator.pop(context, true);
      } else {
        _showSnack(context, result['error_msg'] ?? "Failed to save");
      }
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40.h,
        title: const Text(
          "Create Chapters",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
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
          gradient: LinearGradient(
            colors: [Colors.pink, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 140.h),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// ====== Class DropDown ======
                      _label("*Class"),
                      classesAsync.when(
                        data: (classes) => DropdownButtonFormField<String>(
                          value: selectedClass.value,
                          isExpanded: true,
                          items: classes
                              .map((c) => DropdownMenuItem(
                            value: c["class_id"].toString(),
                            child: Text(c["class_name"] ?? ''),
                          ))
                              .toList(),
                          onChanged: (val) {
                            selectedClass.value = val;
                            selectedSubject.value = null;
                          },
                          validator: (val) =>
                          val == null ? "Please select class" : null,
                          decoration: _inputDecoration(),
                        ),
                        error: (err, st) => Text("Error loading classes"),
                        loading: () => const LinearProgressIndicator(),
                      ),
                      SizedBox(height: 10.h),

                      _label("*Subject"),
                      subjectsAsync.when(
                        data: (subs) => DropdownButtonFormField<String>(
                          value: selectedSubject.value,
                          isExpanded: true,
                          items: subs
                              .map((s) => DropdownMenuItem(
                            value: s["sm_id"].toString(),
                            child: Text(s["name"] ?? ''),
                          ))
                              .toList(),
                          onChanged: (val) => selectedSubject.value = val,
                          validator: (val) =>
                          val == null ? "Please select subject" : null,
                          decoration: _inputDecoration(),
                        ),
                        error: (err, st) => Text("Error loading subjects"),
                        loading: () => const LinearProgressIndicator(),
                      ),
                      SizedBox(height: 10.h),


                      _buildField(
                        "*Lesson Number",
                        hintText: "Enter lesson number",
                        controller: lessonNumberCtrl,
                        keyboardType: TextInputType.number,
                        isRequired: true,
                      ),
                      SizedBox(height: 10.h),


                      _buildField(
                        "*Name",
                        hintText: "Enter chapter name",
                        controller: nameCtrl,
                        isRequired: true,
                      ),
                      SizedBox(height: 10.h),

                      /// Sub-Subject
                      _buildField(
                        "Sub-Subject",
                        hintText: "Enter sub-subject",
                        controller: subSubjectCtrl,
                      ),
                      SizedBox(height: 10.h),

                      /// Description
                      _label("Description"),
                      TextFormField(
                        controller: descriptionCtrl,
                        maxLines: 2,
                        decoration: _inputDecoration(hintText: "Type here..."),
                      ),
                      SizedBox(height: 20.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _actionButton(
                              text: "Save",
                              color: Colors.blue,
                              onPressed: () => _submit(false)),
                          _actionButton(
                              text: "Reset",
                              color: Colors.grey.shade300,
                              textColor: Colors.black,
                              onPressed: () => _formKey.currentState?.reset()),
                          _actionButton(
                              text: "Save & Publish",
                              color: Colors.blue,
                              onPressed: () => _submit(true)),
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

  Widget _label(String text) => Text(
    text,
    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
  );

  InputDecoration _inputDecoration({String? hintText}) => InputDecoration(
    hintText: hintText,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
    contentPadding: EdgeInsets.all(10.w),
  );

  Widget _buildField(
      String label, {
        required String hintText,
        required TextEditingController controller,
        TextInputType keyboardType = TextInputType.text,
        bool isRequired = false,
      }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label(label), // Assuming _label function handles displaying the label text like "*Name"
          SizedBox(height: 5.h),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: _inputDecoration(hintText: hintText),
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
  Widget _actionButton({
    required String text,
    required Color color,
    Color textColor = Colors.white,
    required VoidCallback onPressed,
  }) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        ),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: textColor, fontSize: 14.sp)),
      );

  void _showSnack(BuildContext ctx, String msg) =>
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(msg)));
}
