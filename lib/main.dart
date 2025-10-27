import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hive_ce_flutter/hive_flutter.dart';

import 'features/auth/models/models.dart';
import 'router/router.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await FlutterDownloader.initialize(debug: kDebugMode, ignoreSsl: true);
  Hive.registerAdapter(TeacherUserAdapter());
  Hive.registerAdapter(TeacherVerificationAdapter());
  Hive.registerAdapter(ClassInfoAdapter());
  Hive.registerAdapter(PunchInOutAdapter());
  Hive.registerAdapter(TeacherDetailsAdapter());

  await Hive.openBox<TeacherUser>('teacherUserCache');

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final router = ref.watch(routerProvider);
    return ScreenUtilInit(
      designSize: const Size(378, 892),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          // home: Container(
          //   decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [Colors.pink, Colors.blue],
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //     ),
          //   ),
          // child: LoginScreen(),
          // ),
        );
      },
    );
  }
}
