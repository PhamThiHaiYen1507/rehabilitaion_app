import 'package:commons/commons.dart';

class HomeController extends GetxController {
  final RxInt _selectedIndex = RxInt(0);

  int get selectedIndex => _selectedIndex.value;

  set selectedIndex(int value) {
    _selectedIndex(value);
  }
}
