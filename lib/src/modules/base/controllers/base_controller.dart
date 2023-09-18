import 'package:bikerr_partner_app/src/modules/add_bikes/controllers/add_bike_controller.dart';
import 'package:bikerr_partner_app/src/modules/profile/controller/profile_controller.dart';
import 'package:bikerr_partner_app/src/modules/profile/user_profile.dart';
import 'package:bikerr_partner_app/src/modules/socket_handling/socket_controller.dart';
import 'package:bikerr_partner_app/src/modules/home/controller/home_controller.dart';
import 'package:bikerr_partner_app/src/modules/home/home.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/controllers/map_controller.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  final hc = Get.put(HomeController());
  final pc = Get.put(ProfileController());
  final mapC = Get.put(MapController());
  final sockC = Get.put(SocketController());
  final ac = Get.put(AddBikeController());

  final onTapChangePageIndex = 0.obs;
  final pageController = PageController().obs;

  List<Widget> pages = [
    const HomeScreen(),
    const MapScreenClass(),
    const UserProfileScreen(),
  ];

  void onPageChanged(int index) {
    onTapChangePageIndex.value = index;
  }

  void onItemTap(int selectedItem) {
    pageController.value.jumpToPage(selectedItem);
    onTapChangePageIndex.value = selectedItem;
  }
}
