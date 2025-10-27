
import 'package:dio/dio.dart';
import 'package:teacherapp/config/utils.dart';

import '../models/models.dart';

class AcademicYearService {
  final Dio apiClient;
  final String baseUrl;
  const AcademicYearService(this.apiClient, this.baseUrl);

  Future<List<AcdYear>> getAllAcademicYears(String shortName) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/get_academic_years_list',
        data: FormData.fromMap({"short_name": shortName}),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['academic_yr_list'];
        return data.map((item) => AcdYear.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load leave applications');
      }
    } catch (e) {
      Utils.debLog(e);
      return [];
    }
  }
}
