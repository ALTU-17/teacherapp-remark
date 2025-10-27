import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AboutUsScreen extends HookConsumerWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE91E63), Color(0xFF2196F3)], // Pink to Blue
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              /// 🔻 Replace with your actual logo asset
              Image.asset(
                'assets/logo.png',
                width: 150,
                height: 50,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'EvolvU Smart School App for Parents',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'EvolvU is the most effective way to assist in the progress of your child and connect with school real-time. Get all your school updates on EvolvU. We keep making it better for You with additional features in new releases.',
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'EvolvU is backed by a marvelous team of expert designers, developers, architects and quality.',
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'We thank you, Parents and school management for your inputs and support.',
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Send your new feature request on',
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'contact@aceventura.in',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Email: aceventuraservices@gmail.com',
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Rate Us:',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 8),

                        /// Dummy Google Play icon, you can link it or use custom asset
                        Icon(Icons.play_arrow, size: 28, color: Colors.green),

                        SizedBox(height: 12),
                        Text(
                          'Follow Us:',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.abc, color: Colors.blue),
                            SizedBox(width: 12),
                            Icon(Icons.facebook, color: Colors.blueAccent),
                            SizedBox(width: 12),
                            Icon(Icons.account_circle_rounded,
                                color: Colors.red),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
