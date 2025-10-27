import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dio/dio.dart';
import 'package:share_plus/share_plus.dart';
import 'package:open_filex/open_filex.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teacherapp/config/config.dart';

class Utils {
  static void debLog(print) {
    if (kDebugMode) {
      log(print.toString());
    }
  }

  static void de(print) {
    if (kDebugMode) {
      debugger(message: print);
    }
  }

  static Future toast(String msg, [success = false]) {
    return Fluttertoast.showToast(
      backgroundColor:
          // ignore: deprecated_member_use
          success ? Colors.green.withOpacity(0.9) : primary.withOpacity(0.9),
      msg: msg,
    );
  }

  static String extractLastTenDigits(String phoneNumber) {
    phoneNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
    if (phoneNumber.length < 10) {
      throw ArgumentError('Phone number must have at least 10 digits.');
    }

    String lastTenDigits = phoneNumber.substring(phoneNumber.length - 10);
    return lastTenDigits;
  }

  static String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input; // Handle empty string

    // Make the first letter uppercase and the rest lowercase
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  static String calculateReadingTime(String description) {
    // Average reading speed in words per minute
    const int wordsPerMinute = 200;

    // Split the text into words and count them
    int wordCount = description.split(RegExp(r'\s+')).length;

    // Calculate reading time in minutes
    double readingTime = wordCount / wordsPerMinute;

    // Round up to the nearest whole number
    int minutes = readingTime.ceil();

    // Return formatted string
    return minutes == 1 ? "$minutes" : "$minutes";
  }

  static bool containsElementTenTimes(List<String> items) {
    // Create a frequency map
    Map<dynamic, int> frequency = {};

    // Count occurrences of each element
    for (var item in items) {
      frequency[item] = (frequency[item] ?? 0) + 1;
      // If any element reaches 10 occurrences, return true early
      if (frequency[item] == 10) {
        return true;
      }
    }

    // Return false if no element appears 10 times
    return false;
  }

  static Color getRandomColor() {
    final random = math.Random();
    return Color.fromRGBO(
      random.nextInt(256), // Red
      random.nextInt(256), // Green
      random.nextInt(256), // Blue
      1, // Opacity
    );
  }

  static Future<String> fileToBase64(File file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  Future<void> onDownload(String filename, List<String> documentUrls,
      {String? subfolder}) async {
    try {
      // Get the document URLs from your API

      // Find the URL that contains the filename
      final documentUrl = documentUrls.firstWhere(
        (url) => url.contains(filename),
        orElse: () => '',
      );

      if (documentUrl.isEmpty) {
        Utils.toast("File not found");
        return;
      }

      // Platform-specific handling
      if (Platform.isIOS) {
        // For iOS, download and save to a proper location
        await _downloadFileForIOS(documentUrl, filename);
      } else {
        // For Android, use downloads directory and create structured folders
        final dir = await getDownloadsDirectory();
        String base = dir?.path ?? "";
        String target = base;
        final folder = subfolder?.trim().isNotEmpty == true
            ? subfolder!.trim()
            : 'TeacherApp/Homework';
        if (base.isNotEmpty) {
          target = "$base/$folder";
          final d = Directory(target);
          if (!await d.exists()) {
            await d.create(recursive: true);
          }
        }
        final savedDir = target;
        // Utils.debLog("Android save directory: $savedDir");
        Fluttertoast.showToast(msg: "Android save directory: $savedDir");

        final taskId = await FlutterDownloader.enqueue(
          url: documentUrl,
          savedDir: savedDir,
          saveInPublicStorage: true,
          fileName: filename.split("/").last,
          showNotification: true,
          openFileFromNotification: true,
        );

        if (taskId != null) {
          // Utils.toast("Download started: $filename");
          Fluttertoast.showToast(msg: "Download started: $filename");
        } else {
          Utils.toast("Failed to enqueue download: $filename");
        }
      }
    } catch (e) {
      Utils.debLog(e);
      Utils.toast("Error downloading file: ${e.toString()}");
    }
  }

  Future<void> _downloadFileForIOS(String url, String filename) async {
    try {
      Utils.toast("Downloading file...");

      final dio = Dio();

      // Get the app documents directory
      final docsDir = await getApplicationDocumentsDirectory();
      // Create the TeacherApp/Homework subdirectory
      final targetDir = Directory('${docsDir.path}/TeacherApp/Homework');
      if (!await targetDir.exists()) {
        await targetDir.create(recursive: true);
      }

      final filePath = '${targetDir.path}/${filename.split("/").last}';
      final file = File(filePath);

      Utils.debLog("Downloading to: $filePath");

      // Download the file
      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = (received / total * 100).toStringAsFixed(0);
            Utils.debLog("Download progress: $progress%");
          }
        },
      );

      Utils.toast(
          "File downloaded! Opening share sheet to save to Files app...", true);
      Utils.debLog("File saved to: $filePath");

      // Use share_plus to open iOS Share Sheet - user can choose "Save to Files"
      await Utils.shareFile(filePath,
          text: 'Save this file to your preferred location');

      Utils.toast(
          "Use 'Save to Files' in the share sheet to save to Downloads folder",
          true);
    } catch (e) {
      Utils.debLog("Error downloading file for iOS: $e");
      Utils.toast("Failed to download file: ${e.toString()}");
    }
  }

  /// Open any file type using the open_file package
  /// Supports both local file paths and network URLs
  static Future<void> openFileView(String filePath) async {
    try {
      Utils.debLog("Opening file: $filePath");

      // Check if it's a network URL
      bool isNetworkUrl =
          filePath.startsWith('http://') || filePath.startsWith('https://');

      if (isNetworkUrl) {
        // For network URLs, we need to download the file first
        await _openNetworkFile(filePath);
      } else {
        // For local files, check if file exists
        final file = File(filePath);
        if (!await file.exists()) {
          Utils.toast("File not found: $filePath");
          return;
        }

        // Open the local file
        await _openLocalFile(filePath);
      }
    } catch (e) {
      Utils.debLog("Error opening file: $e");
      Utils.toast("Error opening file: ${e.toString()}");
    }
  }

  /// Open a local file
  static Future<void> _openLocalFile(String filePath) async {
    try {
      await OpenFilex.open(filePath);
      Utils.toast("File opened successfully", true);
    } catch (e) {
      Utils.debLog("Error opening file: $e");
      Utils.toast("Error opening file: ${e.toString()}");
    }
  }

  /// Download and open a network file
  static Future<void> _openNetworkFile(String url) async {
    try {
      Utils.toast("Downloading file...");

      // Create a Dio instance for downloading
      final dio = Dio();

      // Get the filename from URL
      final filename = url.split('/').last;
      if (filename.isEmpty) {
        Utils.toast("Invalid URL: Could not extract filename");
        return;
      }

      // Get temporary directory for download
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/$filename';

      Utils.debLog("Downloading to: $filePath");

      // Download the file
      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = (received / total * 100).toStringAsFixed(0);
            Utils.debLog("Download progress: $progress%");
          }
        },
      );

      Utils.toast("File downloaded successfully", true);

      // Open the downloaded file
      await _openLocalFile(filePath);
    } catch (e) {
      Utils.debLog("Error downloading network file: $e");
      Utils.toast("Failed to download file: ${e.toString()}");
    }
  }

  /// Share a file using iOS Share Sheet - allows users to save to Files app
  static Future<void> shareFile(String filePath, {String? text}) async {
    try {
      await Share.shareXFiles([XFile(filePath)],
          text: text ?? 'Save this file to your preferred location');
    } catch (e) {
      Utils.debLog("Error sharing file: $e");
      Utils.toast("Failed to share file", false);
    }
  }
}

GlobalKey<FormBuilderState> useTextFieldGlobalKey() {
  return useMemoized(() => GlobalKey<FormBuilderState>());
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  Future<T> run<T>(Future<T> Function() action) {
    final completer = Completer<T>();

    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), () async {
      try {
        final result = await action();
        completer.complete(result);
      } catch (e) {
        completer.completeError(e);
      }
    });

    return completer.future;
  }
}

FutureOr<void> Function()? onWindowShouldClose;

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
        return const BouncingScrollPhysics();
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }
}
