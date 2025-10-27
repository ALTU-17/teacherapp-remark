import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../auth/providers/auth_provider.dart';

class LessonPlanTemplatePage extends ConsumerStatefulWidget {
  const LessonPlanTemplatePage({Key? key}) : super(key: key);

  @override
  ConsumerState<LessonPlanTemplatePage> createState() =>
      _LessonPlanTemplatePageState();
}

class _LessonPlanTemplatePageState
    extends ConsumerState<LessonPlanTemplatePage> {
  late WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // 🔹 Fetch dynamic values from authProvider
    final auth = ref.read(authProvider).requireValue;

    final String regId = auth.regId ?? '';
    final String acdYr = auth.academicYr ?? '';
    final String newUrl = auth.teacherVerification?.teacherapkUrl ?? '';

    // 🔹 Build the lesson plan template URL dynamically
    final templateUrl =
        "$newUrl/curriculum/apk_lesson_plan_template?reg_id=$regId&acd_yr=$acdYr&login_type=T";

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
        ),
      )
      ..loadRequest(Uri.parse(templateUrl));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40,
        title: const Text(
          "Lesson Plan Template",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 208, 28, 127),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink, Colors.blue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 120.h),
                Expanded(
                  child: WebViewWidget(controller: _controller),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(), // Display loading spinner
            ),
        ],
      ),
    );
  }
}

  