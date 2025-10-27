import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teacherapp/features/home/providers/academic_year_provider.dart';
import 'package:go_router/go_router.dart';

class ChangeAcademicView extends HookConsumerWidget {
  const ChangeAcademicView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final acdYearP = ref.read(academicYearProvider.notifier);
    final acdYear = ref.watch(academicYearProvider);
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
                margin: const EdgeInsets.symmetric(
                  horizontal: 40,
                ),
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

                    final selectedYear = yearList.contains(data.selectedYear)
                        ? data.selectedYear
                        : null;

                    if (yearList.isEmpty) {
                      return const Text("No academic years available");
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 25),
                          ),
                          hint: const Text("Select Academic Year"),
                          value: selectedYear, // Changed from initialValue to value
                          onChanged: (v) {
                            ref
                                .read(academicYearProvider.notifier)
                                .changeYear(v);
                          },
                          items: yearList
                              .map((year) => DropdownMenuItem<String>(
                            value: year,
                            child: Text(year),
                          ))
                              .toList(),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if (selectedYear != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "You are now in academic year $selectedYear"),
                                ),
                              );

                              Future.delayed(const Duration(milliseconds: 500),
                                      () {
                                    context.go('/dashbaord');
                                  });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                    Text("Please select an academic year")),
                              );
                            }
                          },
                          child: const Text(
                            'Change Academic Year',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    );
                  },
                  error: (error, stackTrace) => const SizedBox.expand(),
                  loading: () => const SizedBox.shrink(),
                )),
          ],
        ),
      ),
    );
  }
}