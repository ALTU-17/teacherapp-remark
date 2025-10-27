import 'package:dio/dio.dart';
import '../models/create_chapter_request.dart';

class CreateChapterService {
  final Dio apiClient;
  final String baseUrl;
  CreateChapterService(this.apiClient, this.baseUrl);

  // Future<Map<String, dynamic>> createChapter(CreateChapterRequest req) async {
  //   final response = await apiClient.post(
  //     '${baseUrl}CurriculumApi/chapters',
  //     data: req.toJson(),
  //   );
  //   if (response.statusCode == 200) {
  //     return response.data as Map<String, dynamic>;
  //   }
  //   throw Exception("Failed to create chapter");
  // }
}