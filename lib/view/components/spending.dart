import 'package:budget_tracker/controller/category_controller.dart';
import 'package:budget_tracker/controller/spending_controller.dart';
import 'package:budget_tracker/model/category_model.dart';
import 'package:budget_tracker/model/spending_model.dart';
import 'package:budget_tracker/view/components/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SpendingPage extends StatelessWidget {
  const SpendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryController controller = Get.put(CategoryController());
    SpendingController spendingController = Get.put(SpendingController());
    TextEditingController textController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Spending",
                style: TextStyle(fontSize: 20.sp),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.close),
                  ),
                  GetBuilder<SpendingController>(
                    builder: (context) {
                      return IconButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            // name
                            String categoryName = controller
                                .categoryMap[controller.categoryIndex!]['name'];
                            // image

                            SpendingModel model = SpendingModel(
                                name: textController.text,
                                amount: num.parse(amountController.text),
                                mode: spendingController.mode,
                                image: spendingController.image ?? Uint8List(0),
                                date:
                                    "${spendingController.dateTime?.day}/${spendingController.dateTime?.month}/${spendingController.dateTime?.year}",
                                time:
                                    "${spendingController.timeOfDay?.hour}:${spendingController.timeOfDay?.minute}");
                            spendingController.initSpendingData(model);
                            spendingController.fetchSpendingData();
                            controller.clearCategoryIndex();
                            spendingController.clear();
                            textController.clear();
                            spendingController.dateTime = null;
                            spendingController.timeOfDay = null;
                            amountController.clear();
                          }
                          Get.back();
                        },
                        icon: const Icon(Icons.check),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.bottomSheet(
                          BottomSheet(
                            onClosing: () {},
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Category",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Expanded(
                                      child: FutureBuilder(
                                        future: controller.categoryList,
                                        builder: (context, snapshot) {
                                          {
                                            List<CategoryModel>
                                                categoryListData =
                                                snapshot.data ?? [];
                                            return ListView.builder(
                                              itemCount:
                                                  categoryListData.length,
                                              itemBuilder: (context, index) {
                                                return GetBuilder<
                                                    CategoryController>(
                                                  builder: (context) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .getCategoryIndex(
                                                                index);

                                                        spendingController
                                                            .getSpendingImage(
                                                                categoryListData[
                                                                        index]
                                                                    .image);
                                                      },
                                                      child: controller
                                                                  .categoryIndex ==
                                                              index
                                                          ? Card(
                                                              child: ListTile(
                                                                leading:
                                                                    CircleAvatar(
                                                                  backgroundImage:
                                                                      MemoryImage(
                                                                    categoryListData[
                                                                            index]
                                                                        .image,
                                                                  ),
                                                                ),
                                                                title: Text(
                                                                  categoryListData[
                                                                          index]
                                                                      .name,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                trailing: controller
                                                                            .categoryIndex ==
                                                                        index
                                                                    ? const Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: Colors
                                                                            .green,
                                                                      )
                                                                    : const Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: Colors
                                                                            .transparent,
                                                                      ),
                                                              ),
                                                            )
                                                          : ListTile(
                                                              leading:
                                                                  CircleAvatar(
                                                                backgroundImage:
                                                                    MemoryImage(
                                                                  categoryListData[
                                                                          index]
                                                                      .image,
                                                                ),
                                                              ),
                                                              title: Text(
                                                                categoryListData[
                                                                        index]
                                                                    .name,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              trailing: controller
                                                                          .categoryIndex ==
                                                                      index
                                                                  ? const Icon(
                                                                      Icons
                                                                          .check,
                                                                      color: Colors
                                                                          .green,
                                                                    )
                                                                  : const Icon(
                                                                      Icons
                                                                          .check,
                                                                      color: Colors
                                                                          .transparent,
                                                                    ),
                                                            ),
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 50.h,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        margin: EdgeInsets.only(right: 10.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: GetBuilder<CategoryController>(
                          builder: (context) {
                            return FutureBuilder(
                              future: controller.categoryList,
                              builder: (context, snapshot) {
                                List<CategoryModel> categoryListData =
                                    snapshot.data ?? [];
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    (controller.categoryIndex != null)
                                        ? CircleAvatar(
                                            backgroundImage: MemoryImage(
                                                categoryListData[controller
                                                        .categoryIndex!]
                                                    .image),
                                            radius: 15.r,
                                          )
                                        : const CircleAvatar(),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      (controller.categoryIndex == null)
                                          ? "Category"
                                          : categoryListData[
                                                  controller.categoryIndex!]
                                              .name,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GetBuilder<CategoryController>(
                      builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              BottomSheet(
                                onClosing: () {},
                                builder: (context) {
                                  return Container(
                                    padding: const EdgeInsets.all(16),
                                    height: 110.h,
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        RadioMenuButton(
                                          onChanged: spendingController.getMode,
                                          value: "Online",
                                          groupValue: spendingController.mode,
                                          child: const Text("Online"),
                                        ),
                                        RadioMenuButton(
                                          onChanged: spendingController.getMode,
                                          value: "Offline",
                                          groupValue: spendingController.mode,
                                          child: const Text("Offline"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                            height: 50.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: GetBuilder<SpendingController>(
                                builder: (context) {
                              return Text(
                                spendingController.mode ?? "Mode",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                ),
                              );
                            }),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              // NOtes
              TextField(
                maxLines: 3,
                controller: textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Add Notes",
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20.h),
              // Amount
              TextFormField(
                validator: (val) =>
                    (val!.isEmpty) ? "Amount can't be empty" : null,
                maxLines: 3,
                controller: amountController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Add Amount",
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 5.h),
              // Date and Time
              Row(
                children: [
                  // DateTime
                  Expanded(
                    child: GetBuilder<SpendingController>(
                      builder: (_) {
                        return Container(
                          height: 50.h,
                          padding: const EdgeInsets.all(10),
                          margin: EdgeInsets.only(right: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: TextButton.icon(
                            onPressed: () async {
                              DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2030),
                              );

                              if (date != null) {
                                spendingController.getSpendingDate(date);
                              }
                            },
                            label: (spendingController.dateTime != null)
                                ? Text(
                                    "${spendingController.dateTime?.day}/${spendingController.dateTime?.month}/${spendingController.dateTime?.year}",
                                  )
                                : const Text(
                                    "DD/MM/YYYY",
                                    style: TextStyle(color: Colors.white),
                                  ),
                            icon: const Icon(
                              Icons.date_range,
                              size: 20,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // TimeOfDay
                  SingleChildScrollView(
                    child: Expanded(
                      child: GetBuilder<SpendingController>(
                        builder: (_) {
                          return GestureDetector(
                            child: Container(
                              height: 50.h,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              margin: EdgeInsets.only(right: 10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: TextButton.icon(
                                onPressed: () async {
                                  TimeOfDay? time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (time != null) {
                                    spendingController.getSpendingTime(time);
                                  }
                                },
                                icon: const Icon(Icons.timer_outlined),
                                label: (spendingController.timeOfDay != null)
                                    ? Text(
                                        "${spendingController.timeOfDay?.hour}:${spendingController.timeOfDay?.minute}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text("HH:MM"),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
