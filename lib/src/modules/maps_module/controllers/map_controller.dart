import 'dart:developer';

import 'package:bikerr_partner_app/src/extensions/bitmap_convertor.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';

import 'package:bikerr_partner_app/src/modules/maps_module/controllers/devices_controller.dart';
import 'package:bikerr_partner_app/src/utils/methods/common_method.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';

class MapController extends GetxController {
  final dc = Get.put(DevicesController());

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
  final myLocSymbol = Rxn<Symbol>();

  final isSearch = false.obs;
  final streetView = false.obs;
  final searchCntrl = TextEditingController().obs;

  final mapLoading = false.obs;

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
    } catch (e) {
      log("$e", name: "error in map");
    }
    mapController.value!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: location.value!, zoom: 14),
      ),
    );
    dc.isListVisible.value = false;
  }

  addMyLocationMarker({LatLng? geometry}) async {
    await addImageFromAsset("myLoc", myLocIcon, mapController.value!);
    myLocSymbol.value = await mapController.value!.addSymbol(
      SymbolOptions(
        geometry: geometry ?? location.value,
        iconImage: "myLoc",
        iconSize: 0.5,
      ),
    );
  }

  moveToMarker({required int deviceId}) async {
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
      await addMyLocationMarker(
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

  String getMoreControlsData(value, {required int deviceId}) {
    var deviceIdData = bmc.sockC.srh.socketPositionsData.value!
        .where((e) => e.deviceId == deviceId);
    log("$deviceIdData", name: "asdfasdfasdf");

    switch (value) {
      case 0:
        return convertDistance(deviceIdData.first.attributes!["totalDistance"]);
      case 1:
        return convertSpeed(deviceIdData.first.speed!);
      case 2:
        return convertSpeed(deviceIdData.first.speed!);
      case 3:
        return convertDuration(deviceIdData.first.attributes!["hours"]);
      case 4:
        return "View";
      case 5:
        return "View";

      default:
        return "";
    }
  }

  void addPolygon() async {
    List<List<LatLng>> latlng = const [
      <LatLng>[
        LatLng(28.703900, 77.101318),
        LatLng(28.703331, 77.102155),
        LatLng(28.703905, 77.102761),
        LatLng(28.704248, 77.102370),
        LatLng(28.703900, 77.101318),
      ]
    ];
    LatLngBounds latLngBounds = boundsFromLatLngList(latlng.first);
    mapController.value!
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds));
    mapController.value!
        .addFill(FillOptions(geometry: latlng, fillColor: "#3bb2d0"));
  }

  boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null || x1 == null || y0 == null || y1 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
        northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }
}
