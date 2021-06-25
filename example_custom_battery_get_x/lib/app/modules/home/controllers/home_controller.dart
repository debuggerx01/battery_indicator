import 'package:flutter/material.dart';
import 'package:get/get.dart';

//enum BatteryIndicatorStyle { flat, skeumorphism }
import 'package:battery_indicator/battery_indicator.dart';

class HomeController extends GetxController {
  //this Rx is to be reactive, so with that the Obx can "observe" the changes

  //0,flat and 1,skeumorphism
  BatteryIndicatorStyle myStyle = BatteryIndicatorStyle.values[0];

  var colorful = true;

  var showPercentSlide = true;

  var showPercentNum = true;

  var size = 35.0;

  var ratio = 6.0;

  Color color = Colors.blue;

  RxInt bat = RxInt(35);

  @override
  void onReady() async {}

  @override
  void onClose() {}

  void increment() {
    if (bat.value < 100) {
      bat.value++;
    }
  }

  void decrement() {
    if (bat.value > 0) {
      bat.value--;
    }
  }
}
