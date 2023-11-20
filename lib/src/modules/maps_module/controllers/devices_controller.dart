// ignore_for_file: depend_on_referenced_packages, curly_braces_in_flow_control_structures, unused_local_variable

import 'dart:convert';
import 'package:bikerr_partner_app/src/models/device_model.dart';
import 'package:bikerr_partner_app/src/models/position_model.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/screens/playback_history.dart';
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
    await getAllPositions();
    super.onInit();
  }

  final selectedPeriod = 0.obs;
  final isHistoryLoading = false.obs;
  final selectedFromDate = DateTime.now().obs;
  final selectedToDate = DateTime.now().obs;
  final selectedFromTime = TimeOfDay.now().obs;
  final selectedToTime = TimeOfDay.now().obs;

  final devicesList = Rxn<List<Device>>();
  final positionsList = Rxn<List<PositionModel>>();
  final deviceLoading = false.obs;
  final positionLoading = false.obs;
  final isMyLocation = true.obs;
  final deviceSpeed = 0.obs;

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
  final isEngineCommandChange = false.obs;

  final isAddingDevice = false.obs;

  final bikeNameCntrl = TextEditingController().obs;
  final deviceModelCntrl = TextEditingController().obs;
  final uniqueIdCntrl = TextEditingController().obs;
  final mobileNumberCntrl = TextEditingController().obs;
  final deviceContactCntrl = TextEditingController().obs;

  sendEngineCommands() async {
    await sendCommands(
      reqCmd: isEngineOn.value ? "engineStop" : "engineResume",
    );
    isEngineOn.value = !isEngineOn.value;
    Get.back();
  }

  sendCommands({required String reqCmd}) async {
    var value = {
      'deviceId': selectedDeviceId.value,
      'type': reqCmd,
    };
    var command = json.encode(value);
    await Traccar.sendCommands(
      loading: isEngineCommandChange,
      command: command,
    ).then((res) {
      log("$res", name: "adgasdagas");
    });
  }

  getAllDevices() async {
    await Traccar.getDevices(loading: deviceLoading).then(
      (value) {
        log("$value", name: "jhdfakjlshlf");
        devicesList.value = value;
        log("$devicesList", name: "devicesListsadggasdg");
        devicesList.refresh();
      },
    );
  }

  getAllPositions() async {
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
        Get.back();
        getToast("Device added successfully");
      } else {
        log("$value error aagya hua nahi add device");
        Get.back();
        getToast("Something went wrong, Please try again");
      }
    });
  }

  showReport({required String heading}) {
    //, required Device device
    String from;
    String to;

    DateTime current = DateTime.now();

    String month;
    String day;
    if (current.month < 10) {
      month = "0${current.month}";
    } else {
      month = current.month.toString();
    }

    if (current.day < 10) {
      day = "0${current.day}";
    } else {
      day = current.day.toString();
    }

    if (selectedPeriod.value == 0) {
      var date = DateTime.parse("${current.year}-"
          "$month-"
          "$day "
          "00:00:00");
      from = date.toUtc().toIso8601String();
      to = DateTime.now().toUtc().toIso8601String();
    } else if (selectedPeriod.value == 1) {
      String yesterday;

      int dayCon = current.day - 1;
      if (current.day <= 10) {
        yesterday = "0$dayCon";
      } else {
        yesterday = dayCon.toString();
      }

      var start = DateTime.parse("${current.year}-"
          "$month-"
          "$yesterday "
          "00:00:00");

      var end = DateTime.parse("${current.year}-"
          "$month-"
          "$yesterday "
          "24:00:00");

      from = start.toUtc().toIso8601String();
      to = end.toUtc().toIso8601String();
    } else if (selectedPeriod.value == 2) {
      String sevenDay, currentDayString;
      DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);
      int dayCon =
          getDate(current.subtract(Duration(days: current.weekday - 1))).day;
      int currentDay = current.day;
      if (dayCon < 10) {
        sevenDay = "0$dayCon";
      } else {
        sevenDay = dayCon.toString();
      }
      if (currentDay < 10) {
        currentDayString = "0$currentDay";
      } else {
        currentDayString = currentDay.toString();
      }

      var start = DateTime.parse("${current.year}-"
          "$month-"
          "$sevenDay "
          "24:00:00");

      var end = DateTime.parse("${current.year}-"
          "$month-"
          "$currentDayString "
          "24:00:00");

      from = start.toUtc().toIso8601String();
      to = end.toUtc().toIso8601String();
    } else {
      String startMonth, endMoth;
      if (selectedFromDate.value.month < 10) {
        startMonth = "0${selectedFromDate.value.month}";
      } else {
        startMonth = selectedFromDate.value.month.toString();
      }

      if (selectedToDate.value.month < 10) {
        endMoth = "0${selectedToDate.value.month}";
      } else {
        endMoth = selectedToDate.value.month.toString();
      }

      String startHour, endHour;
      if (selectedFromTime.value.hour < 10) {
        startHour = "0${selectedFromTime.value.hour}";
      } else {
        startHour = selectedFromTime.value.hour.toString();
      }

      String startMin, endMin;
      if (selectedFromTime.value.minute < 10) {
        startMin = "0${selectedFromTime.value.minute}";
      } else {
        startMin = selectedFromTime.value.minute.toString();
      }

      if (selectedFromTime.value.minute < 10) {
        endMin = "0${selectedToTime.value.minute}";
      } else {
        endMin = selectedToTime.value.minute.toString();
      }

      if (selectedToTime.value.hour < 10) {
        endHour = "0${selectedToTime.value.hour}";
      } else {
        endHour = selectedToTime.value.hour.toString();
      }

      String startDay, endDay;
      if (selectedFromDate.value.day < 10) {
        if (selectedFromDate.value.day == 10) {
          startDay = selectedFromDate.value.day.toString();
        } else {
          startDay = "0${selectedFromDate.value.day}";
        }
      } else {
        startDay = selectedFromDate.value.day.toString();
      }

      if (selectedToDate.value.day < 10) {
        if (selectedToDate.value.day == 10) {
          endDay = selectedToDate.value.day.toString();
        } else {
          endDay = "0${selectedToDate.value.day}";
        }
      } else {
        endDay = selectedToDate.value.day.toString();
      }

      var start = DateTime.parse("${selectedFromDate.value.year}-"
          "$startMonth-"
          "$startDay "
          "$startHour:"
          "$startMin:"
          "00");

      var end = DateTime.parse("${selectedToDate.value.year}-"
          "$endMoth-"
          "$endDay "
          "$endHour:"
          "$endMin:"
          "00");

      from = start.toUtc().toIso8601String();
      to = end.toUtc().toIso8601String();
    }

    Get.back();
    Get.to(
      () => const HistoryPlaybackScreen(),
      arguments: {
        "deviceId": selectedDeviceId.value,
        "deviceName": deviceValue.value,
        "from": from,
        "to": to,
      },
    );
  }
}
