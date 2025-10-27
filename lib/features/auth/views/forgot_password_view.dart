import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/features/auth/providers/auth_provider.dart';
import 'package:teacherapp/router/routers.dart';

import '../models/models.dart';
import '../providers/school_details_provider.dart';

class ForgotPasswordView extends HookConsumerWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authP = ref.read(authProvider.notifier);
    final school = ref.watch(schoolPProvider).requireValue;
    final fKey = useTextFieldGlobalKey();

    void showPasswordDialog(BuildContext context, String password) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  // 👈 this will force the text to wrap
                  child: Text(
                    'Password Reset Successful',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            content: const Text(
              'Your new default password is: arnolds',
              style: TextStyle(fontSize: 12),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.pop(); // Go back to previous screen
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    onReset() async {
      if (fKey.currentState?.saveAndValidate() ?? false) {
        final d = fKey.currentState?.value ?? {};
        final x = ResetPBody.fromJson(d);
        Utils.debLog("Form data: ${x.toJson()}");
        final newPassword = await authP.restPassword(x);
        Utils.debLog("Reset password result: $newPassword");
        if (newPassword != null) {
          fKey.currentState?.reset();
          showPasswordDialog(context, newPassword);
        } else {
          Utils.toast("Password reset failed. Please try again.");
        }
      } else {
        Utils.toast("Please fill all required fields");
      }
    }

    onRecivePassword() {
      authP.onRecivePassword();
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 233, 33, 103),
              Color.fromARGB(255, 9, 154, 232)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 350),
                      child: FormBuilder(
                        key: fKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 90),
                            Center(
                              child: Text(
                                "${school?.instituteName}",
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Center(
                              child: Text(
                                school?.academicYr ?? "",
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Center(
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: Text(
                                TimeOfDay.now().format(context),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              "User ID",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 5),
                            _buildTextField(
                              "Please enter your user id",
                              "user_id",
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Mother's Name",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 5),
                            _buildTextField("Mother's name", 'answer_one'),
                            const SizedBox(height: 15),
                            const Text(
                              "Date of Birth",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 5),
                            _buildDatePickerField(context, 'dob'),
                            const SizedBox(height: 30),

                            // Reset + Login Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: onReset,
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40.w, vertical: 12.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    backgroundColor: Colors.lightBlue,
                                  ),
                                  child: Text(
                                    'Reset',
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.black),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () => context.replace(
                                      TeacherVerificationRoute().location),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40.w, vertical: 12.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    backgroundColor:
                                        const Color.fromARGB(255, 245, 156, 21),
                                  ),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // 👉 New Info Line with Clickable Text
                            Center(
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  const Text(
                                    "If you do not remember answers to these questions then please enter your User ID and click on this link to ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  GestureDetector(
                                    onTap: onRecivePassword,
                                    child: const Text(
                                      "receive a new password",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 42, 52, 69),
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        // decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, String name) {
    return FormBuilderTextField(
      name: name,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'This field is required'),
      ]),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildDatePickerField(BuildContext context, String name) {
    return FormBuilderDateTimePicker(
      name: name,
      inputType: InputType.date,
      format: DateFormat('yyyy-MM-dd'),
      valueTransformer: (v) => v.toString().split(' ').first,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Date of Birth is required'),
      ]),
      decoration: InputDecoration(
        filled: true,
        suffixIcon: const Icon(Icons.calendar_today),
        fillColor: Colors.white,
        hintText: 'Date of Birth',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
