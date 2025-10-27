import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:teacherapp/common/styles.dart';
import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/features/auth/providers/auth_provider.dart';
import 'package:teacherapp/router/routers.dart';

class TeacherVerificationView extends ConsumerStatefulWidget {
  const TeacherVerificationView({super.key});

  @override
  ConsumerState<TeacherVerificationView> createState() =>
      _TeacherVerificationViewState();
}

class _TeacherVerificationViewState
    extends ConsumerState<TeacherVerificationView> {
  final TextEditingController usernameCtrl = TextEditingController();
  bool shouldShowText = false; // Invalid user
  bool shouldShowText2 = false; // Empty username
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Whenever user types something, remove error messages
    usernameCtrl.addListener(() {
      if (usernameCtrl.text.isNotEmpty &&
          (shouldShowText || shouldShowText2)) {
        setState(() {
          shouldShowText = false;
          shouldShowText2 = false;
        });
      }
    });
  }

  Future<void> onNext() async {
    FocusScope.of(context).unfocus();

    if (usernameCtrl.text.trim().isEmpty) {
      setState(() {
        shouldShowText2 = true;
        shouldShowText = false;
      });

      Fluttertoast.showToast(
        msg: 'Please Enter User Name!!',
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
      return;
    }

    setState(() {
      _isLoading = true;
      shouldShowText2 = false;
      shouldShowText = false;
    });

    final authP = ref.read(authProvider.notifier);

    try {
      final res = await authP.validateTeacher(usernameCtrl.text.trim());
      if (res) {
        // ignore: use_build_context_synchronously
        context.pushReplacement(LoginRoute().location);
      } else {
        setState(() {
          shouldShowText = true;
        });
        Utils.toast("Invalid username. Please check and try again.");
      }
    } catch (e) {
      setState(() {
        shouldShowText = true;
      });
      Utils.toast("Username wrong. Enter a valid Username.");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    usernameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/img.png', fit: BoxFit.cover),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Image.asset('assets/logo.png', width: 200, height: 140),
                  const SizedBox(height: 5),
                  const Text('V 1.0.0', style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 10),
                  Image.asset('assets/loginPage.png',
                      width: 350.w, height: 400.h),
                  SizedBox(height: 40.h),

                  // Username Field
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: usernameCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Username',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.person_outline),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Error messages
                  Visibility(
                    visible: shouldShowText,
                    child: const Text(
                      'Invalid UserId!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: shouldShowText2,
                    child: const Text(
                      'Please Enter User Name!!',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Next button
                  _isLoading
                      ? const CircularProgressIndicator()
                      : Container(
                    height: 40,
                    width: 180,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: onNext,
                      child: const Text(
                        'Next',
                        style: TextStyle(
                            color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      'aceventuraservices@gmail.com',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
