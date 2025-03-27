import 'package:budget_tracker/controller/category_controller.dart';
import 'package:budget_tracker/controller/spending_controller.dart';
import 'package:budget_tracker/model/spending_model.dart';
import 'package:budget_tracker/view/components/spending.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AllSpending extends StatelessWidget {
  const AllSpending({Key? key});

  @override
  Widget build(BuildContext context) {
    SpendingController spendingController = Get.put(SpendingController());
    CategoryController controller = Get.put(CategoryController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Spending'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: GetBuilder<SpendingController>(
                builder: (context) {
                  return FutureBuilder(
                    future: spendingController.spendingList,
                    builder: (context, snapshot) {
                      List<SpendingModel> spendingListData =
                          snapshot.data ?? [];
                      return spendingListData.isNotEmpty
                          ? ListView.builder(
                              itemCount: spendingListData.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    spendingController.deleteSpending(index);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          (spendingListData[index].date != null)
                                              ? Text(
                                                  "${spendingListData[index].date}",
                                                )
                                              : const Text("DD/MM/YYYY"),
                                          spendingListData[index].time != null
                                              ? Text(
                                                  "${spendingListData[index].time}",
                                                )
                                              : const Text("HH/MM"),
                                        ],
                                      ),
                                      const Divider(),
                                      ListTile(
                                        subtitle: Text(
                                          spendingListData[index].mode ==
                                                  "Online"
                                              ? "💳  ${spendingListData[index].mode}"
                                              : "💸  ${spendingListData[index].mode}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        title: Text(
                                          "${spendingListData[index].name}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        trailing: Text(
                                          "\$ ${spendingListData[index].amount}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        leading: CircleAvatar(
                                          backgroundImage: MemoryImage(
                                            spendingListData[index].image,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Image.asset(
                                "assets/images/empty.png",
                                height: 200.h,
                              ),
                            );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SpendingPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
