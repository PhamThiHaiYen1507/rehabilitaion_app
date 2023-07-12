import 'package:commons/commons.dart';
import 'package:finplus/services/connection_service.dart';
import 'package:finplus/services/global_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(GlobalService());
    Get.put(ConnectionService());
  }
}
