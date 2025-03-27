import 'dart:developer';

import 'package:budget_tracker/helper.dart';
import 'package:budget_tracker/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  int? categoryIndex;
  // Map
  List<Map<String, dynamic>> categoryMap = [
    {
      "name": "Beauty",
      "images": "assets/images/beauty.webp",
    },
    {
      "name": "Bills",
      "images": "assets/images/bills.png",
    },
    {
      "name": "Car",
      "images": "assets/images/car.png",
    },
    {
      "name": "Clothing",
      "images": "assets/images/clothing.png",
    },
    {
      "name": "Education",
      "images": "assets/images/education.png",
    },
    {
      "name": "Electronics",
      "images": "assets/images/electronics.png",
    },
    {
      "name": "Sports",
      "images": "assets/images/sport.png",
    },
    {
      "name": "Food",
      "images": "assets/images/food.jpg",
    },
    {
      "name": "Health",
      "images": "assets/images/health.jpg",
    },
    {
      "name": "Home",
      "images": "assets/images/home.png",
    },
    {
      "name": "Insurance",
      "images": "assets/images/insurance.jpg",
    },
    {
      "name": "Movie",
      "images": "assets/images/movie.jpg",
    },
    {
      "name": "Refund",
      "images": "assets/images/refund.webp",
    },
    {
      "name": "Salary",
      "images": "assets/images/salary.png",
    },
    {
      "name": "Shopping",
      "images": "assets/images/shopping.png",
    },
    {
      "name": "Social",
      "images": "assets/images/social.webp",
    },
    {
      "name": "Sport",
      "images": "assets/images/sport.png",
    },
    {
      "name": "Tax",
      "images": "assets/images/tax.png",
    },
    {
      "name": "Telephone",
      "images": "assets/images/telephone.webp",
    },
    {
      "name": "Transport",
      "images": "assets/images/transportation.png",
    },
    {
      "name": "Other",
      "images": "assets/images/other.png",
    },
  ];
  List<Map<String, dynamic>> allData = [
    {
      "name": "Beauty",
      "images": "assets/images/beauty.webp",
    },
    {
      "name": "Bills",
      "images": "assets/images/bills.png",
    },
    {
      "name": "Car",
      "images": "assets/images/car.png",
    },
    {
      "name": "Clothing",
      "images": "assets/images/clothing.png",
    },
    {
      "name": "Education",
      "images": "assets/images/education.png",
    },
    {
      "name": "Electronics",
      "images": "assets/images/electronics.png",
    },
    {
      "name": "Sports",
      "images": "assets/images/sport.png",
    },
    {
      "name": "Food",
      "images": "assets/images/food.jpg",
    },
    {
      "name": "Health",
      "images": "assets/images/health.jpg",
    },
    {
      "name": "Home",
      "images": "assets/images/home.png",
    },
    {
      "name": "Insurance",
      "images": "assets/images/insurance.jpg",
    },
    {
      "name": "Movie",
      "images": "assets/images/movie.jpg",
    },
    {
      "name": "Refund",
      "images": "assets/images/refund.webp",
    },
    {
      "name": "Salary",
      "images": "assets/images/salary.png",
    },
    {
      "name": "Shopping",
      "images": "assets/images/shopping.png",
    },
    {
      "name": "Social",
      "images": "assets/images/social.webp",
    },
    {
      "name": "Sport",
      "images": "assets/images/sport.png",
    },
    {
      "name": "Tax",
      "images": "assets/images/tax.png",
    },
    {
      "name": "Telephone",
      "images": "assets/images/telephone.webp",
    },
    {
      "name": "Transport",
      "images": "assets/images/transportation.png",
    },
    {
      "name": "Other",
      "images": "assets/images/other.png",
    },
  ];

  Future<List<CategoryModel>>? categoryList;

  CategoryController() {
    fetchCategoryData();
  }

  void getCategoryIndex(int index) {
    categoryIndex = index;
    update();
  }

  void clearCategoryIndex() {
    categoryIndex = null;
    update();
  }

  // insertCategoryData
  void insertCategoryData(String name, Uint8List image) async {
    int? result = await DBHelper.dbHelper.insertCategoryData(
        name: name, image: image, imageIndex: categoryIndex);
    if (result != null) {
      Get.snackbar(
        "Insert",
        "category is inserted...",
        colorText: Colors.white,
        backgroundColor: Colors.green.shade300,
      );
    } else {
      Get.snackbar(
        "Failed",
        "category is Insertion failed....",
        colorText: Colors.white,
        backgroundColor: Colors.red.shade300,
      );
    }
    update();
  }

  // fetchCategoryData
  void fetchCategoryData() {
    categoryList = DBHelper.dbHelper.fetchCategoryData();
    update();
  }

  // searchCategoryData
  void searchCategoryData(String search) {
    categoryList = DBHelper.dbHelper.searchCategoryData(search);
    update();
  }

  // searchCategoryData
  void searchCategoryMapData(String search) {
    List<Map<String, dynamic>> data = categoryMap
        .where((e) =>
            e['name'].toString().toLowerCase().contains(search.toLowerCase()))
        .toList();

    categoryMap = data.isNotEmpty ? data : [];
    update();
  }

  void assignAllCategory() {
    categoryMap = allData;

    update();
  }

  // deleteCategoryData
  Future<void> deleteCategoryData(int id) async {
    int? result = await DBHelper.dbHelper.deleteCategoryData(id);

    if (result != null) {
      Get.snackbar(
        "Delete",
        "category is Deleted...",
        colorText: Colors.white,
        backgroundColor: Colors.green.shade300,
      );
    } else {
      Get.snackbar(
        "Failed",
        "category is Deletion failed....",
        colorText: Colors.white,
        backgroundColor: Colors.red.shade300,
      );
    }
    fetchCategoryData();
    update();
  }

  // editCategoryData
  Future<void> editCategoryData(CategoryModel model) async {
    int? result = await DBHelper.dbHelper.editCategoryData(model);
    log("${model.name}");
    log("${model.image}");
    if (result != null) {
      fetchCategoryData();
      Get.snackbar(
        'Update',
        "Category is updated...",
        backgroundColor: Colors.green.withOpacity(0.7),
      );
    } else {
      Get.snackbar(
        'Failed',
        "Category is updation failed...",
        backgroundColor: Colors.red.withOpacity(0.7),
      );
    }

    fetchCategoryData();
    update();
  }
}
