import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

export 'package:dio/dio.dart';

export 'basic_error_handler.dart';
export 'extension_dio_response.dart';

/// 网络请求客户端
/// 不同的项目可以在此基础上再做相应的扩展
abstract class BasicHttpClient {
  /// 默认时间设置
  static const int connectTimeout = 60000;
  static const int receiveTimeout = 60000;
  static const int sendTimeout = 60000;

  final Dio _dio = Dio(BaseOptions(
    connectTimeout: Duration(milliseconds: connectTimeout),
    receiveTimeout: Duration(milliseconds: receiveTimeout),
    sendTimeout: Duration(milliseconds: sendTimeout),
  ));

  /// 请求base url
  String _baseUrl = '';

  String get baseUrl => _baseUrl;

  /// 获取 dio 请求实例
  Dio get dio => _dio;

  /// 添加自定义拦截器
  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  /// 移除拦截器
  void removeInterceptor(Interceptor interceptor) {
    if (_dio.interceptors.contains(interceptor)) {
      _dio.interceptors.remove(interceptor);
    }
  }

  /// 添加公共请求头
  void addHeader(String key, String value) {
    Map<String, dynamic> headers = _dio.options.headers;
    headers.update(key, (old) => value, ifAbsent: () => value);
  }

  /// 移除请求头
  void removeHeader(String key) {
    Map<String, dynamic> headers = _dio.options.headers;
    if (headers.containsKey(key)) {
      headers.remove(key);
    }
  }

  /// 获取请求头
  String getHeader(String key) {
    Map<String, dynamic> headers = _dio.options.headers;
    if (headers.containsKey(key)) {
      return headers[key];
    }
    return '';
  }

  /// 设置 Transformer
  void setTransformer(Transformer transformer) {
    _dio.transformer = transformer;
  }

  /// 添加请求日志log
  void addPrettyDioLogger({
    bool requestHeader = true,
    bool requestBody = true,
    bool responseBody = true,
    bool responseHeader = false,
    bool error = true,
    bool compact = true,
    int maxWidth = 90,
  }) {
    addInterceptor(PrettyDioLogger(
      requestHeader: requestHeader,
      requestBody: requestBody,
      responseBody: responseBody,
      responseHeader: responseHeader,
      error: error,
      compact: compact,
      maxWidth: maxWidth,
    ));
  }

  /// 修改base url 即时生效
  void updateBaseUrl(String url) {
    assert(url.isNotEmpty);
    _baseUrl = url;
    _dio.options.baseUrl = _baseUrl;
  }

  /// 修改http client 公共配置
  void updateRequestOptions(BaseOptions options) {
    _dio.options = options;
  }
}
