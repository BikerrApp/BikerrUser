import 'dart:convert';
import 'dart:developer';

import 'package:bikerr_partner_app/src/extensions/bitmap_convertor.dart';
import 'package:bikerr_partner_app/src/models/geo_permission_model.dart';
import 'package:bikerr_partner_app/src/models/geofence_model.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/services/traccar_services.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';

class AddGeofenceController extends GetxController {
  final bmc = Get.find<BaseController>();
  final mapController = Rxn<MapmyIndiaMapController>();

  final valRadius = 100.0.obs;
  final valRadiusMax = 10000.0.obs;
  final addFenceVisible = false.obs;
  final deleteFenceVisible = false.obs;
  final isLoading = false.obs;
  final fenceName = TextEditingController().obs;
  final locSymbol = Rxn<Symbol>();
  final geofenceLoc = Rxn<LatLng>();
  final circle = Rxn<Circle>();

  updateMarker(MapmyIndiaMapController controller) async {
    mapController.value = controller;
    var deviceIdData = bmc.sockC.srh.socketPositionsData.value!
        .where((e) => e.deviceId == bmc.mapC.dc.selectedDeviceId.value);

    final devPos =
        LatLng(deviceIdData.first.latitude!, deviceIdData.first.longitude!);
    mapController.value!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: devPos, zoom: 14),
      ),
    );

    await addImageFromAsset("loc", locationOutlineIcon, mapController.value!);
    locSymbol.value = await mapController.value!.addSymbol(
      SymbolOptions(
        geometry: devPos,
        iconImage: "loc",
        iconSize: 2,
      ),
    );
  }

  addGeofence() async {
    try {
      mapController.value!.removeCircle(circle.value!);
    } catch (e) {
      log("$e");
    }

    await mapController.value!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: geofenceLoc.value!, zoom: 14),
      ),
    );

    circle.value = await mapController.value!.addCircle(
      CircleOptions(
        geometry: geofenceLoc.value,
        circleRadius: valRadius.value / 10,
        circleColor: "#3bb2d0",
        circleOpacity: 0.4,
      ),
    );
  }

  submitFence() {
    String pos =
        "CIRCLE (${geofenceLoc.value!.latitude} ${geofenceLoc.value!.longitude}, ${valRadius.value})";

    GeofenceModel fence = GeofenceModel();
    fence.id = -1;
    fence.area = pos;
    fence.attributes = {};
    fence.calendarId = 0;
    fence.description = "";
    fence.name = fenceName.value.value.text.trim();

    var fenceCon = json.encode(fence);
    GeofenceModel fenceObj;
    Traccar.addGeofence(
      fence: fenceCon.toString(),
      loading: isLoading,
    ).then((value) => {
          fenceObj = GeofenceModel.fromJson(json.decode(value.body)),
          updateFence(fenceObj.id)
        });
  }

  updateFence(id) {
    GeofencePermModel permissionModel = GeofencePermModel();
    permissionModel.deviceId = bmc.mapC.dc.selectedDeviceId.value;
    permissionModel.geofenceId = id;

    var perm = json.encode(permissionModel);
    Traccar.addPermission(
      permission: perm.toString(),
      loading: isLoading,
    ).then((value) {
      if (value.statusCode == 204) {
        getToast("Geofence added successfully");
        Get.back();
      } else {
        getToast("Something went wrong, Please try again");
      }
    });
  }
}
