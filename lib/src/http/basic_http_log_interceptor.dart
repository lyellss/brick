import 'dart:convert';
import 'dart:developer';

import 'package:brick/src/common/time_task.dart';
import 'package:brick/src/http/http.dart';
import 'package:flutter/foundation.dart';

const _tag = 'KkHttpLogInterceptor';

/// 简易 log 拦截器
class BasicHttpLogInterceptor extends Interceptor {
  BasicHttpLogInterceptor();

  final TimeWatcher _timeWatcher = TimeWatcher();

  /// 剔除某些log不显示
  bool exclude(String requestPath) {
    return false;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _timeWatcher.start();
    if (exclude(options.path)) {
      handler.next(options);
      return;
    }
    handler.next(options);
    debugPrint('$_tag onRequest:');
    if (options.data is Map) {
      logMap(options.data);
    } else {
      logString(options.data);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Duration time = _timeWatcher.stop();
    debugPrint(
        '$_tag onResponse: consume time ${time.inMilliseconds} milliseconds');
    if (exclude(response.requestOptions.path)) {
      handler.next(response);
      return;
    }
    handler.next(response);
    if (response.requestOptions.responseType == ResponseType.bytes) {
      return;
    }
    debugPrint('$_tag onResponse:');
    if (response.data is Map) {
      logMap(response.data);
    } else {
      logString(response.data);
    }
  }

  void logString(dynamic msg) {
    if (msg is String?) {
      log(msg ?? '');
    } else {
      log(msg.toString());
    }
  }

  void logMap(Map? map) {
    if (map != null) {
      log(jsonEncode(map));
    } else {
      log('');
    }
  }
}
