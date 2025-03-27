import 'package:get/get.dart';

class Category extends GetxController {
  int? categoryIndex;
  void changeIndex({required int value}) {
    categoryIndex = value;
    update();
  }
}
