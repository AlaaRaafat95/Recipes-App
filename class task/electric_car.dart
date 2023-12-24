import 'car.dart';

class ElectricCar extends Car {
  final int batteryLevel;

  ElectricCar.charge(
      {required super.brand,
      required super.model,
      required super.productionYear,
      required super.color,
      required super.price,
      super.maxNumberOfPassenger = 4,
      required this.batteryLevel});
  void needCharge() {
    if (batteryLevel < 25) {
      print("Your Car Need to Recharge");
    } else {
      print("Your Car Don't Need to Recharge");
    }
  }

  @override
  void displayInfo() {
    super.displayInfo();
    print(
        "Car Information:\nBarnd Is $brand ,\nProduction Year is $productionYear ,\nBattery Level Now $batteryLevel ,\nMax Number Of Passenger are $maxNumberOfPassenger");
  }
}
