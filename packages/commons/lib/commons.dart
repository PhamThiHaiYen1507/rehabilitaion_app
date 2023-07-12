library commons;

import 'dart:convert' as j;

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'models/custom_printer.dart';
// ignore: depend_on_referenced_packages
import 'package:logger/logger.dart';

export 'package:get/get.dart';
export 'loading_overlay/loading_overlay.dart';
export 'storage/storage.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:uuid/uuid.dart';
export 'package:logger_flutter/logger_flutter.dart';
export 'package:collection/collection.dart';
export 'package:commons/app_logger/models/network_info.dart';
export 'package:hive/hive.dart';
export 'package:commons/custom_tooltip/custom_tooltip.dart';
export 'package:intl/intl.dart';

abstract class ExtendModel {
  Map toJson();
}

class _CustomFilter extends LogFilter {
  final bool allowPrint;

  _CustomFilter(this.allowPrint);
  @override
  bool shouldLog(LogEvent event) {
    return allowPrint;
  }
}

abstract class AppLoggerDefine {
  final bool allowPrint;
  late final Logger _logger;
  AppLoggerDefine(this.allowPrint) {
    _logger = Logger(
        printer: CustomPrinter(
          printTime: true,
          methodCount: 8,
        ),
        filter: _CustomFilter(allowPrint));
  }

  void logD(dynamic message) {
    _log(Level.debug, message);
  }

  void logW(dynamic message) {
    _log(Level.warning, message);
  }

  void logE(dynamic message, [StackTrace? stackTrace]) {
    _log(Level.error, message, null, stackTrace);
  }

  void _log(Level level, dynamic message,
      [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      if (message is List) {
        _logger.log(
            level,
            message
                .map((e) => e is Map
                    ? e.prettyJson
                    : e is ExtendModel
                        ? e.toJson()
                        : e)
                .toList(),
            error,
            stackTrace);
      } else if (message is Map) {
        final json = {};
        message.forEach((key, value) {
          json[key] = value is ExtendModel ? value.toJson() : value;
        });
        _logger.log(level, json.prettyJson, error, stackTrace);
      } else if (message is Iterable<Map>) {
        _logger.log(level, message.map((e) => e.prettyJson).toList(), error,
            stackTrace);
      } else if (message is ExtendModel) {
        _logger.log(level, message.toJson().prettyJson, error, stackTrace);
      } else {
        _logger.log(level, message, error, stackTrace);
      }
    }
  }
}

Uri getUri(String baseUrl, String path, Map<String, String?>? query,
    [bool secure = true]) {
  if (secure) {
    return Uri.https(baseUrl, path, query);
  } else {
    return Uri.http(baseUrl, path, query);
  }
}

class Commons {
  static Map<K, V> validateNull<K, V>(Map<K, V> value) {
    value.removeWhere((key, value) {
      return key == null ||
          value == null ||
          value == 'null' ||
          value == '' ||
          value is Map && value.isEmpty ||
          value is List && value.isEmpty;
    });
    return value;
  }

  static DateTime formatStringToDate(String? time, [String? format]) {
    final inputFormat = DateFormat(format ?? 'dd/MM/yyyy');
    if (time != null) {
      return inputFormat.parse(time);
    } else {
      return DateTime.now();
    }
  }

  static String formatDateToDisplay(DateTime? time, [String? outputFormat]) {
    final output = DateFormat(outputFormat ?? 'dd/MM/yyyy');
    if (time == null) return '';
    return output.format(time);
  }

  static String getTimeDifferenceFromNow(DateTime date) {
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if (difference.inSeconds < 5) {
      return 'Vừa xong';
    } else if (difference.inSeconds < 60) {
      return '${difference.inSeconds} giây trước';
    } else if (difference.inMinutes <= 1) {
      return '1 phút trước';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inHours <= 1) {
      return '1 giờ trước';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inDays <= 1) {
      return '1 ngày trước';
    } else if (difference.inDays < 6) {
      return '${difference.inDays} ngày trước';
    } else if ((difference.inDays / 7).ceil() <= 1) {
      return '1 tuần trước';
    } else if ((difference.inDays / 7).ceil() < 4) {
      return '${(difference.inDays / 7).ceil()} tuần trước';
    } else if ((difference.inDays / 30).ceil() <= 1) {
      return '1 tháng trước';
    } else if ((difference.inDays / 30).ceil() < 30) {
      return '${(difference.inDays / 30).ceil()} tháng trước';
    } else if ((difference.inDays / 365).ceil() <= 1) {
      return '1 năm trước';
    }
    return '${(difference.inDays / 365).floor()} năm trước';
  }
}

extension MapExtension<K, V> on Map<K, V> {
  Map<K, V> get json => Map<K, V>.from(Commons.validateNull(this));
  Map<K, V> get prettyJson =>
      j.json.decode(const j.JsonEncoder.withIndent(' ').convert(this));
}
