import 'package:budget_tracker/bottomnavigation/controller/bottomnavigation_controller.dart';
import 'package:budget_tracker/view/components/allSpending.dart';
import 'package:budget_tracker/view/components/allcategory.dart';
import 'package:budget_tracker/view/components/category.dart';
import 'package:budget_tracker/view/components/spending.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationPage extends StatelessWidget {
  const BottomNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    BottomnavigationController controller =
        Get.put(BottomnavigationController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Tracker'),
      ),
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (value) => controller.changeIndex(value),
        children: const [
          AllSpending(),
          SpendingPage(),
          AllCategoryPage(),
          CategoryPage(),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return NavigationBar(
          selectedIndex: controller.index.value,
          onDestinationSelected: (value) {
            controller.changeIndex(value);
            controller.changePage(value);
          },
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.account_balance_wallet),
                label: 'All Spending'),
            NavigationDestination(icon: Icon(Icons.receipt), label: 'Spending'),
            NavigationDestination(
                icon: Icon(Icons.receipt_long), label: 'All Category'),
            NavigationDestination(
                icon: Icon(Icons.category), label: 'Category'),
          ],
        );
      }),
    );
  }
}
