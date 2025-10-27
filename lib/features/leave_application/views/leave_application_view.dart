import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/features/home/providers/academic_year_provider.dart';
import 'package:teacherapp/features/leave_application/providers/providers.dart';

import '../models/models.dart';

class LeaveApplicationView extends HookConsumerWidget {
  final Leave? leave;
  const LeaveApplicationView({super.key, this.leave});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final leaveProvider = ref.read(leavePProvider.notifier);
    //final academicYr = ref.read(authProvider).requireValue.academicYr;
    final acdYear = ref.watch(academicYearProvider).requireValue;
    final leaveState = ref.watch(leavePProvider);
    final isSaving = useState<bool>(false);

    final rangeDate = useState<DateTimeRange?>(
      leave?.leaveStartDate != null && leave?.leaveEndDate != null
          ? DateTimeRange(
              start: DateTime.parse(leave!.leaveStartDate!),
              end: DateTime.parse(leave!.leaveEndDate!),
            )
          : null,
    );

    double calculateDaysBetween(DateTime startDate, DateTime endDate) {
      final earlier = startDate.isBefore(endDate) ? startDate : endDate;
      final later = startDate.isBefore(endDate) ? endDate : startDate;
      return (later.difference(earlier).inDays + 1).toDouble();
    }

    String transform(DateTime v) {
      return DateFormat('yyyy-MM-dd').format(v);
    }

    void onChangeRange(DateTimeRange? v) {
      formKey.currentState?.save();
      final formData = formKey.currentState?.value;
      final startEndDate = formData?['start_and_end_date'] as DateTimeRange?;
      if (startEndDate == null) return;
      final days = calculateDaysBetween(startEndDate.start, startEndDate.end);
      formKey.currentState?.fields['no_of_days']?.didChange(days.toString());
    }

    Future<void> onSaveOrUpdate() async {
      if (isSaving.value) return;
      if (formKey.currentState?.saveAndValidate() ?? false) {
        final formData = formKey.currentState!.value;
        final dripDownV = formData['leave_type_id'] as LeaveBalance;
        final startEndDate = formData['start_and_end_date'] as DateTimeRange;
        final days = calculateDaysBetween(startEndDate.start, startEndDate.end);

        if (double.parse(dripDownV.leavesAllocated ?? "0.0") > days) {
          final createBody = CreateUpdateBody.fromJson({
            ...formData,
            "start_date": transform(startEndDate.start),
            "end_date": transform(startEndDate.end),
            "leave_type_id": dripDownV.leaveTypeId,
          });

          try {
            isSaving.value = true;
            if (leave?.leaveAppId != null) {
              final withAppId =
                  createBody.copyWith(leaveAppId: leave?.leaveAppId);
              await leaveProvider.updateLeaveApplication(withAppId);
              Utils.toast("Application Updated", true);
            } else {
              await leaveProvider.createLeaveApplication(createBody);
              Utils.toast("Application Created", true);
            }

            context.pop();
          } catch (e) {
            Utils.toast("Error saving leave application: $e");
          } finally {
            if (context.mounted) {
              isSaving.value = false;
            }
          }
        } else {
          Utils.toast("You don't have enough leaves!");
        }
      }
    }

    Widget buildActionButtons() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: isSaving.value ? null : onSaveOrUpdate,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.blue, // ✅ Set your desired background color here
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: isSaving.value
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 16.w,
                        height: 16.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        leave?.leaveAppId == null ? 'Saving...' : 'Updating...',
                        style: TextStyle(fontSize: 14.sp, color: Colors.white),
                      ),
                    ],
                  )
                : Text(
                    leave?.leaveAppId == null ? 'Save' : "Update",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors
                            .white), // optional: set text color for contrast
                  ),
          ),
          ElevatedButton(
            onPressed: () => context.pop(),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              backgroundColor: Colors.grey.shade300,
            ),
            child: Text(
              'Cancel',
              style: TextStyle(fontSize: 14.sp, color: Colors.black),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text(
          '${leave?.leaveAppId != null ? "Edit" : "Create"} Leave Application ',
          style: TextStyle(fontSize: 17.sp, color: Colors.white),
        ),
        backgroundColor: Colors.pink,
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
        child: leaveState.when(
          data: (data) {
            if (data.leavesBalance.isEmpty) {
              return const Center(
                child: Text('No leave types available'),
              );
            }

            LeaveBalance? initialValue;
            if (leave?.leaveTypeId != null) {
              try {
                initialValue = data.leavesBalance.firstWhere(
                  (e) => e.leaveTypeId == leave!.leaveTypeId,
                  orElse: () => data.leavesBalance.first,
                );
              } catch (e) {
                initialValue = data.leavesBalance.first;
              }
            } else {
              initialValue = data.leavesBalance.first;
            }

            return FormBuilder(
              key: formKey,
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  child: Card(
                    margin: EdgeInsets.all(20.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFormFieldLabel('Leave Type'),
                            FormBuilderDropdown<LeaveBalance>(
                              name: 'leave_type_id',
                              initialValue: initialValue,
                              validator: FormBuilderValidators.required(),
                              hint: const Text("Select Leave Type"),
                              onChanged: (v) {
                                Utils.toast(
                                  'You have ${v?.leavesAllocated} leaves left',
                                  true,
                                );
                              },
                              decoration:
                                  _buildInputDecoration('Select Leave Type'),
                              items: data.leavesBalance
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          "${e.name} - ${double.parse(e.leavesAllocated ?? "0.0") - double.parse(e.leavesAvailed ?? "0.0")} Balance",
                                        ),
                                      ))
                                  .toList(),
                            ),
                            SizedBox(height: 15.h),
                            _buildFormFieldLabel('Start And End Date'),
                            FormBuilderDateRangePicker(
                              name: 'start_and_end_date',
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2029),
                              onChanged: onChangeRange,
                              initialValue: rangeDate.value,
                              format: DateFormat('yyyy-MM-dd'),
                              decoration:
                                  _buildInputDecoration('Start And End Date'),
                              validator: FormBuilderValidators.required(),
                            ),
                            SizedBox(height: 15.h),
                            _buildFormFieldLabel('Days'),
                            FormBuilderTextField(
                              name: 'no_of_days',
                              initialValue: leave?.noOfDays,
                              enabled: true,
                              decoration: _buildInputDecoration('Leave Days'),
                              keyboardType: TextInputType.number,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.numeric(),
                                FormBuilderValidators.min(1),
                              ]),
                            ),
                            SizedBox(height: 10.h),
                            Visibility(
                              visible: leave != null,
                              child: Wrap(
                                children: [
                                  _buildFormFieldLabel('Status'),
                                  FormBuilderTextField(
                                    name: 'status',
                                    initialValue: _statusText(leave?.status),
                                    enabled: false,
                                    decoration: _buildInputDecoration('Status'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            _buildFormFieldLabelWithoutHash(' Reason'),
                            FormBuilderTextField(
                              name: 'reason',
                              maxLines: 3,
                              initialValue: leave?.reason,
                              decoration: _buildInputDecoration('Reason'),
                              // validator: FormBuilderValidators.required(),
                            ),
                            SizedBox(height: 15.h),
                            Visibility(
                              visible: leave != null,
                              child: Wrap(
                                children: [
                                  _buildFormFieldLabel('Approvers Comment'),
                                  FormBuilderTextField(
                                    name: 'reason_for_rejection',
                                    initialValue: leave?.reasonForRejection,
                                    enabled: false,
                                    decoration: _buildInputDecoration(
                                        'Approvers Comment'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            buildActionButtons(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }

  Widget _buildFormFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Text(
        '*$label',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
      ),
    );
  }

  Widget _buildFormFieldLabelWithoutHash(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey.shade600),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
      contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
    );
  }

  String _statusText(String? status) {
    switch (status) {
      case 'A':
        return 'Applied';
      case 'P':
        return 'Approved';
      case 'H':
        return 'Hold';
      case 'R':
        return 'Rejected';
      default:
        return '';
    }
  }
}
