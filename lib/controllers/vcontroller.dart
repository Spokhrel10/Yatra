import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_yatra/vehicle_owners_menu/vehiclemenu.dart';
import 'package:sajilo_yatra/vehicle_owners/vehicleride.dart';

import '../vehicle_owners/vehicleownerhome.dart';
import '../vehicle_owners/vehicletickets.dart';

class NavController extends GetxController {
  int selectedIndex = 0;
  Offset offset = const Offset(1, 0);
  final List<Widget> screens = [
    const VehicleHome(
      userId: '',
      going: '',
      leaving: '',
      location: '',
    ),
    const VMenu(),
    const VehicleTickets(),
    const VehicleRide(),
  ];

  changeIndex(index) {
    if (index > selectedIndex) {
      offset = const Offset(1, 0);
    } else {
      offset = const Offset(-1, 0);
    }
    selectedIndex = index;
    update();
  }
}
