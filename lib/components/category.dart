import 'package:get/get.dart';

class category extends GetxController {
  int? categoryIndex;
  void changeIndex(int value) {
    categoryIndex = value;
    update();
  }
}
