import 'package:commons/commons.dart';
import 'package:finplus/layers/data/repository/authentication_repository_impl.dart';
import 'package:finplus/layers/data/repository/chat_repository_impl.dart';
import 'package:finplus/services/connection_service.dart';
import 'package:finplus/services/global_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(GlobalService());
    Get.put(ConnectionService());
    Get.put(AuthenticationRepositoryImpl());
    Get.put(ChatRepositoryImpl());
  }
}
