import 'package:commons/commons.dart';
import 'package:finplus/base/network/app_connection.dart';
import 'package:finplus/utils/app_logger.dart';

class ConnectionService extends GetxService {
  @override
  void onInit() {
    AppConnection.addListener(_onChangedConnection);
    super.onInit();
  }

  void _onChangedConnection(bool hasConnect) {
    if (!hasConnect) {
      logD('Disconnect to network');
    }
  }
}
