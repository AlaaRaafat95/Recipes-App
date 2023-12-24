import 'package:flutter/material.dart';

abstract class Car {
  final String brand;
  final String model;
  final int productionYear;
  final Color color;
  final String price;
  final int maxNumberOfPassenger;
  Car({
    required this.brand,
    required this.model,
    required this.productionYear,
    required this.color,
    required this.price,
    required this.maxNumberOfPassenger,
  });
  void version() {
    if (productionYear > 2010) {
      print("$brand $model Is New Version");
    } else {
      print("$brand $model Is Old Version");
    }
  }

  void displayInfo() {}
  void service() {}
}
