import 'basic_http_client.dart';
import 'http_status_code.dart';

extension ExtensionDioResponse on Response {
  bool get isCode200 => kStatusCode200 == statusCode;
}
