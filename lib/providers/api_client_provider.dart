import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:teacherapp/config/utils.dart';
import '../config/config.dart';

part 'api_client_provider.g.dart';

@Riverpod(keepAlive: true)
class ApiClient extends _$ApiClient {
  @override
  Future<Dio> build() async {

    await Config.fetchDynamicEndpoint();

    final baseUrl = Config.dynamicEndpoint ?? 'https://aceventura.in/demo/evolvuUserService';

    //Live else
    // final baseUrl = Config.dynamicEndpoint ?? 'https://aceventura.in/evolvuUserService';

    final dio = Dio(BaseOptions(baseUrl: baseUrl))
      ..interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          enabled: kDebugMode,
          logPrint: (object) => Utils.debLog(object),
          filter: (options, args) {
            // Example: filter out binary data
            return !args.isResponse || !args.hasUint8ListData;
          },
        ),
      );

    // Step 4: Return configured Dio instance
    return dio;
  }
}
