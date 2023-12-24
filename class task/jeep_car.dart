import 'package:flutter/material.dart';

import 'car.dart';

class JeepCar extends Car {
  JeepCar(
      {required String brand,
      required String model,
      required int productionYear,
      required Color color,
      int maxNumberOfPassenger = 4,
      required String price})
      : super(
            brand: brand,
            model: model,
            productionYear: productionYear,
            color: color,
            price: price,
            maxNumberOfPassenger: maxNumberOfPassenger);

  @override
  void service() {
    super.service();
    print("$brand $model Use In Safari Services In The Desert");
  }
}
