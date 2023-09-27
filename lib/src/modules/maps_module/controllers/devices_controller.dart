// ignore_for_file: depend_on_referenced_packages, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:bikerr_partner_app/src/models/device_model.dart';
import 'package:bikerr_partner_app/src/models/position_model.dart';
import 'package:bikerr_partner_app/src/services/traccar_services.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';

class DevicesController extends GetxController {
  @override
  void onInit() async {
    await getAllDevices();
    super.onInit();
  }

  final devicesList = Rxn<List<Device>>();
  final positionsList = Rxn<List<PositionModel>>();
  final deviceLoading = false.obs;
  final positionLoading = false.obs;
  final isMyLocation = true.obs;

  final moreControlsList = [
    {
      "icon": bikeIcon,
      "name": "Total KM Running",
    },
    {
      "icon": speedIcon,
      "name": "Avg. Speed",
    },
    {
      "icon": speedIcon,
      "name": "Top Speed",
    },
    {
      "icon": durationIcon,
      "name": "Time Driven",
    },
    {
      "icon": durationIcon,
      "name": "30 Days History",
    },
    {
      "icon": geoFenceIcon,
      "name": "Geo Fence",
    },
  ];

  final deviceValue = "Your Location".obs;
  final selectedDeviceId = Rx<int>(-1);
  final isListVisible = false.obs;
  final isEngineOn = false.obs;

  final isAddingDevice = false.obs;

  final bikeNameCntrl = TextEditingController().obs;
  final deviceModelCntrl = TextEditingController().obs;
  final uniqueIdCntrl = TextEditingController().obs;
  final mobileNumberCntrl = TextEditingController().obs;
  final deviceContactCntrl = TextEditingController().obs;

  getAllDevices() async {
    await Traccar.getDevices(loading: deviceLoading).then(
      (value) {
        log("$value", name: "jhdfakjlshlf");
        devicesList.value = value;
        log("$devicesList", name: "devicesListsadggasdg");
        devicesList.refresh();
      },
    );
    await Traccar.getLatestPositions(loading: positionLoading).then(
      (value) {
        log("$value", name: "jhdfakjlshlf");
        positionsList.value = value;
        log("$positionsList", name: "positionsListsadggasdg");
        positionsList.refresh();
      },
    );
  }

  validateAddingDevice() {
    if (bikeNameCntrl.value.value.text.trim().trimLeft().trimRight().isEmpty)
      return getToast("Bike Name Cannot Be empty");
    if (uniqueIdCntrl.value.value.text.trim().trimLeft().trimRight().isEmpty)
      return getToast("Unique Id Cannot Be empty");
    if (mobileNumberCntrl.value.value.text
        .trim()
        .trimLeft()
        .trimRight()
        .isEmpty) return getToast("Mobile Number Cannot Be empty");
    if (deviceModelCntrl.value.value.text.trim().trimLeft().trimRight().isEmpty)
      return getToast("Device Model Cannot Be empty");
    if (deviceContactCntrl.value.value.text
        .trim()
        .trimLeft()
        .trimRight()
        .isEmpty) return getToast("Device Contact Cannot Be empty");
    return addNewDevice();
  }

  addNewDevice() async {
    Device device = Device();
    PositionModel positionObj = PositionModel();
    device.name = bikeNameCntrl.value.value.text.trim().trimLeft().trimRight();
    device.uniqueId =
        uniqueIdCntrl.value.value.text.trim().trimLeft().trimRight();
    device.phone =
        mobileNumberCntrl.value.value.text.trim().trimLeft().trimRight();
    device.model =
        deviceModelCntrl.value.value.text.trim().trimLeft().trimRight();
    device.contact =
        deviceContactCntrl.value.value.text.trim().trimLeft().trimRight();
    device.category = "bike";

    String deviceObj = jsonEncode(device.toJson());
    log(deviceObj);
    await Traccar.addDevice(
      loading: isAddingDevice,
      deviceData: deviceObj,
    ).then((value) {
      if (value.statusCode == 200) {
        devicesList.value!.add(Device.fromJson(json.decode(value.body)));
        positionObj.deviceId = devicesList.value!.single.id;
        positionObj.latitude = 0;
        positionObj.longitude = 0;
        positionObj.id = 1;
        positionObj.attributes = {};
        positionObj.speed = 0;
        positionsList.value!.add(positionObj);
        devicesList.refresh();
        positionsList.refresh();
      } else {
        log("$value error aagya hua nahi add device");
      }
    });
  }
}
