import 'package:uuid/uuid.dart';

class NetWorkInfo {
  String? id;
  String status;
  final String method;
  final String uri;
  final Map<dynamic, dynamic>? body;
  final Map<String, String?>? query;
  Map<dynamic, dynamic>? headers;
  dynamic response;
  int? statusCode;

  NetWorkInfo({
    this.status = 'PENDING',
    required this.method,
    required this.uri,
    required this.body,
    required this.query,
    this.headers,
    this.response,
    this.statusCode,
  }) {
    id = const Uuid().v4();
  }
}
