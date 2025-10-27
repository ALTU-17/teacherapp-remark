import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pretty_dio_logger/src/pretty_dio_logger.dart';
import 'package:teacherapp/config/utils.dart';

import '../config/config.dart';
part 'api_client_provider.g.dart';

@Riverpod(keepAlive: true)
class ApiClient extends _$ApiClient {
  @override
  Future<Dio> build() async {
    final dio = Dio(BaseOptions(baseUrl: endPoint))
      ..interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          enabled: kDebugMode,
          logPrint: (object) => Utils.debLog(object),
          filter: (options, args) {
            //  return !options.uri.path.contains('posts');
            return !args.isResponse || !args.hasUint8ListData;
          },
        ),
      );

    return dio;
  }
}
