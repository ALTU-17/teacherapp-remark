import 'package:teacherapp/config/utils.dart';

import 'package:dio/dio.dart';

import '../models/models.dart';

class LeaveService {
  final Dio apiClient;
  final String baseUrl;
  const LeaveService(this.apiClient, this.baseUrl);

  Future<List<Leave>> fetchLeaveApplications(LeaveAppBody body) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/get_leave_applied_by_staff_info',
        // data: body
        //     .copyWith(staffId: '14', acdYr: '2024-2025')
        //     .toJson(), //TODO CHECK THIS
        data: FormData.fromMap({
          'acd_yr': body.acdYr,
          // 'acd_yr': '2024-2025', //TODO CHECK THIS !!
          'staff_id': body.staffId,
          'short_name': body.shortName,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        if (jsonResponse['status'] == true) {
          final List<dynamic> data = jsonResponse['leave_info'];
          return data.map((item) => Leave.fromJson(item)).toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load leave applications');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

// 2. Get balance leave (for leave types dropdown)

  Future<List<LeaveBalance>> getBalanceLeave(BalanceBody body) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/get_balance_leave',
        //TODO CHECK THIS
        data: FormData.fromMap({
          'acd_yr': body.acdYr,
          // 'acd_yr': '2024-2025',
          'reg_id': body.regId,
          'short_name': body.shortName,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data;

        // Add null check for the response and data
        if (jsonResponse == null || jsonResponse['balance_leave'] == null) {
          Utils.debLog('Error fetching leave balances: $jsonResponse');

          return [];
        }

        final List<dynamic> data = jsonResponse['balance_leave'];

        // Check if data is empty
        if (data.isEmpty) {
          throw Exception('No leave types allocated yet');
        }

        return data.map((item) => LeaveBalance.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load leave balance: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching leave balance: $e');
    }
  }

  // 3. Create leave application
  Future<bool> createLeaveApplication(CreateUpdateBody body) async {
    Utils.debLog(body.toJson());

    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/leave_application',
        // data: FormData.fromMap({
        //   'leave_type_id': leaveTypeId,
        //   'start_date': startDate,
        //   'end_date': endDate,
        //   'no_of_days': noOfDays,
        //   'status': 'A', // Applied
        //   'reason_rejection': '',
        //   'staff_id': '14',
        //   'acd_yr': '2024-2025',
        //   'operation': 'create',
        //   'reason': reason,
        //   'short_name': 'SACS',
        // }),
        data: FormData.fromMap((body.toJson())),
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        return jsonResponse['status'] == true;
      } else {
        throw Exception('Failed to create leave application');
      }
    } catch (e) {
      Utils.debLog(e);
      throw Exception('Error: $e');
    }
  }

  // 4. Update leave application
  Future<bool> updateLeaveApplication(CreateUpdateBody body) async {
    try {
      final response = await apiClient
          .post("$baseUrl/AdminApi/leave_application", data: body.toJson()
              // data: FormData.fromMap({
              //   'leave_app_id': leaveAppId,
              //   'leave_type_id': leaveTypeId,
              //   'start_date': startDate,
              //   'end_date': endDate,
              //   'no_of_days': noOfDays,
              //   'reason': reason,
              //   'staff_id': '14',
              //   'operation': 'edit',
              //   'status': 'A',
              //   'acd_yr': acd_yr,
              //   'short_name': shortName,
              // }),
              );

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        return jsonResponse['status'] == true;
      } else {
        throw Exception('Failed to update leave application');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // 5. Delete leave application
  Future<bool> deleteLeaveApplication(DeleteAppBody body) async {
    Utils.debLog(body.toJson());
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/leave_application',
        data: FormData.fromMap(body.toJson()),
        // data: FormData.fromMap({
        //   'leave_app_id': leaveAppId,
        //   'operation': 'delete',
        //   'short_name': shortName,
        // }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        return jsonResponse['status'] == true;
      } else {
        throw Exception('Failed to delete leave application');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
