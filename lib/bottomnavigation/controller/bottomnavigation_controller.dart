import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomnavigationController extends GetxController {
  RxInt index = 0.obs;
  PageController pageController = PageController();

  void changeIndex(int value) {
    index.value = value;
  }

  void changePage(int value) {
    pageController.animateToPage(value,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
    update();
  }
}
