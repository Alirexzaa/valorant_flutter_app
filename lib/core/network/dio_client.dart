import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:new_block/core/errors/failures.dart';

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
    // اینترسپتور برای لاگ گرفتن
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => debugPrint(obj.toString()),
      ),
    );

    // ⬇️ اینترسپتور جدید برای مدیریت خطاها
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) {
          // بر اساس نوع خطا، پیام مناسب رو برمیگردونیم
          if (error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.receiveTimeout) {
            return handler.reject(
              DioException(
                requestOptions: error.requestOptions,
                error: const TimeoutFailure(),
              ),
            );
          } else if (error.type == DioExceptionType.connectionError) {
            return handler.reject(
              DioException(
                requestOptions: error.requestOptions,
                error: const NetworkFailure(),
              ),
            );
          }
          return handler.next(error); // بقیه خطاها رو رد کن
        },
      ),
    );
  }
}
