import 'package:flutter/material.dart';
import 'electric_car.dart';
import 'sports_car.dart';
import 'jeep_car.dart';

void main() {
  SportsCar sportsCar = SportsCar(
    brand: "Ferrari",
    model: "Daytona",
    productionYear: 2022,
    color: Colors.red,
    price: r"2,218,935 $",
  );
  sportsCar.speedPerHour(5.0);
  sportsCar.service();
  sportsCar.version();
  print("=================================>");

  JeepCar jeebCar = JeepCar(
      brand: "Jeep",
      model: "Renegade",
      productionYear: 2010,
      color: Colors.black,
      price: "1,050,000 EGP");
  print(
      "Max Number of Passengers in Jeep Car : ${jeebCar.maxNumberOfPassenger}");
  jeebCar.service();
  jeebCar.version();
  print("=================================>");

  ElectricCar electricCar = ElectricCar.charge(
      brand: "Tesla",
      model: "Model Y",
      productionYear: 2024,
      color: Colors.white,
      price: "1,050,000 EGP",
      batteryLevel: 50);
  electricCar.displayInfo();
  electricCar.needCharge();
}
