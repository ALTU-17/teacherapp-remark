import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'auth/providers/auth_provider.dart';

class SmartChatPage extends ConsumerStatefulWidget {
  const SmartChatPage({super.key});

  @override
  ConsumerState<SmartChatPage> createState() => _SmartChatPageState();
}

class _SmartChatPageState extends ConsumerState<SmartChatPage> {
  bool _isLoading = true;

  // final String regId = "14";
  // final String acdYr = "2024-2025";
  // final String newUrl = "https://sms.arnoldcentralschool.org/SACSv4test/index.php/admin/smart_chat_teacher_apk/";
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    final auth = ref.read(authProvider).requireValue;
    final String shortName = auth.teacherVerification?.shortName ?? '';
    final String regId = auth.regId ?? '';
    final String acdYr = auth.academicYr ?? '';
    final String newUrl = '${auth.teacherVerification?.teacherapkUrl}admin/smart_chat_teacher_apk/' ?? '';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              _isLoading =
                  true; // Show loading indicator when page starts loading
            });
          },
          onPageFinished: (url) {
            setState(() {
              _isLoading = false; // Hide loading indicator when page finishes loading
            });
          },
        ),
      )
      ..loadRequest(
          Uri.parse("$newUrl?teacher_id=$regId&academic_yr=$acdYr"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40.h,
        title: const Text(
          "Smart Chat",
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
                SizedBox(height: 100.h),
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
