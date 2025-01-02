import 'package:budget_tracker/components/category.dart';
import 'package:budget_tracker/utills/extentions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<Map<String, dynamic>> categoryList = [
  {
    "name": "beauty",
    "images": "assets/images/beauty.webp",
  },
  {
    "name": "bills",
    "images": "assets/images/bills.png",
  },
  {
    "name": "car",
    "images": "assets/images/car.png",
  },
  {
    "name": "clothing",
    "images": "assets/images/clothing.png",
  },
  {
    "name": "education",
    "images": "assets/images/education.png",
  },
  {
    "name": "electronics",
    "images": "assets/images/electronics.png",
  },
  {
    "name": "sports",
    "images": "assets/images/sport.png",
  },
  {
    "name": "food",
    "images": "assets/images/food.jpg",
  },
  {
    "name": "health",
    "images": "assets/images/health.jpg",
  },
  {
    "name": "home",
    "images": "assets/images/home.png",
  },
  {
    "name": "insurance",
    "images": "assets/images/insurance.jpg",
  },
  {
    "name": "movie",
    "images": "assets/images/movie.jpg",
  },
  {
    "name": "refund",
    "images": "assets/images/refund.webp",
  },
  {
    "name": "salary",
    "images": "assets/images/salary.png",
  },
  {
    "name": "shopping",
    "images": "assets/images/shopping.png",
  },
  {
    "name": "social",
    "images": "assets/images/social.webp",
  },
  {
    "name": "sport",
    "images": "assets/images/sport.png",
  },
  {
    "name": "tax",
    "images": "assets/images/tax.png",
  },
  {
    "name": "telephone",
    "images": "assets/images/telephone.webp",
  },
  {
    "name": "transport",
    "images": "assets/images/transportation.png",
  },
];
GlobalKey<FormState> formKey = GlobalKey<FormState>();
TextEditingController controller = TextEditingController();

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    category controllers = Get.put(category());
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: controller,
              validator: (value) =>
                  value!.isEmpty ? "Enter Category Name" : null,
              decoration: InputDecoration(
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.redAccent,
                  ),
                ),
                hintText: 'Category Name',
                labelText: 'Category',
                prefixIcon: const Icon(
                  Icons.search,
                ),
              ),
            ),
            30.h,
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: (index == controllers.changeIndex)
                              ? Colors.grey
                              : Colors.transparent,
                          width: 3,
                        ),
                        image: DecorationImage(
                          image: AssetImage(
                            categoryList[index]["images"],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton.extended(
                  onPressed: () {},
                  label: const Text("Add Category"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
