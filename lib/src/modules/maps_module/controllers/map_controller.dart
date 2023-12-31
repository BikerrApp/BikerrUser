import 'dart:developer';

import 'package:bikerr_partner_app/src/extensions/bitmap_convertor.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';

import 'package:bikerr_partner_app/src/modules/maps_module/controllers/devices_controller.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/controllers/notifications_controller.dart';
import 'package:bikerr_partner_app/src/services/traccar_services.dart';

import 'package:bikerr_partner_app/src/utils/methods/common_method.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';

class MapController extends GetxController {
  final dc = Get.put(DevicesController());
  final nc = Get.put(NotificationsController());

  late final bmc = Get.find<BaseController>();

  @override
  void onInit() async {
    await addMapSdkKeys();
    super.onInit();
  }

  late final mapController = Rxn<MapmyIndiaMapController>();

  final myLocationEnabled = true.obs;
  final polylineCoordinates = Rx<List<LatLng>>([]);
  final location = Rxn<LatLng>();
  final devLocSymbol = Rxn<Symbol>();

  final isSearch = false.obs;
  final streetView = false.obs;
  final searchCntrl = TextEditingController().obs;

  final mapLoading = false.obs;

  final isDeviceDataLoading = false.obs;

  final totolDistance = 0.0.obs;
  final avgSpeed = 0.0.obs;
  final topSpeed = 0.0.obs;
  final timeDriven = 0.obs;

  final CameraPosition myLoc = const CameraPosition(
    target: LatLng(28.022936, 73.311913),
    zoom: 18,
  );

  addMapSdkKeys() async {
    MapmyIndiaAccountManager.setMapSDKKey("b23e147720a7e8233939f76daaeb2f05");
    MapmyIndiaAccountManager.setRestAPIKey("b23e147720a7e8233939f76daaeb2f05");
    MapmyIndiaAccountManager.setAtlasClientId(
        "33OkryzDZsIDH5oRuglAtHUxZBZFxa6JLiduqeU2YtWBpO4i0kmOeMj-CegHTXdC8HS0l_BwB6b--aV-vwK99DCgwkF7NP6L");
    MapmyIndiaAccountManager.setAtlasClientSecret(
        "lrFxI-iSEg_UXnyUPaYW3NUkthwzkmPNpl8kzIIBXTZ87oqRzqxWlhpG0c74PAdIOZi65NdOPQysGfbcPdlg5OEs1X9q1gZNeidQQw5Gk9E=");
  }

  Future<void> onMapCreated(MapmyIndiaMapController controller) async {
    mapController.value = controller;
    await moveToMyLocation();
  }

  moveToMyLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
      );
      location.value = LatLng(position.latitude, position.longitude);
      log("${location.value}", name: "asdgasdgsagsgsga");
      mapController.value!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: location.value!, zoom: 14),
        ),
      );
    } catch (e) {
      log("$e", name: "error in map");
    }

    dc.isListVisible.value = false;
  }

  addDeviceLocationMarker({LatLng? geometry}) async {
    await addImageFromAsset("devLoc", myLocIcon, mapController.value!);
    devLocSymbol.value = await mapController.value!.addSymbol(
      SymbolOptions(
        geometry: geometry,
        iconImage: "devLoc",
        iconSize: 0.5,
      ),
    );
  }

  moveToMarker({required int deviceId}) async {
    try {
      mapController.value!.removeSymbol(devLocSymbol.value!);
    } catch (e) {
      log("$e");
    }

    var deviceIdData = bmc.sockC.srh.socketPositionsData.value!
        .where((e) => e.deviceId == deviceId);
    log("$deviceIdData", name: "asdfasdfasdf");

    if (deviceIdData.isNotEmpty &&
        deviceIdData.first.latitude != null &&
        deviceIdData.first.longitude != null) {
      CameraPosition cPosition = CameraPosition(
        target: LatLng(
          deviceIdData.first.latitude!,
          deviceIdData.first.longitude!,
        ),
        zoom: 14,
      );
      mapController.value!.animateCamera(
        CameraUpdate.newCameraPosition(cPosition),
      );
      await addDeviceLocationMarker(
        geometry: LatLng(
          deviceIdData.first.latitude!,
          deviceIdData.first.longitude!,
        ),
      );

      streetView.value = true;
      dc.isListVisible.value = false;
    } else {
      log("kuchh locha hai bhai");
    }
  }

  getDeviceData({required int deviceId}) async {
    DateTime to = DateTime.now();
    DateTime from = to.subtract(const Duration(days: 30));
    var res = await Traccar.getSummary(
      loading: isDeviceDataLoading,
      deviceId: deviceId.toString(),
      from: from.toUtc().toIso8601String(),
      to: to.toUtc().toIso8601String(),
    );
    log("$res", name: "sadgfgasfg");
    totolDistance.value = res!.first.distance!;
    avgSpeed.value = res.first.averageSpeed!;
    topSpeed.value = res.first.maxSpeed!;
    timeDriven.value = res.first.engineHours!;

    log("${avgSpeed.value} , ${totolDistance.value} , ${topSpeed.value} , ${timeDriven.value}",
        name: "sdgsfgdsfgsd");
  }

  clearValues() {
    totolDistance.value = 0.0;
    avgSpeed.value = 0.0;
    topSpeed.value = 0.0;
    timeDriven.value = 0;
  }

  getMoreControlsData(value, {required int deviceId}) {
    getDeviceData(deviceId: deviceId);
    switch (value) {
      case 0:
        return convertDistance(totolDistance.value);
      case 1:
        return convertSpeed(avgSpeed.value);
      case 2:
        return convertSpeed(topSpeed.value);
      case 3:
        return convertDuration(timeDriven.value);
      case 4:
        return "View";
      case 5:
        return "View";

      default:
        return "";
    }
  }
}
