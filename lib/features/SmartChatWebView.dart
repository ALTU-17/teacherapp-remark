import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'auth/providers/auth_provider.dart';

class SmartChatPage extends ConsumerStatefulWidget {
  final String? customUrl; // Dynamic URL from API

  const SmartChatPage({super.key, this.customUrl});

  @override
  ConsumerState<SmartChatPage> createState() => _SmartChatPageState();
}

class _SmartChatPageState extends ConsumerState<SmartChatPage> {
  bool _isLoading = true;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _loadSmartChat();
  }

  Future<void> _loadSmartChat() async {
    final auth = ref.read(authProvider).requireValue;
    final String shortName = auth.teacherVerification?.shortName ?? '';
    final String regId = auth.regId ?? '';
    final String acdYr = auth.academicYr ?? '';

    // Use custom URL from API if provided
    String baseUrl;
    if (widget.customUrl != null && widget.customUrl!.isNotEmpty) {
      baseUrl = widget.customUrl!;
      debugPrint("🚀 Using custom Smart Chat URL: $baseUrl");
    } else {
      // Fallback to default URL
      baseUrl = '${auth.teacherVerification?.teacherapkUrl}admin/smart_chat_teacher_apk/' ?? '';
      debugPrint("🚀 Using default Smart Chat URL: $baseUrl");
    }

    // Ensure URL ends with proper format
    if (!baseUrl.endsWith('/') && !baseUrl.contains('?')) {
      baseUrl = '$baseUrl/';
    }

    final finalUrl = Uri.parse("$baseUrl?teacher_id=$regId&academic_yr=$acdYr");
    debugPrint("🌐 Final Smart Chat URL: $finalUrl");

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (error) {
            debugPrint("❌ Smart Chat error: ${error.description}");
            setState(() {
              _isLoading = false;
            });
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to load: ${error.description}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      )
      ..loadRequest(finalUrl);
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
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              _loadSmartChat();
            },
          ),
        ],
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
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 208, 28, 127),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Loading Smart Chat...",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}