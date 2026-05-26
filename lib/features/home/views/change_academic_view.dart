import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teacherapp/features/home/providers/academic_year_provider.dart';
import 'package:go_router/go_router.dart';

class ChangeAcademicView extends HookConsumerWidget {
  const ChangeAcademicView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final acdYear = ref.watch(academicYearProvider);

    // ✅ Local temp state — provider ko tab tak mat chhuao
    final tempYear = useState<String?>(null);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE91E63),
        title: const Text(
          'Change Academic Year',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE91E63), Color(0xFF2196F3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: acdYear.when(
                data: (data) {
                  final yearList = data.academicYrs
                      .where((y) => y.academicYr != null)
                      .map((y) => y.academicYr!)
                      .toList();

                  if (yearList.isEmpty) {
                    return const Text("No academic years available");
                  }

                  // ✅ Pehli baar screen open ho toh current selected year set karo
                  // Sirf ek baar initialize hoga — dobara override nahi hoga
                  if (tempYear.value == null) {
                    Future.microtask(() {
                      tempYear.value = yearList.contains(data.selectedYear)
                          ? data.selectedYear
                          : yearList.first;
                    });
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 25),
                        ),
                        hint: const Text("Select Academic Year"),
                        value: tempYear.value, // ✅ local temp value
                        onChanged: (v) {
                          // ✅ Sirf local variable update — provider nahi
                          tempYear.value = v;
                        },
                        items: yearList
                            .map(
                              (year) => DropdownMenuItem<String>(
                            value: year,
                            child: Text(year),
                          ),
                        )
                            .toList(),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (tempYear.value != null) {
                            // ✅ Sirf yahaan provider update hoga
                            ref
                                .read(academicYearProvider.notifier)
                                .changeYear(tempYear.value);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "You are now in academic year ${tempYear.value}",
                                ),
                              ),
                            );

                            Future.delayed(
                              const Duration(milliseconds: 500),
                                  () => context.go('/dashboard'), // ✅ typo fix kiya
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please select an academic year"),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Change Academic Year',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                error: (error, stackTrace) => const SizedBox.expand(),
                loading: () => const CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}