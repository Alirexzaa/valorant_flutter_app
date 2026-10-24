import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  final Dio dio;

  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: 'https://valorant-api.com/v1',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      ) {
    // اینترسپتور برای لاگ گرفتن توی حالت دیباگ
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => debugPrint(obj.toString()),
      ),
    );
  }
}
