import 'package:flutter/services.dart';

class SpendingModel {
  int? id;
  String? name;
  num? amount;
  String? mode;
  String? date;
  String? time;
  Uint8List image;

  SpendingModel({
    this.id,
    this.name,
    this.amount,
    this.mode,
    this.date,
    this.time,
    required this.image,
  });

  factory SpendingModel.fromJson(Map<String, dynamic> data) {
    return SpendingModel(
      id: data['spendingID'],
      name: data['spendingName'],
      amount: data['spendingAmount'],
      mode: data['spendingMode'],
      date: data['spendingDate'],
      time: data['spendingTime'],
      image: data['spendingImage'],
    );
  }
}
