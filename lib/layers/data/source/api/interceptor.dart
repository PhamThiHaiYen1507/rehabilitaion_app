import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class HeaderIntercepter extends InterceptorsWrapper {
  final String Function() getAccessToken;

  HeaderIntercepter({required this.getAccessToken});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers
        .putIfAbsent('Accept-Language', () => Intl.getCurrentLocale());

    final accessToken = getAccessToken();
    if (accessToken.isNotEmpty) {
      options.headers.putIfAbsent('Authorization', () => 'Bearer $accessToken');
    }

    super.onRequest(options, handler);
  }
}
