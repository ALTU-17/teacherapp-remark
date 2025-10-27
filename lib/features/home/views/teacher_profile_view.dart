import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teacherapp/common/customDropDown.dart';
import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/features/auth/models/teacher_user.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:teacherapp/router/routers.dart';
import '../../auth/auth.dart';

class TeacherProfileView extends HookConsumerWidget {
  const TeacherProfileView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider).requireValue;
    final authP = ref.read(authProvider.notifier);
    final key = useTextFieldGlobalKey();
    final image = useState<XFile?>(null);

    final List<String> qualifications = [
      'HSc',
      'DCE',
      'B.A',
      'B.Com',
      'B.Sc',
      'BCS',
      'BCA',
      'B.LIS',
      'BPharm',
      'BE',
      'B.Music n Dance',
      'M.A',
      'MSE',
      'M.Com',
      'M.Sc',
      'MCA',
      'M.LIS',
      'M.Phil',
      'MBA',
      'PGDBM'
    ];

    final List<String> profSubjects = [
      'D.Ed',
      'B.Ed',
      'M.Ed',
      'TTC',
      'B.P.Ed',
      'M.P.Ed',
      'Others'
    ];
    final List<String> trainingStatuses = [
      'Trained-PGT',
      'Trained-TGT',
      'Trained-PRT',
      'NTT',
      'ECCE',
      'Untrained',
      'NA'
    ];
    final List<String> genderOptions = ['male', 'female'];
    final List<String> bloodGroups = [
      'AB+',
      'AB−',
      'B+',
      'B−',
      'A+',
      'A−',
      'O+',
      'O−'
    ];

    onUpdate() async {
      if (key.currentState?.saveAndValidate() ?? false) {
        final selectedQuals =
            key.currentState?.value['academic_qualification'] as List<String>?;
        if (selectedQuals == null) return;

        final x = TeacherDetails.fromJson({
          ...key.currentState!.value,
          'str_array': selectedQuals.join(","),
        });

        Utils.debLog(x);
        final result = await authP.profileUpdate(x);
        if (result != null) {
          context.go(DashboardRoute().location);
        }
      } else {
        Utils.toast("Please fill all required fields.");
      }
    }

    Widget buildProfilePicture() {
      final imageName = auth.teacherDetails?.teacherImageName;
      final url = '${auth.teacherVerification?.projectUrl}uploads/teacher_image/$imageName';

      onImagePick() async {
        try {
          final picker = ImagePicker();
          final XFile? pickedFile = await picker.pickImage(
            source: ImageSource.gallery,
          );

          if (pickedFile == null) return;

          // Simple approach without cropping first
          image.value = pickedFile;
          await authP.profileImageUpload(File(pickedFile.path));

        } catch (e) {
          print('Image pick error: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to pick image')),
          );
        }
      }

      return Center(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 70.r,
              backgroundImage: image.value != null
                  ? FileImage(File(image.value!.path))
                  : NetworkImage(url) as ImageProvider,
            ),
            InkWell(
              onTap: onImagePick,
              child: CircleAvatar(
                radius: 18.r,
                backgroundColor: Colors.grey.shade300,
                child: const Icon(Icons.add, color: Colors.black),
              ),
            ),
          ],
        ),
      );
    }

    Widget buildQualificationsSection() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  const TextSpan(text: 'Academic Qualification'),
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red, fontSize: 14.sp),
                  ),
                ],
              ),
            ),
          ),
          FormBuilderFilterChips<String>(
            name: 'academic_qualification',
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              errorStyle: TextStyle(fontSize: 11.sp, color: Colors.red),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Academic Qualification is required';
              }
              return null;
            },
            options: qualifications
                .map(
                  (item) => FormBuilderChipOption(
                    value: item,
                    child: Text(item, style: TextStyle(fontSize: 12.sp)),
                  ),
                )
                .toList(),
            initialValue: auth.teacherDetails?.academicQual
                    ?.split(',')
                    .map((e) => e.trim())
                    .toList() ??
                [],
            selectedColor: Colors.blue.shade100,
            spacing: 5.w,
            runSpacing: 1.h,
            alignment: WrapAlignment.start,
            checkmarkColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
              side: BorderSide(color: Colors.grey.shade400),
            ),
          ),
          SizedBox(height: 10.h),
        ],
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFCB0D4C), Color(0xFF5094CB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 130, bottom: 15),
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, blurRadius: 10, spreadRadius: 2),
              ],
            ),
            child: SingleChildScrollView(
              child: FormBuilder(
                key: key,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildProfilePicture(),
                    SizedBox(height: 30.h),
                    _buildRowField('Staff\'s Name',
                        auth.teacherDetails?.name ?? '', 'name',
                        isRequired: true),
                    _buildRowField('Date of Birth',
                        auth.teacherDetails?.birthday ?? '', "birthday",
                        isRequired: true, readOnly: true),
                    _buildRowField(
                        'Date of Joining',
                        auth.teacherDetails?.dateOfJoining ?? '',
                        "date_of_joining",
                        isRequired: true,
                        readOnly: true),
                    _buildRowField('Designation',
                        auth.teacherDetails?.designation ?? '', "designation"),
                    buildQualificationsSection(),
                    CustomDropdownField(
                      label: 'Professional Qualification',
                      options: profSubjects,
                      initialValue: auth.teacherDetails?.professionalQual ?? '',
                      name: 'professional_qual',
                    ),
                    _buildRowField('Subject for D.Ed/B.Ed',
                        auth.teacherDetails?.specialSub ?? '', 'special_sub'),
                    CustomDropdownField(
                      label: 'Training Status',
                      options: trainingStatuses,
                      isRequired: true,
                      initialValue: auth.teacherDetails?.trained ?? '',
                      name: 'trained',
                    ),
                    _buildRowField('Experience',
                        auth.teacherDetails?.experience ?? '', "experience",
                        isRequired: true),
                    CustomDropdownField(
                      label: 'Gender',
                      options: genderOptions,
                      isRequired: true,
                      initialValue: auth.teacherDetails?.sex ?? '',
                      name: 'sex',
                    ),
                    CustomDropdownField(
                      label: 'Blood Group',
                      options: bloodGroups,
                      initialValue: auth.teacherDetails?.bloodGroup ?? '',
                      name: 'blood_group',
                    ),
                    _buildRowField('Religion',
                        auth.teacherDetails?.religion ?? '', "religion"),
                    _buildRowField('Address',
                        auth.teacherDetails?.address ?? '', "address",
                        isRequired: true),
                    _buildRowField(
                      'Mobile Number',
                      auth.teacherDetails?.phone ?? '',
                      "phone",
                      isRequired: true,
                      isNumeric: true,
                    ),
                    _buildRowField(
                      'Aadhar Card No.',
                      auth.teacherDetails?.aadharCardNo ?? '',
                      "aadhar_card_no",
                      isNumeric: true,
                    ),
                    _buildRowField(
                        'Email ID', auth.teacherDetails?.email ?? '', "email"),
                    SizedBox(height: 10.h),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 12.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r)),
                          backgroundColor: const Color(0xFF4E9DDE),
                        ),
                        onPressed: onUpdate,
                        child: Text(
                          'Update',
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRowField(
    String label,
    String value,
    String name, {
    bool isRequired = false,
    bool readOnly = false,
    bool isNumeric = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 130.w,
            child: RichText(
              text: TextSpan(
                text: label,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.5.sp,
                    color: Colors.black),
                children: isRequired
                    ? [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(color: Colors.red, fontSize: 14.sp),
                        )
                      ]
                    : [],
              ),
            ),
          ),
          Expanded(
            child: FormBuilderTextField(
              initialValue: value,
              readOnly: readOnly,
              name: name,
              keyboardType: isNumeric ? TextInputType.number : null,
              inputFormatters:
                  isNumeric ? [FilteringTextInputFormatter.digitsOnly] : null,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r)),
              ),
              style: TextStyle(fontSize: 12.sp),
              validator: FormBuilderValidators.compose([
                if (isRequired)
                  FormBuilderValidators.required(
                      errorText: 'This field is mandatory'),
                if (isNumeric && name == 'phone')
                  FormBuilderValidators.equalLength(10,
                      errorText: 'Enter a valid 10-digit mobile number'),
                if (isNumeric && name == 'aadhar_card_no')
                  FormBuilderValidators.equalLength(12,
                      errorText: 'Aadhaar must be 12 digits'),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
