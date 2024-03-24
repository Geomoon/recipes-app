import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:recipes_app/config/env.dart';

class ApiProvider {
  static Dio? _dio;

  ApiProvider();

  static Dio get dio {
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(
          baseUrl: Env.apiUrl,
          contentType: 'application/json',
          connectTimeout: const Duration(seconds: 10),
        ),
      );

      _dio!.interceptors.add(
        LogInterceptor(
          logPrint: (object) => log(object.toString()),
        ),
      );
    }

    return _dio!;
  }
}
