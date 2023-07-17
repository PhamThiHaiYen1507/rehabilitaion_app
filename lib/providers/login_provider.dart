import 'package:commons/commons.dart';
import 'package:finplus/base/base.dart';
import 'package:finplus/models/login_data.dart';
import 'package:finplus/providers/api_path.dart';
import 'package:finplus/utils/utils.dart';

class LoginProvider extends BaseNetWork {
  Future<LoginData?> login(
      {String? phoneNumber,
      String? password,
      Map<String, String>? saveParams}) async {
    final params = {
      'phoneNumber': phoneNumber,
      'password': password,
    }.json;

    final ApiRequest req = ApiRequest(
      path: ApiPath.login,
      method: METHOD.POST,
      auth: true,
      body: saveParams ?? params,
    );

    final res = await sendRequest(req, decoder: LoginData.fromJson);
    if (res.success) {
      return res.body;
    } else {
      res.showError('Login');
      return null;
    }
  }

  Future<bool> checkPhoneNumber({
    String? phoneNumber,
  }) async {
    final params = {
      'phoneNumber': phoneNumber,
    }.json;

    final ApiRequest req = ApiRequest(
      path: ApiPath.checkPhoneNumber,
      method: METHOD.POST,
      auth: true,
      body: params,
    );

    final res = await sendRequest(req);
    if (res.success) {
      return res.body['data'];
    } else {
      res.showError('checkPhoneNumber');
      return false;
    }
  }

  @override
  dynamic decodeField(body) => body['data'];
}
