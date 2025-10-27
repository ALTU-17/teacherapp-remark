import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teacherapp/features/curriculum/LessonPlanHeading/providers/lesson_plan_heading_provider.dart';
import '../../auth/providers/auth_provider.dart';

class EditLessonPlanHeadingPage extends HookConsumerWidget {
  final String id;
  final String heading;
  final String sequence;
  final bool changeDaily;

  const EditLessonPlanHeadingPage({
    super.key,
    required this.id,
    required this.heading,
    required this.sequence,
    required this.changeDaily,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    final _headingController = TextEditingController(text: heading);
    final _sequenceController = TextEditingController(text: sequence);
    final _changeDaily = ValueNotifier<bool>(changeDaily);

    // Helper: check duplicate sequence among current headings (excluding this id)
    bool _isDuplicateSequence(String seq) {
      final state = ref.read(lessonPlanHeadingProvider);
      final list = state.hasValue ? state.value! : <dynamic>[];
      final v = seq.trim();
      return list.any((h) => h.id != id && h.sequence.trim() == v);
    }

    void _reset() {
      _headingController.clear();
      _sequenceController.clear();
      _changeDaily.value = false;
    }

    Future<void> _onUpdate() async {
      if (!_formKey.currentState!.validate()) return;

      // pre-submit duplicate check
      final seqNow = _sequenceController.text.trim();
      if (_isDuplicateSequence(seqNow)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Sequence already exists. Enter a unique value.')),
        );
        return;
      }

      final auth = ref
          .read(authProvider)
          .requireValue;
      final service = ref.read(lessonPlanHeadingCreateProvider);

      final result = await service.editHeading(
        id: id,
        sequence: seqNow,
        name: _headingController.text.trim(),
        shortName: auth.teacherVerification?.shortName ?? '',
        changeDaily: _changeDaily.value,
      );

      if (result['status'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lesson Plan Heading Updated!')),
        );
        // Pop with success flag so previous page can refresh
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['error_msg'] ?? 'Update failed')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Lesson Plan Heading',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: const Color.fromARGB(255, 208, 28, 127),
        centerTitle: true,
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
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.h),
                      TextFormField(
                        controller: _headingController,
                        decoration: InputDecoration(
                          labelText: '*Lesson Plan Heading',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          contentPadding: EdgeInsets.all(12.w),
                        ),
                        validator: (value) {
                          if (value == null || value
                              .trim()
                              .isEmpty) {
                            return 'Please enter a heading.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        controller: _sequenceController,
                        decoration: InputDecoration(
                          labelText: '*Sequence',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          contentPadding: EdgeInsets.all(12.w),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          final v = value?.trim() ?? '';
                          if (v.isEmpty)
                            return 'Please enter a sequence number.';
                          if (int.tryParse(v) == null)
                            return 'Please enter a valid number.';
                          if (_isDuplicateSequence(v)) {
                            return 'Sequence already exists. Enter a unique value.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      ValueListenableBuilder<bool>(
                        valueListenable: _changeDaily,
                        builder: (context, value, _) =>
                            Row(
                              children: [
                                Checkbox(
                                  value: value,
                                  onChanged: (v) =>
                                  _changeDaily.value = v ?? false,
                                ),
                                Text('Change daily',
                                    style: TextStyle(fontSize: 16.sp)),
                              ],
                            ),
                      ),
                      SizedBox(height: 25.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: _onUpdate,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orangeAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.w, vertical: 12.h),
                            ),
                            child: Text('Update', style: TextStyle(
                                fontSize: 16.sp, color: Colors.white)),
                          ),
                          ElevatedButton(
                            onPressed: _reset,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.w, vertical: 12.h),
                            ),
                            child: Text('Reset', style: TextStyle(
                                fontSize: 16.sp, color: Colors.white)),
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
  }}