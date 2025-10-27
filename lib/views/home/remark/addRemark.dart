import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teacherapp/views/home/remark/provider/remark_provider.dart';
import 'package:tuple/tuple.dart';
import 'package:file_picker/file_picker.dart';
import '../../../features/auth/providers/auth_provider.dart';
import 'model/ClassSubStudentModel.dart';
import 'model/create_remark_body.dart';

class AddRemark extends HookConsumerWidget {
  const AddRemark({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    final showAttachment = useState(true);
    final deleteimagelist = useState<List<String>>([]);
    final _dateController = useTextEditingController(
        text: "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}");
    final pickedFiles = useState<List<PlatformFile>>([]);
    final uploading = useState<bool>(false);
    final uploadedFiles = useState<List<String>>([]);
    final selectedClassSection = useValueNotifier<ClassSection?>(null);
    final selectedSubject = useValueNotifier<Subject?>(null);
    final selectedStudents = useValueNotifier<List<Student>>([]);
    final remarkType = useState<String>('Remark');
    final selectedClassSectionValue = useValueListenable(selectedClassSection);
    final selectedSubjectValue = useValueListenable(selectedSubject);
    final _subjectOfRemarkController = useTextEditingController();
    final _remarkController = useTextEditingController();
    final classSectionsAsync = ref.watch(classSectionProvider);

    final subjectAsync = selectedClassSection.value == null
        ? const AsyncValue<List<Subject>>.data([])
        : ref.watch(subjectProvider(
      Tuple2(selectedClassSection.value!.classId, selectedClassSection.value!.sectionId),
    ));

    final studentsAsync =
    (selectedClassSectionValue == null)
        ? const AsyncValue<List<Student>>.data([])
        : ref.watch(studentProvider(
      Tuple2(selectedClassSectionValue.classId, selectedClassSectionValue.sectionId),
    ));

    void _resetForm() {
      selectedClassSection.value = null;
      selectedSubject.value = null;
      selectedStudents.value = [];
      _dateController.clear();
      _subjectOfRemarkController.clear();
      _remarkController.clear();
      pickedFiles.value = [];
      uploadedFiles.value = [];
      deleteimagelist.value = [];
    }



    Future<void> _uploadFiles() async {
      uploading.value = true;
      final remarkService = ref.read(remarkServiceProvider);

      for (final f in pickedFiles.value) {
        final success = await remarkService.uploadRemarkDocument(
          studentIds: json.encode(selectedStudents.value.map((e) => e.studentId).toList()),
          shortName: ref.read(authProvider).requireValue.teacherVerification?.shortName ?? "",
          filename: f.name,
          fileBytes: f.bytes!,
          uploadDate: _dateController.text,
        );

        if (success) {
          uploadedFiles.value = [...uploadedFiles.value, f.name];
        } else {
          _showSnack(context, "Failed to upload ${f.name}");
        }
      }

      pickedFiles.value = [];
      uploading.value = false;
    }

    Future<void> _pickFiles() async {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        withData: true,
        type: FileType.any,
      );
      if (result != null && result.files.isNotEmpty) {
        pickedFiles.value = result.files;
        // Auto-upload files after selection - REMOVE the manual attach button
        await _uploadFiles();
      }
    }

    void _handleAttachment(BuildContext context) {
      if (selectedClassSection.value == null) {
        _showSnack(context, "Please select class/section");
        return;
      }
      // if (selectedSubject.value == null) {
      //   _showSnack(context, "Please select subject");
      //   return;
      // }
      if (selectedStudents.value.isEmpty) {
        _showSnack(context, "Please select at least one student");
        return;
      }
      _pickFiles();
    }


    Future<void> _deleteFile(String filename) async {
      final remarkService = ref.read(remarkServiceProvider);
      final success = await remarkService.NdeleteRemarkDocument(
        upload_date: _dateController.text,
        student_id: json.encode(selectedStudents.value.map((e) => e.studentId).toList()),
        shortName: ref.read(authProvider).requireValue.teacherVerification?.shortName ?? "",
        filename: filename,
      );

      if (success) {
        uploadedFiles.value = uploadedFiles.value.where((f) => f != filename).toList();
        _showSnack(context, "Deleted $filename");
      } else {
        _showSnack(context, "Failed to delete $filename");
      }
    }

    Future<void> _saveRemark() async {
      if (!_formKey.currentState!.validate()) return;
      if (selectedClassSection.value == null) {
        _showSnack(context, "Please select a class/section");
        return;
      }
      // if (selectedSubject.value == null) {
      //   _showSnack(context, "Please select a subject");
      //   return;
      // }
      if (selectedStudents.value.isEmpty) {
        _showSnack(context, "Please select at least one student");
        return;
      }
      uploading.value = true;

      final auth = ref.read(authProvider).requireValue;
      final remarkService = ref.read(remarkServiceProvider);

      final smId = selectedSubject.value?.smId ?? '';
      final subjectId = smId.isEmpty ? '0' : smId;

      final remarkBody = CreateRemarkBody(
        app_version: '1.70',
        academicYr: auth.academicYr ?? "",
        teacherId: auth.regId ?? "",
        sectionId: selectedClassSection.value!.sectionId,
        classId: selectedClassSection.value!.classId,
        subjectId: subjectId, // <- use normalized value
        fileName: json.encode(uploadedFiles.value),
        studentIds: json.encode(selectedStudents.value.map((e) => e.studentId).toList()),
        remarkDesc: _remarkController.text,
        remarkSubject: _subjectOfRemarkController.text,
        remarkDate: _dateController.text,
        shortName: auth.teacherVerification?.shortName ?? "",
        remarkType: remarkType.value,
        files: pickedFiles.value,
        deleteimagelist: deleteimagelist.value,
      );

      final res = await remarkService.NcreateRemark(remarkBody);

      if (res['status'] == true) {
        uploading.value = false;

        _showSnack(context, res['success_msg'] ?? "Remark saved!");
        Navigator.pop(context, true);
      } else {
        uploading.value = false;

        _showSnack(context, res['error_msg'] ?? 'Failed to save remark');
      }
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40.h,
        title: const Text("Create Remark", style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: const Color.fromARGB(255, 208, 28, 127),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 160.h),
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Class/Section Dropdown
                    const Text("*Class/Section", style: TextStyle(fontWeight: FontWeight.bold)),
                    classSectionsAsync.when(
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (err, _) => Text('Error: $err'),
                      data: (classSections) => // --- Class/Section Dropdown
                      DropdownButtonFormField<ClassSection>(
                        value: selectedClassSection.value,
                        hint: const Text("Select Class/Section"),
                        isExpanded: true,
                        items: classSections.map((cs) => DropdownMenuItem(
                          value: cs,
                          child: Text("${cs.className} ${cs.sectionName}"),
                        )).toList(),
                        onChanged: (cls) {
                          selectedClassSection.value = cls;
                          selectedSubject.value = null;
                          selectedStudents.value = [];
                        },
                        validator: (val) => val == null ? "Please select a class/section" : null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                          contentPadding: EdgeInsets.all(10.w),
                        ),
                      ),

                    ),
                    SizedBox(height: 20.h),

                    // Subject Dropdown
                    const Text("Subject", style: TextStyle(fontWeight: FontWeight.bold)),
                    subjectAsync.when(
                      loading: () => const LinearProgressIndicator(),
                      error: (err, _) => Text('Error: $err'),
                      data: (subjects) {
                        if (selectedClassSection.value == null) {
                          return const Text("Please select class/section first",
                              style: TextStyle(fontSize: 14, color: Colors.grey));
                        }
                        return DropdownButtonFormField<Subject>(
                          value: selectedSubject.value,
                          hint: const Text("Select Subject"),
                          isExpanded: true,
                          items: subjects.map((subject) =>
                              DropdownMenuItem(value: subject, child: Text(subject.name ?? ""))
                          ).toList(),
                          onChanged: (val) {
                            selectedSubject.value = val;
                            selectedStudents.value = [];
                          },
                          // validator: (val) => val == null ? "Please select a subject" : null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10.h),

                    // Students Picker
                    const Text("*Student", style: TextStyle(fontWeight: FontWeight.bold)),
                    studentsAsync.when(
                      loading: () => const LinearProgressIndicator(),
                      error: (err, _) => Text('Error: $err'),
                      data: (students) {
                        if (selectedClassSection.value == null) {
                          return const Text("Please select class/section first",
                              style: TextStyle(fontSize: 14, color: Colors.grey));
                        }
                        // if (selectedSubject.value == null) {
                        //   return const Text("Please select subject first",
                        //       style: TextStyle(fontSize: 14, color: Colors.grey));
                        // }

                        return ValueListenableBuilder<List<Student>>(
                          valueListenable: selectedStudents,
                          builder: (_, selected, __) {
                            return GestureDetector(
                              onTap: () async {
                                final result = await showModalBottomSheet<List<Student>>(
                                  context: context,
                                  builder: (_) => _StudentsPicker(
                                    students: students,
                                    selected: selected,
                                  ),
                                );
                                if (result != null) {
                                  selectedStudents.value = result;
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  selected.isEmpty
                                      ? "Select students"
                                      : selected.length == 1
                                      ? "${selected.first.firstName} ${selected.first.lastName}"
                                      : "${selected.length} students selected",
                                  style: const TextStyle(fontSize: 14, color: Colors.black),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),

                    SizedBox(height: 10.h),

                    // Subject of Remark
                    const Text("*Subject of Remark", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFormField(
                      controller: _subjectOfRemarkController,
                      maxLines: 3,
                      validator: (val) => val == null || val.isEmpty ? "Subject of remark is required" : null,
                      decoration: InputDecoration(
                        hintText: "Type here...",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // Remark
                    const Text("*Remark", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFormField(
                      controller: _remarkController,
                      maxLines: 3,
                      validator: (val) => val == null || val.isEmpty ? "Remark is required" : null,
                      decoration: InputDecoration(
                        hintText: "Type here...",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                      ),
                    ),
                    SizedBox(height: 5.h),

                    Row(
                      children: [
                        Checkbox(
                          value: remarkType.value == 'Observation',
                          onChanged: (val) {
                            remarkType.value = val == true ? 'Observation' : 'Remark';
                            print('Remark type changed to: ${remarkType.value}'); // Debug
                          },
                        ),
                        const Text(' Observation \n(will not be shown to parents!)'),
                      ],
                    ),

                    // Row(
                    //   children: [
                    //     const Text("(Observation will not be shown to parents !)"),
                    //
                    //   ],
                    // ),

                    if (remarkType.value == 'Remark') ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Attach Document", style: TextStyle(fontWeight: FontWeight.bold)),
                          uploading.value
                              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                              : IconButton(
                            icon: const Icon(Icons.attach_file, color: Colors.blue),
                            onPressed: uploading.value ? null : () => _handleAttachment(context),
                          ),

                          // if (pickedFiles.value.isNotEmpty && !uploading.value)
                          //   ElevatedButton.icon(
                          //     icon: const Icon(Icons.cloud_upload, size: 16),
                          //     label: const Text("Attach"),
                          //     style: ElevatedButton.styleFrom(
                          //       backgroundColor: Colors.blue,
                          //       foregroundColor: Colors.white,
                          //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          //     ),
                          //     onPressed: _uploadFiles,
                          //   ),
                        ],
                      ),
                      if (pickedFiles.value.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 2, bottom: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: pickedFiles.value.map((f) =>
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.insert_drive_file, size: 18, color: Colors.grey),
                                    SizedBox(width: 5),
                                    Expanded(child: Text(f.name, style: TextStyle(fontSize: 13))),
                                  ],
                                )).toList(),
                          ),
                        ),
                      if (uploadedFiles.value.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: uploadedFiles.value.map((filename) => Row(
                              children: [
                                Icon(Icons.attach_file, size: 17, color: Colors.blue),
                                Expanded(child: Text(filename, style: TextStyle(fontSize: 13))),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red, size: 18),
                                  onPressed: () => _deleteFile(filename),
                                  tooltip: "Delete",
                                ),
                              ],
                            )).toList(),
                          ),
                        ),
                    ],

                    SizedBox(height: 20.h),

                    // Save & Reset Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 78, 157, 222),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.r),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
                            ),
                            onPressed: _saveRemark,
                            icon: const Icon(Icons.save, size: 16, color: Colors.white),
                            label: const Text("Save", style: TextStyle(color: Colors.white, fontSize: 14)),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.r),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
                            ),
                            onPressed: _resetForm,
                            icon: const Icon(Icons.refresh, size: 16, color: Colors.black),
                            label: const Text("Reset", style: TextStyle(color: Colors.black, fontSize: 14)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _showSnack(BuildContext ctx, String msg) =>
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(msg)));

// _StudentsPicker class remains the same as in your original code
class _StudentsPicker extends StatefulWidget {
  final List<Student> students;
  final List<Student> selected;
  const _StudentsPicker({required this.students, required this.selected});
  @override
  State<_StudentsPicker> createState() => _StudentsPickerState();
}

class _StudentsPickerState extends State<_StudentsPicker> {
  late List<Student> selectedLocal;

  @override
  void initState() {
    super.initState();
    selectedLocal = List.of(widget.selected);
  }

  bool get _allSelected =>
      widget.students.isNotEmpty &&
          selectedLocal.length == widget.students.length;

  void _toggleSelectAll(bool? checked) {
    setState(() {
      if (checked == true) {
        selectedLocal = List.of(widget.students);
      } else {
        selectedLocal.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text("Select Students", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          CheckboxListTile(
            value: _allSelected,
            title: const Text('Select All Students', style: TextStyle(fontWeight: FontWeight.bold)),
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: _toggleSelectAll,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.students.length,
              itemBuilder: (_, index) {
                final student = widget.students[index];
                final isSelected = selectedLocal.any((s) => s.studentId == student.studentId);
                return CheckboxListTile(
                  value: isSelected,
                  title: Text("${student.firstName} ${student.lastName}"),
                  onChanged: (bool? checked) {
                    setState(() {
                      if (checked == true) {
                        selectedLocal.add(student);
                      } else {
                        selectedLocal.removeWhere((s) => s.studentId == student.studentId);
                      }
                    });
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, selectedLocal),
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }
}