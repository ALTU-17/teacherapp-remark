import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF7CCA2),
            Color(0xFFF64784)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      height: double.infinity,
      width: double.infinity,
      child: const Center(
        child: Text(
          "EvolvU Smart Teacher",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
