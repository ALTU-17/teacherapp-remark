// file: staff_id_card_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Simple data model for demo — replace with your real model if you have one.
class Staff {
  String? name;
  String? contact;
  String? emergencyContact;
  String? gender;
  String? bloodGroup;
  String? employeeId;
  String? currentAddress;
  String? permanentAddress;
  bool declare;

  Staff({
    this.name,
    this.contact,
    this.emergencyContact,
    this.gender,
    this.bloodGroup,
    this.employeeId,
    this.currentAddress,
    this.permanentAddress,
    this.declare = false,
  });
}

/// Main page widget (Hook + Riverpod friendly).
class StaffIdCardPage extends HookConsumerWidget {
  final Staff staff;
  const StaffIdCardPage({super.key, required this.staff});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Form key (memoized)
    final formKey = useMemoized(() => GlobalKey<FormState>());

    // Controllers (memoized so rebuilds don't recreate them)
    final nameCtrl = useMemoized(() => TextEditingController(text: staff.name ?? ''));
    final contactCtrl = useMemoized(() => TextEditingController(text: staff.contact ?? ''));
    final emergencyCtrl = useMemoized(() => TextEditingController(text: staff.emergencyContact ?? ''));
    final employeeIdCtrl = useMemoized(() => TextEditingController(text: staff.employeeId ?? ''));
    final currentAddressCtrl = useMemoized(() => TextEditingController(text: staff.currentAddress ?? ''));
    final permanentAddressCtrl = useMemoized(() => TextEditingController(text: staff.permanentAddress ?? ''));

    // Dispose controllers when widget unmounts
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

    // Dropdown state
    final genderValue = useState<String?>(staff.gender ?? 'Female');
    final bloodGroupValue = useState<String?>(staff.bloodGroup ?? 'O+');

    // Checkbox - same as current address
    final sameAsCurrent = useState<bool>(false);

    // Declaration checkbox
    final declarationChecked = useState<bool>(staff.declare);

    // If sameAsCurrent toggled, copy current -> permanent (also keep in sync)
    useEffect(() {
      void handleSync() {
        if (sameAsCurrent.value) {
          permanentAddressCtrl.text = currentAddressCtrl.text;
        }
      }

      // initial sync if already checked
      handleSync();

      // Add listener so if current address changes while checkbox is checked, permanent updates
      currentAddressCtrl.addListener(handleSync);

      return () {
        currentAddressCtrl.removeListener(handleSync);
      };
    }, [sameAsCurrent.value]);

    // Simple responsive sizes using ScreenUtil (ensure you initialize ScreenUtil in main app)
    // Colors and styles to match screenshot
    const headerColor = Color(0xFFD01C7F); // magenta-ish top bar
    const cardBorderColor = Color(0xFFDD2E68);

    Future<void> _onSave() async {
      final form = formKey.currentState;
      if (form == null) return;
      if (!form.validate()) {
        // invalid inputs
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please correct errors before saving')),
        );
        return;
      }

      if (!declarationChecked.value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please accept the declaration to continue')),
        );
        return;
      }

      // Collect payload
      final payload = {
        'name': nameCtrl.text.trim(),
        'contact': contactCtrl.text.trim(),
        'emergencyContact': emergencyCtrl.text.trim(),
        'gender': genderValue.value,
        'bloodGroup': bloodGroupValue.value,
        'employeeId': employeeIdCtrl.text.trim(),
        'currentAddress': currentAddressCtrl.text.trim(),
        'permanentAddress': permanentAddressCtrl.text.trim(),
      };

      // Example: show loading dialog and fake API call
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      try {
        // TODO: replace this with your provider/api call
        await Future.delayed(const Duration(milliseconds: 900));

        // close loading
        if (context.mounted) Navigator.of(context).pop();

        // show success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saved successfully')),
        );

        // Optionally pop the screen
        // Navigator.of(context).pop(true);
        // Or update local state / provider
        // ref.read(yourProvider.notifier).updateStaff(payload);

      } catch (e) {
        if (context.mounted) Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Save failed: $e')),
        );
      }
    }

    // Build UI
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
                          // header
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text('Staff Id Card Details',
                          //         style: TextStyle(
                          //             fontSize: 16.sp, fontWeight: FontWeight.bold)),
                          //     IconButton(
                          //       icon: const Icon(Icons.close, color: Colors.red),
                          //       onPressed: () => Navigator.of(context).maybePop(),
                          //     )
                          //   ],
                          // ),
                          // SizedBox(height: 10.h),

                          // Grid layout: 3 columns on wide screens, stacked on small screens
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
                                // SizedBox(
                                //   width: isWide ? (constraints.maxWidth / 3) - 16 : double.infinity,
                                //   child: _buildTextField('Name', controller: nameCtrl, validator: (v) {
                                //     if (v == null || v.trim().isEmpty) return 'Enter name';
                                //     return null;
                                //   }),
                                // ),

                                // Contact
                                SizedBox(
                                  width: isWide ? (constraints.maxWidth / 3) - 16 : double.infinity,
                                  child: _buildLabel('Contact no. *'),
                                ),
                                SizedBox(
                                  width: isWide ? (constraints.maxWidth / 3) - 16 : double.infinity,
                                  child: TextFormField(
                                    controller: contactCtrl,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                                    ),
                                  ),
                                ),

                                // Emergency contact
                                SizedBox(
                                  width: isWide ? (constraints.maxWidth / 3) - 16 : double.infinity,
                                  child: _buildLabel('Emergency contact no. *'),
                                ),
                                SizedBox(
                                  width: isWide ? (constraints.maxWidth / 3) - 16 : double.infinity,
                                  child: _buildPhoneField(controller: emergencyCtrl),
                                ),

                                // Gender
                                SizedBox(
                                  width: isWide ? (constraints.maxWidth / 3) - 16 : double.infinity,
                                  child: _buildLabel('Gender *'),
                                ),
                                SizedBox(
                                  width: isWide ? (constraints.maxWidth / 3) - 16 : double.infinity,
                                  child: DropdownButtonFormField<String>(
                                    value: genderValue.value,
                                    items: ['Male', 'Female']
                                        .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                                        .toList(),
                                    onChanged: (v) => genderValue.value = v,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                                    ),
                                  ),
                                ),

                                // Blood Group
                                SizedBox(
                                  width: isWide ? (constraints.maxWidth / 3) - 16 : double.infinity,
                                  child: _buildLabel('Blood Group'),
                                ),
                                SizedBox(
                                  width: isWide ? (constraints.maxWidth / 3) - 16 : double.infinity,
                                  child: DropdownButtonFormField<String>(
                                    value: bloodGroupValue.value,
                                    items: [
                                      'A+',
                                      'A-',
                                      'B+',
                                      'B-',
                                      'O+',
                                      'O-',
                                      'AB+',
                                      'AB-'
                                    ].map((bg) => DropdownMenuItem(value: bg, child: Text(bg))).toList(),
                                    onChanged: (v) => bloodGroupValue.value = v,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                                    ),
                                  ),
                                ),

                                // Employee ID (disabled)
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

                                // Current Address full width
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
                                          sameAsCurrent.value = v ?? false;
                                          if (sameAsCurrent.value) {
                                            permanentAddressCtrl.text = currentAddressCtrl.text;
                                          }
                                        },
                                      ),
                                      const Text('Same as Current Address'),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: permanentAddressCtrl,
                                    maxLines: 3,
                                    validator: (v) {
                                      if (v == null || v.trim().isEmpty) return 'Enter permanent address';
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                                    ),
                                  ),
                                ),

                                // Declaration checkbox and Save button
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
                                      // const Spacer(),

                                    ],
                                  ),
                                ),
                                SizedBox(width: double.infinity, child: SizedBox(height: 1.h)),

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
                                          // const Spacer(),

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

  // small helpers
  Widget _buildLabel(String text) => Padding(
    padding: EdgeInsets.only(bottom: 6.h, top: 6.h),
    child: Text(text, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp)),
  );

  Widget _buildTextField(String hint, {required TextEditingController controller, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    );
  }

  Widget _buildPhoneField({required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      validator: (v) {
        if (v == null || v.trim().isEmpty) return 'Enter mobile no';
        if (v.trim().length < 6) return 'Enter valid number';
        return null;
      },
      decoration: InputDecoration(
        prefixText: '+91 ',
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    );
  }
}
