import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:teacherapp/features/auth/providers/auth_provider.dart';

class LogoutConfirmationDialog extends ConsumerWidget {
  const LogoutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final authP = ref.read(authProvider.notifier);
    return AlertDialog(
      title: Text(
        'Logout Confirmation',
        style: TextStyle(fontSize: 22.sp),
      ),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: ListBody(
            children: <Widget>[
              Text(
                'Do you want to logout?',
                style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color.fromARGB(255, 78, 76, 76)),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(); // Dismiss the dialog
          },
        ),
        TextButton(
          child: const Text(
            'Logout',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          onPressed: () async {
            await ref.read(authProvider.notifier).logOut();

            if (context.mounted) {
              context.go('/login'); // NOT push
            }
          },

        ),
      ],
    );
  }
}

// Optional: Example usage of the widget
// Future<void> showLogoutConfirmation(BuildContext context) async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return const LogoutConfirmationDialog();
//     },
//   );
// }
