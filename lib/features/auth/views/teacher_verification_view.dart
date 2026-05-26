import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:teacherapp/common/styles.dart';
import 'package:teacherapp/config/config.dart';
import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/features/auth/providers/auth_provider.dart';
import 'package:teacherapp/router/routers.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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

  String BaseURl = Config.dynamicEndpoint ?? "";
  String packageInfoVar ='';
  String localAndroidVersion ='';

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((value) {
      packageInfoVar = value.version;
      print(value);
    });

    getVersion(context);

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

  Future<void> getVersion(BuildContext _context) async {
    print('latest_version11 => ${BaseURl + '/flutter_teacher_apk_latest_version'}');

    final url = Uri.parse(BaseURl + '/flutter_teacher_apk_latest_version');

    try {
      final response = await http.post(url,body: {
        'type':'android'
      },);
      print('latest_version => ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print('latest_version => ${response.body}');

        if (jsonData is List && jsonData.isNotEmpty) {
          final packageInfo = await PackageInfo.fromPlatform();
          packageInfoVar = packageInfo.version;

          print('Current_version packageInfoVar=> ${packageInfoVar}');

          var lattest_androidVersion = jsonData[0]['latest_version'] as String;
          final releaseNotes = jsonData[0]['release_notes'] as String;
          final forcedUpdate = jsonData[0]['forced_update'] as String;

          if (lattest_androidVersion != null) {
            print('Current_version => 22222 ${packageInfo.version}');
            print('lattest_androidVersion => 22222 ${lattest_androidVersion}');

            // lattest_androidVersion = '1.0.1';
            // Compare versions
            if (_isVersionGreater(lattest_androidVersion, packageInfoVar)) {
              print('Current_version => 3333 ${packageInfo.version}');

              if (forcedUpdate == 'N') {
                print('Current_version => NNNNN ${packageInfo.version}');

                showDialog(
                  context: _context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('V ${lattest_androidVersion}'),
                      content: Text(releaseNotes),
                      actions: [
                        TextButton(
                          onPressed: () {
                            launchUrl(Uri.parse(
                                'https://play.google.com/store/apps/details?id=in.aceventura.evolvuschool.teacherapp'));
                          },
                          child: Text(
                            'Update',
                            style: TextStyle(
                                color: Colors.green, fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    );
                  },
                );
              } else if (forcedUpdate == 'Y') {
                print('Current_version => 44444 ${packageInfo.version}');

                showDialog(
                  context: _context,
                  barrierDismissible: false, // Prevent dismissing the dialog
                  builder: (BuildContext context) {
                    return WillPopScope(
                      onWillPop: () async => false, // Disable back button
                      child: AlertDialog(
                        title: Text('V ${lattest_androidVersion}'),
                        content: Text(releaseNotes),
                        actions: [
                          TextButton(
                            onPressed: () {
                              launchUrl(Uri.parse(
                                  'https://play.google.com/store/apps/details?id=in.aceventura.evolvuschool.teacherapp'));
                            },
                            child: Text(
                              'Update',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }}}
        } else {
          print("Unexpected JSON format");
        }
      } else {
        print('Error Response: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  bool _isVersionGreater(String newVersion, String currentVersion) {
    // Split version strings into parts
    List<int> newParts = newVersion.split('.').map((e) => int.parse(e)).toList();
    List<int> currentParts = currentVersion.split('.').map((e) => int.parse(e)).toList();

    for (int i = 0; i < newParts.length; i++) {
      if (i >= currentParts.length) {
        return true;
      }
      if (newParts[i] > currentParts[i]) {
        return true;
      } else if (newParts[i] < currentParts[i]) {
        return false;
      }
    }

    return false;
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
                   Text(packageInfoVar, style: TextStyle(color: Colors.white)),
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
