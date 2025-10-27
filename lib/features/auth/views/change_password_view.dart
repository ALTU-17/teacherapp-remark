import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/features/auth/providers/auth_provider.dart';
import 'package:teacherapp/features/home/providers/academic_year_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/models.dart';

class ChangePasswordView extends HookConsumerWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    //final academicYr = ref.watch(authProvider).requireValue.academicYr;
    final acdYear = ref.watch(academicYearProvider).requireValue;

    final authP = ref.read(authProvider.notifier);

    // Toggle for visibility
    final showOld = useState(false);
    final showNew = useState(false);
    final showRe = useState(false);

    // Controllers to preserve text
    final controllerOld = useTextEditingController();
    final controllerNew = useTextEditingController();
    final controllerRe = useTextEditingController();
    final controllerMother = useTextEditingController();

    onUpdate() async {
      if (formKey.currentState?.saveAndValidate() ?? false) {
        final d = formKey.currentState?.value ?? {};
        final res = await authP.changePassword(ForgotPBody.fromJson(d));
        if (res) {
          Fluttertoast.showToast(
            msg: 'Password updated!!',
            backgroundColor: Colors.green,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
          );
          formKey.currentState?.reset();
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Change Password",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 226, 25, 99),
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
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 38.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: FormBuilder(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("What is your mother's name?"),
                      _buildTextField(
                        name: 'answerone',
                        hint: "What is your mother's name?",
                        controller: controllerMother,
                      ),
                      SizedBox(height: 20.h),
                      _buildLabel("Current password"),
                      _buildTextField(
                        name: 'password_old',
                        hint: "Enter current password",
                        obscureText: !showOld.value,
                        isPassword: true,
                        toggleVisibility: () => showOld.value = !showOld.value,
                        controller: controllerOld,
                      ),
                      SizedBox(height: 20.h),
                      _buildLabel("New password"),
                      _buildTextField(
                        name: 'password_new',
                        hint: "Enter new password",
                        obscureText: !showNew.value,
                        isPassword: true,
                        toggleVisibility: () => showNew.value = !showNew.value,
                        controller: controllerNew,
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.minLength(8),
                          FormBuilderValidators.maxLength(20),
                          (val) {
                            if (!RegExp(r'(?=.*[0-9])(?=.*[!@#\$^&*])')
                                .hasMatch(val ?? '')) {
                              return 'Must include number and special character';
                            }
                            return null;
                          }
                        ],
                      ),
                      SizedBox(height: 20.h),
                      _buildLabel("Re-enter new password"),
                      _buildTextField(
                        name: 'password_re',
                        hint: "Re-enter new password",
                        obscureText: !showRe.value,
                        isPassword: true,
                        toggleVisibility: () => showRe.value = !showRe.value,
                        controller: controllerRe,
                        validators: [
                          FormBuilderValidators.required(),
                          (val) {
                            final pwd = formKey
                                .currentState?.fields['password_new']?.value;
                            if (val != pwd) {
                              return 'Passwords do not match';
                            }
                            return null;
                          }
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 15.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r)),
                            backgroundColor: const Color(0xFF4E9DDE),
                          ),
                          onPressed: onUpdate,
                          child: Text(
                            'Update Password ',
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 140.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: RichText(
        text: TextSpan(
          text: '* ',
          style:
              const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: text,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String name,
    String? hint,
    bool obscureText = false,
    bool isPassword = false,
    VoidCallback? toggleVisibility,
    List<String? Function(String?)>? validators,
    TextEditingController? controller,
  }) {
    return FormBuilderTextField(
      name: name,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
        suffixIcon: isPassword
            ? IconButton(
                icon:
                    Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                onPressed: toggleVisibility,
              )
            : null,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'This field is required'),
        if (validators != null) ...validators,
      ]),
    );
  }
}
