import 'package:budget_tracker/bottomnavigation/controller/views/bottomnavigation.dart';
import 'package:budget_tracker/view/splash/splash.dart';
import 'package:get/get.dart';

class GetPages {
  static const String splash = '/';
  static const String home = '/home';

  static List<GetPage> pages = [
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(name: home, page: () => const BottomNavigationPage()),
  ];
}
