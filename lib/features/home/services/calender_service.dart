import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:teacherapp/config/utils.dart';

import '../models/models.dart';

class CalenderService {
  final Dio apiClient;
  final String baseUrl;
  const CalenderService(this.apiClient, this.baseUrl);
  Future<Calender?> getAllPublishedEvents(CalenderBody cal) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/get_all_published_events',
        data: FormData.fromMap(cal.toJson()),
      );
      final x = Calender.fromJson(jsonDecode(response.data));

      return x;
    } catch (e) {
      Utils.debLog(e);
      return null;
    }
  }
}
