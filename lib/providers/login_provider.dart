import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:finplus/providers/api_path.dart';

import '../base/app_config/app_config.dart';
import '../utils/app_logger.dart';
import '../utils/types.dart';

class LoginProvider extends GetConnect {
  Future<dynamic> login(
      {String? phoneNumber,
      String? password,
      Map<String, dynamic>? saveParams}) async {
    try {
      final params = {
        'phoneNumber': phoneNumber,
        'password': password,
      };
      final Map<String, String> headers = {};
      final Uri uri = getUri(
          AppConfig.info.baseUrl, ApiPath.login, {}, AppConfig.info.secure);

      final Response data =
          await post(uri.toString(), saveParams ?? params, headers: headers);

      if (data.statusCode == 200) {
        Storage.put<String>(KEY.SAVE_LOGIN_PARAMS.toString(),
            json.encode(saveParams ?? params));
        return data.body;
      } else {
        return null;
        // if (data.status.connectionError || data.status.hasError) {
        //   throw 'Kết nối mạng không ổn định. Vui lòng thử lại sau.';
        // } else {
        //   throw data.body?['errorMsg'] ?? 'Sever Error';
        // }
      }
    } catch (e, stackTrace) {
      logE(e, stackTrace);
      rethrow;
    }
  }
}
