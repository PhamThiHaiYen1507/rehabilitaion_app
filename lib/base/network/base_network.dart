// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:io';

import 'package:commons/app_logger/app_logger.dart';
import 'package:commons/commons.dart' hide Response;
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:finplus/base/app_config/app_config.dart';
import 'package:finplus/base/network/app_connection.dart';
import 'package:finplus/utils/app_logger.dart';
import 'package:flutter/foundation.dart';

const int _maxRetry = 10;

enum METHOD { GET, POST, PUT, DELETE }

class _Dio {
  late final Dio instance;
  static final _Dio _singleton = _Dio._internal();

  factory _Dio() {
    return _singleton;
  }

  _Dio._internal() {
    instance = Dio();
    (instance.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        _onHttpClientCreate;
  }

  static HttpClient? _onHttpClientCreate(HttpClient dioClient) {
    dioClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return dioClient;
  }
}

class ApiRequest extends ExtendModel {
  final String path;
  final METHOD method;
  final Map<String, String?>? query;
  final Map<String, dynamic>? body;
  late final Map<String, String>? headers;
  final bool auth;

  ApiRequest({
    required this.path,
    required this.method,
    this.query,
    this.body,
    required this.auth,
    this.headers,
  });

  @override
  Map<dynamic, dynamic> toJson() {
    return {
      'method': method.name,
      'path': path,
      'query': query,
      'body': body,
      'extraHeaders': headers,
    };
  }
}

class ApiResponse<T> extends ExtendModel {
  final ApiRequest request;
  final dynamic body;
  final List<T> items;
  final int? statusCode;
  final dynamic undecodeData;
  final Uri realUri;

  ApiResponse({
    required this.request,
    required this.body,
    required this.statusCode,
    this.undecodeData,
    required this.realUri,
    this.items = const [],
  });

  @override
  Map<dynamic, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'realUrl': realUri.toString(),
      'request': request.toJson(),
      'response': {'body': undecodeData}.prettyJson,
    };
  }

  bool get success {
    if (statusCode != 200) {
      logW(toJson());
    }
    return statusCode == 200;
  }

  bool get error => !success;

  // void showNotification() {
  //   Utils.showNotification(undecodeData is Map ? undecodeData['code'] : null);
  // }
}

abstract class BaseNetWork {
  final _Dio _dio;

  final String? baseUrl;

  final bool? secure;

  int get maxRetry => _maxRetry;

  Duration get retryDelay => const Duration(seconds: 3);

  BaseNetWork({this.baseUrl, this.secure}) : _dio = _Dio() {
    _dio.instance.interceptors.add(_auththenticationInterceptor);
  }

  Future<ApiResponse<R>> sendRequest<R>(ApiRequest request,
      {R Function(Map)? decoder,
      final String? baseUrl,
      dynamic Function(dynamic body)? decodeField}) async {
    dynamic undecodeData;
    int? statusCode;
    try {
      final uri = getUri(baseUrl ?? this.baseUrl ?? AppConfig.info.baseUrl,
          request.path, request.query, secure ?? AppConfig.info.secure);

      NetWorkInfo? info;

      if (AppConfig.info.env == ENV.DEV ||
          (AppConfig.info.env == ENV.PROD && kDebugMode)) {
        info = NetWorkInfo(
          method: request.method.name,
          uri: uri.toString(),
          body: request.body,
          query: request.query,
        );

        AppLogger.addRequest(info);
      }

      final data = await _dio.instance.request(
        uri.toString(),
        data: request.body,
        options: Options(
          method: request.method.name,
          headers: request.headers,
          extra: {
            'auth': request.auth,
            'disableRetry': request.method != METHOD.GET
          },
          sendTimeout: const Duration(milliseconds: 3000),
          receiveTimeout: const Duration(milliseconds: 3000),
        ),
      );

      undecodeData = data.data;
      statusCode = data.statusCode;

      if ((AppConfig.info.env == ENV.DEV ||
              (AppConfig.info.env == ENV.PROD && kDebugMode)) &&
          info != null) {
        info.response = undecodeData;
        info.statusCode = statusCode;
        info.headers = data.requestOptions.headers;

        AppLogger.addRequest(info);
      }

      final dynamic body;
      final List<R> items = [];

      if (decoder != null) {
        final bodyData = decodeField?.call(data.data) ??
            this.decodeField(data.data) ??
            data.data;

        if (bodyData is List) {
          body = bodyData;
          items.addAll(bodyData.map((e) => decoder(e)));
        } else {
          body = decoder(bodyData);
        }
      } else {
        body = data.data;
      }
      return ApiResponse<R>(
        statusCode: data.statusCode,
        body: body,
        undecodeData: undecodeData,
        request: request,
        realUri: data.realUri,
        items: items,
      );
    } catch (e, stackTrace) {
      final uri = getUri(
        baseUrl ?? AppConfig.info.baseUrl,
        request.path,
        request.query,
        secure ?? AppConfig.info.secure,
      );
      logE(e, stackTrace);
      return ApiResponse(
        request: request,
        body: undecodeData,
        undecodeData: undecodeData,
        statusCode: statusCode,
        realUri: uri,
      );
    }
  }

  QueuedInterceptorsWrapper get _auththenticationInterceptor {
    return QueuedInterceptorsWrapper(
      onRequest: (options, handler) {
        if (options.extra['auth'] == true) {
          options.headers['Authorization'] = _accessToken;
        }
        handler.next(options);
      },
      onResponse: (e, handler) {
        handler.next(e);
      },
      onError: (e, handler) async {
        final bool disableRetry =
            e.requestOptions.extra['disableRetry'] == true;

        if (_checkNeedRetry(e)) {
          if (disableRetry) {
            handler.next(e);
            return;
          }
          final id = const Uuid().v4();

          AppConnection.addListener((hasConnect) async {
            if (hasConnect) {
              final res = await _handleRetry(e.requestOptions);
              if (res != null) {
                handler.resolve(res);
              } else {
                handler.next(e);
              }

              AppConnection.removeListener(id);
            }
          }, id);
        } else {
          if (e.response != null) {
            if (e.response?.statusCode == 401) {
              handler.resolve(e.response!);
            } else {
              int retryCount = 0;

              Response res = e.response!;

              if (disableRetry ||
                  !['INTERNAL_SERVER_ERROR', 'TIMEOUT', 'TIMEOUT_ERROR']
                      .contains(res.data['code'])) {
                handler.resolve(res);
                return;
              }
              while (retryCount < maxRetry) {
                await Future.delayed(retryDelay);
                if (kDebugMode) {
                  print('retry: ${e.requestOptions.uri.toString()}');
                }

                final nextData = await _handleRetry(e.requestOptions);

                if (nextData != null) {
                  res = nextData;
                }
                if (res.statusCode == 200) {
                  return;
                } else {
                  retryCount++;
                }
              }
              handler.resolve(res);
            }
          } else {
            handler.next(e);
          }
        }
      },
    );
  }

  String? get _accessToken {
    return null;
  }

  bool _checkNeedRetry(DioError e) {
    return e.type == DioErrorType.unknown && !AppConnection.hasConnection;
  }

  Future<Response?> _handleRetry(RequestOptions requestOptions) async {
    try {
      final Dio dio = Dio();
      final res = await dio.fetch(requestOptions);

      return res;
    } catch (e) {
      return null;
    }
  }

  dynamic decodeField(dynamic body) => null;
}
