import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScaffoldWithNavigationAuth extends ConsumerWidget {
  final Widget child;

  const ScaffoldWithNavigationAuth({required this.child, super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(body: child);
  }
}
