import 'package:dio/dio.dart';

/// 请求异常处理
abstract class HttpErrorHandler {
  /// dio 异常处理
  void resolveError(DioException dioException);
}
