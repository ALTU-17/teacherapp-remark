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

              const SizedBox(height: 0),

              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 26, vertical: 80),
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
                          'Evolvu - Smart Teacher App',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'EvolvU enables educators to manage school-related tasks seamlessly from their mobile devices, enhancing flexibility and productivity.',
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'We extend our gratitude to the teachers, parents, and school management whose insights have shaped the app’s evolution. Backed by a skilled team of designers, developers, architects. EvolvU continues to grow through collaborative innovation.',
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        // SizedBox(height: 10),
                        // Text(
                        //   'EvolvU is backed by a marvelous team of expert designers, developers, architects and quality.',
                        //   style: TextStyle(fontSize: 15),
                        //   textAlign: TextAlign.center,
                        // ),
                        // SizedBox(height: 10),
                        // Text(
                        //   'We thank you, Parents and school management for your inputs and support.',
                        //   style: TextStyle(fontSize: 15),
                        //   textAlign: TextAlign.center,
                        // ),
                        // SizedBox(height: 15),
                        // Text(
                        //   'Send your new feature request on',
                        //   style: TextStyle(fontSize: 14),
                        //   textAlign: TextAlign.center,
                        // ),
                        // SizedBox(height: 4),
                        // Text(
                        //   'contact@aceventura.in',
                        //   style: TextStyle(
                        //     fontSize: 15,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        SizedBox(height: 6),
                        Text(
                          'Email: aceventuraservices@gmail.com',
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Rate Us:',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 8),

                        /// Dummy Google Play icon, you can link it or use custom asset
                        Icon(Icons.play_arrow, size: 28, color: Colors.green),

                        // SizedBox(height: 12),
                        // Text(
                        //   'Follow Us:',
                        //   style: TextStyle(fontSize: 14),
                        // ),
                        // SizedBox(height: 8),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Icon(Icons.abc, color: Colors.blue),
                        //     SizedBox(width: 12),
                        //     Icon(Icons.facebook, color: Colors.blueAccent),
                        //     SizedBox(width: 12),
                        //     Icon(Icons.account_circle_rounded,
                        //         color: Colors.red),
                        //   ],
                        // ),
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
