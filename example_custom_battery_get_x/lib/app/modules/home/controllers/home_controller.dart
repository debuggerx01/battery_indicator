import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:battery/battery.dart';

enum BatteryIndicatorStyle { flat, skeumorphism }

class HomeController extends GetxController {
  //this Rx is to be reactive, so with that the Obx can "observe" the changes
  RxInt batteryLevel = RxInt(25);
  bool takeBatteryFromPhone = false;
  Battery battery = Battery();
  @override
  void onInit() {}

  @override
  void onReady() async {
    if (takeBatteryFromPhone) {
      battery.batteryLevel.then((val) {
        print(val);
        batteryLevel.value = val;
      });
    }
  }

  @override
  void onClose() {}
  void increment() {
    if (!takeBatteryFromPhone) {
      if (batteryLevel.value < 100) {
        batteryLevel.value++;
      }
    }
  }

  void decrement() {
    if (!takeBatteryFromPhone) {
      if (batteryLevel.value > 0) {
        batteryLevel.value--;
      }
    }
  }
}
