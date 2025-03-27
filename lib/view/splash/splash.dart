import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../utills/get_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () => Get.offNamed(GetPages.home),
    );
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/Splash.png',
          height: 200.h,
        ),
      ),
    );
  }
}
