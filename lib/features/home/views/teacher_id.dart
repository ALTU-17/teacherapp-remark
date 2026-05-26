import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacherapp/features/auth/providers/auth_provider.dart';

import '../Notice Board APIS/StaffApiService.dart';







final staffApiProvider = Provider<StaffApiService>((ref) {
  final auth = ref.read(authProvider).requireValue;

  final baseUrl = auth.teacherVerification?.projectUrl ??
      auth.teacherVerification?.teacherapkUrl ??
      '';

  if (baseUrl.isEmpty) {
    throw Exception('Laravel base URL missing');
  }

  return StaffApiService(baseUrl);
});

Future<String?> getLaravelBaseUrl() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('laravel_base_url');
}
Future<String?> getLaravelToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

final teacherProvider = FutureProvider<Teacher>((ref) async {
  final auth = ref.watch(authProvider).requireValue;
  final service = ref.watch(staffApiProvider);

  final regId = auth.regId ?? '';
  final classId = auth.teacherDetails!.classId ?? '';
  final sectionId = auth.teacherDetails!.sectionId ?? '';
  if (regId.isEmpty) throw Exception('RegId missing');

  return service.getTeacher(
    regId: regId,
    token: 'HARDCODED_TOKEN',
  );
});


class Teacher {
  final String employeeId;
  final String name;
  final String gender;
  final String bloodGroup;
  final String phone;
  final String emergencyPhone;
  final String address;
  final String permanentAddress;
  final String confirm;

  Teacher({
    required this.employeeId,
    required this.name,
    required this.gender,
    required this.bloodGroup,
    required this.phone,
    required this.emergencyPhone,
    required this.address,
    required this.permanentAddress,
    required this.confirm,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      employeeId: json['employee_id'] ?? '',
      name: json['name'] ?? '',
      gender: (json['sex'] ?? '').toLowerCase() == 'male' ? 'Male' : 'Female', // Normalize here
      bloodGroup: json['blood_group'] ?? '',
      phone: json['phone'] ?? '',
      emergencyPhone: json['emergency_phone'] ?? '',
      address: json['address'] ?? '',
      permanentAddress: json['permanent_address'] ?? '',
      confirm: json['confirm'] ?? 'N',
    );
  }
  bool get isConfirmed => confirm == 'Y';
}

class StaffIdCardPage extends HookConsumerWidget {
  const StaffIdCardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get teacher data from provider
    final teacherAsync = ref.watch(teacherProvider);

    return teacherAsync.when(
      data: (teacher) => _StaffIdCardForm(teacher: teacher),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

class _StaffIdCardForm extends HookConsumerWidget {
  final Teacher teacher;
  final isSaving = useState(false);

  _StaffIdCardForm({required this.teacher});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Form key
    final formKey = useMemoized(() => GlobalKey<FormState>());

    // Controllers with teacher data
    final nameCtrl = useMemoized(() => TextEditingController(text: teacher.name));
    final contactCtrl = useMemoized(() => TextEditingController(text: teacher.phone));
    final emergencyCtrl = useMemoized(() => TextEditingController(text: teacher.emergencyPhone));
    final employeeIdCtrl = useMemoized(() => TextEditingController(text: teacher.employeeId));
    final currentAddressCtrl = useMemoized(() => TextEditingController(text: teacher.address));
    final permanentAddressCtrl = useMemoized(() => TextEditingController(text: teacher.permanentAddress));
    final genderValue = useMemoized(() => TextEditingController(text: teacher.gender));

    // Dispose controllers
    useEffect(() {
      return () {
        nameCtrl.dispose();
        contactCtrl.dispose();
        emergencyCtrl.dispose();
        employeeIdCtrl.dispose();
        currentAddressCtrl.dispose();
        permanentAddressCtrl.dispose();
      };
    }, []);

    // Dropdown state with teacher data
    // final genderValue = useState<String>(teacher.gender.isNotEmpty ? teacher.gender : 'Female');
    final bloodGroupValue =
    useState<String?>(normalizeBloodGroup(teacher.bloodGroup));



    // Checkboxes
    final sameAsCurrent = useState<bool>(teacher.address == teacher.permanentAddress);
    // Declaration checkbox - convert 'Y'/'N' to boolean
    final declarationChecked = useState<bool>(teacher.confirm == 'Y');

    useEffect(() {
      if (sameAsCurrent.value) {
        permanentAddressCtrl.text = currentAddressCtrl.text;
      }
      // ❌ DO NOT clear here
      return null;
    }, [sameAsCurrent.value]);



    // Colors
    const headerColor = Color(0xFFD01C7F);
    const cardBorderColor = Color(0xFFDD2E68);

    Future<void> _onSave() async {
      final form = formKey.currentState;

      if (form == null || !form.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please correct errors before saving')),
        );
        return;
      }

      if (!declarationChecked.value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please accept the declaration')),
        );
        return;
      }

      final payload = {
        'name': nameCtrl.text.trim(),
        'phone': contactCtrl.text.trim(),
        'emergency_phone': emergencyCtrl.text.trim(),
        'sex': genderValue.text.trim(),
        'blood_group': bloodGroupValue.value,
        'employee_id': employeeIdCtrl.text.trim(),
        'address': currentAddressCtrl.text.trim(),
        'permanent_address': permanentAddressCtrl.text.trim(),
        'confirm_status': declarationChecked.value ? 'Y' : 'N',
      };

      try {
        isSaving.value = true;

        // 🔹 Providers
        final authState = ref.read(authProvider).requireValue;
        final authNotifier = ref.read(authProvider.notifier);
        final staffService = ref.read(staffApiProvider);

        // ===============================
        // 1️⃣ UPDATE ID CARD (Laravel)
        // ===============================
        await staffService.updateTeacher(
          regId: authState.regId!,
          token: 'HARDCODED_TOKEN',
          body: payload,
        );

        // ===============================
        // 2️⃣ FETCH FRESH DATA (Laravel)
        // ===============================
        final updatedTeacher = await staffService.getTeacher(
          regId: authState.regId!,
          token: 'HARDCODED_TOKEN',
        );

        // ===============================
        // 3️⃣ SYNC INTO authProvider
        // ===============================
        await authNotifier.refreshTeacherFromLaravel(updatedTeacher);

        // ===============================
        // 4️⃣ REFRESH ID CARD PROVIDER
        // ===============================
        ref.invalidate(teacherProvider);

        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saved successfully')),
        );

        Navigator.of(context).pop(); // close ID card page
      } catch (e) {
        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Save failed: $e')),
        );

        debugPrint('Save error: $e');
      } finally {
        isSaving.value = false;
      }
    }



    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: headerColor,
        title: Text(
          'Staff ID Card Details',
          style: TextStyle(fontSize: 18.sp, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE91E63), Color(0xFF2196F3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1000.w),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    side: BorderSide(color: cardBorderColor.withOpacity(0.2)),
                  ),
                  elevation: 6,
                  child: Padding(
                    padding: EdgeInsets.all(18.w),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LayoutBuilder(builder: (context, constraints) {
                            final isWide = constraints.maxWidth > 700;
                            return Wrap(
                              spacing: 12.w,
                              runSpacing: 5.h,
                              children: [
                                // Name
                                SizedBox(
                                  width: isWide ? (constraints.maxWidth / 3) - 16 : double.infinity,
                                  child: _buildLabel('Name *'),
                                ),
                                SizedBox(width: 8.w),
                                SizedBox(
                                  width: isWide ? (constraints.maxWidth / 3) - 16 : double.infinity,
                                  child: TextFormField(
                                    controller: nameCtrl,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                                    ),
                                  ),
                                ),

                                // Contact
                                SizedBox(
                                  width: isWide ? (constraints.maxWidth / 3) - 16 : double.infinity,
                                  child: _buildLabel('Contact no. *'),
                                ),
                                SizedBox(
                                  width: isWide ? (constraints.maxWidth / 3) - 16 : double.infinity,
                                  child: TextFormField(
                                    controller: contactCtrl,
                                    keyboardType: TextInputType.phone,
                                    maxLength: 10, // ✅ MAX 10 digits
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly, // ✅ only numbers
                                    ],
                                    validator: (v) {
                                      if (v == null || v.trim().isEmpty) return 'Enter mobile no';
                                      if (v.trim().length != 10) return 'Enter 10 digit mobile number';
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      counterText: '', // ❌ hides 0/10 counter (optional)
                                      prefixText: '+91 ',
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding:
                                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                                      border:
                                      OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                                    ),
                                  ),
                                ),

// ================= Emergency Contact =================

                                SizedBox(
                                  width: isWide ? (constraints.maxWidth / 3) - 16 : double.infinity,
                                  child: _buildLabel('Emergency contact no. *'),
                                ),
                                SizedBox(
                                  width: isWide ? (constraints.maxWidth / 3) - 16 : double.infinity,
                                  child: TextFormField(
                                    controller: emergencyCtrl,
                                    keyboardType: TextInputType.phone,
                                    maxLength: 10, // ✅ MAX 10 digits
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    validator: (v) {
                                      if (v == null || v.trim().isEmpty)
                                        return 'Enter emergency mobile no';
                                      if (v.trim().length != 10)
                                        return 'Enter 10 digit mobile number';
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      counterText: '',
                                      prefixText: '+91 ',
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding:
                                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                                      border:
                                      OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                                    ),
                                  ),
                                ),


                                // Gender
                                SizedBox(
                                  width: isWide ? (constraints.maxWidth / 3) - 16 : double.infinity,
                                  child: _buildLabel('Gender *'),
                                ),
                                SizedBox(
                                  width: isWide ? (constraints.maxWidth / 3) - 16 : double.infinity,
                                  child: TextFormField(
                                    controller: genderValue,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   width: isWide ? (constraints.maxWidth / 3) - 16 : double.infinity,
                                //   child: DropdownButtonFormField<String>(
                                //     value: _normalizeGender(genderValue.value), // Normalize the value
                                //     items: ['Male', 'Female']
                                //         .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                                //         .toList(),
                                //     onChanged: (v) => genderValue.value = v ?? 'Female',
                                //     decoration: InputDecoration(
                                //       filled: true,
                                //       fillColor: Colors.white,
                                //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                                //     ),
                                //   ),
                                // ),

                                // Blood Group
                                SizedBox(
                                  width: isWide ? (constraints.maxWidth / 3) - 16 : double.infinity,
                                  child: _buildLabel('Blood Group *'),
                                ),
                                SizedBox(
                                  width: isWide
                                      ? (constraints.maxWidth / 3) - 16
                                      : double.infinity,
                                  child: DropdownButtonFormField<String>(
                                    value: bloodGroupValue.value, // can be null ✅
                                    hint: const Text('Select Blood Group'), // 👈 shows when null
                                    items: const [
                                      'A+','A-','B+','B-','O+','O-','AB+','AB-'
                                    ].map((bg) =>
                                        DropdownMenuItem(value: bg, child: Text(bg)))
                                        .toList(),
                                    onChanged: (v) => bloodGroupValue.value = v,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                                    ),
                                    validator: (v) {
                                      if (v == null || v.isEmpty) {
                                        return 'Please select blood group';
                                      }
                                      return null;
                                    },
                                  )

                                ),


                                // Employee ID
                                SizedBox(
                                  width: isWide ? (constraints.maxWidth / 3) - 16 : double.infinity,
                                  child: _buildLabel('Employee ID *'),
                                ),
                                SizedBox(
                                  width: isWide ? (constraints.maxWidth / 3) - 16 : double.infinity,
                                  child: TextFormField(
                                    controller: employeeIdCtrl,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                                    ),
                                  ),
                                ),

                                // Current Address
                                SizedBox(
                                  width: double.infinity,
                                  child: _buildLabel('Current Address *'),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: currentAddressCtrl,
                                    maxLines: 3,
                                    validator: (v) {
                                      if (v == null || v.trim().isEmpty) return 'Enter current address';
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                                    ),
                                  ),
                                ),

                                // Permanent Address + checkbox
                                SizedBox(width: 8.w),
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(child: _buildLabel('Permanent Address *')),
                                      SizedBox(width: 12.w),
                                      Checkbox(
                                        value: sameAsCurrent.value,
                                        onChanged: (v) {
                                          final checked = v ?? false;

                                          if (!checked && sameAsCurrent.value) {
                                            // 🔥 only clear once when moving from checked → unchecked
                                            permanentAddressCtrl.clear();
                                          }

                                          sameAsCurrent.value = checked;
                                        },
                                      ),

                                      const Text('Same as \nCurrent Address',style: TextStyle(fontSize: 13),),
                                    ],
                                  ),
                                ),
                                TextFormField(
                                  controller: permanentAddressCtrl,
                                  maxLines: 3,
                                  // enabled: !sameAsCurrent.value, // 🔑 prevent typing when auto-filled
                                  validator: (v) {
                                    if (!sameAsCurrent.value && (v == null || v.trim().isEmpty)) {
                                      return 'Enter permanent address';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                ),




                                // Declaration checkbox
                                SizedBox(width: double.infinity, child: SizedBox(height: 1.h)),
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: declarationChecked.value,
                                        onChanged: (v) => declarationChecked.value = v ?? false,
                                      ),
                                      Flexible(
                                        child: Text(
                                          'I hereby declare that the information provided is true and correct.',
                                          style: TextStyle(fontSize: 13.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Save Button
                                Padding(
                                  padding: const EdgeInsets.only(left: 130.0),
                                  child: Row(
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 12.h),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                                        ),
                                        onPressed: _onSave,
                                        child: Text('Save', style: TextStyle(fontSize: 14.sp, color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? normalizeBloodGroup(String? bg) {
    if (bg == null || bg.trim().isEmpty) return null;

    bg = bg.toUpperCase().trim();

    if (bg == 'A') return 'A+';
    if (bg == 'B') return 'B+';
    if (bg == 'O') return 'O+';
    if (bg == 'AB') return 'AB+';

    const valid = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
    if (valid.contains(bg)) return bg;

    return null; // unknown value → no selection
  }



  String _normalizeGender(String value) {
    if (value.toLowerCase() == 'male') return 'Male';
    if (value.toLowerCase() == 'female') return 'Female';
    return 'Female'; // Default
  }
  Widget _buildLabel(String text) => Padding(
    padding: EdgeInsets.only(bottom: 6.h, top: 6.h),
    child: Text(text, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp)),
  );
}