import 'package:budget_tracker/bottomnavigation/controller/views/bottomnavigation.dart';
import 'package:budget_tracker/view/home/home.dart';
import 'package:budget_tracker/view/splash/splash.dart';
import 'package:get/get.dart';

class GetPages {
  static const String splash = '/splash';
  static const String home = '/';

  static List<GetPage> pages = [
    GetPage(name: splash, page: () => const Splash()),
    GetPage(name: home, page: () => const BottomNavigationPage()),
  ];
}
