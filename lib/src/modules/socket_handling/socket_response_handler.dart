import 'dart:developer';

import 'package:bikerr_partner_app/src/models/device_model.dart';
import 'package:bikerr_partner_app/src/models/event_model.dart';
import 'package:bikerr_partner_app/src/models/position_model.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:get/get.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';

class SocketResponseHandlerController extends GetxController {
  late final bmc = Get.find<BaseController>();
  final devicesData = Rxn<List<Device>>();
  final socketPositionsData = Rxn<List<PositionModel>>();
  final eventsData = Rxn<List<Event>>();

  addPositionsFromSocket({required dynamic positionData}) async {
    List socketPosition = positionData;
    var posData = socketPosition.map((e) => PositionModel(
          id: e["id"],
          accuracy: e["accuracy"],
          address: e["address"],
          altitude: e["altitude"],
          attributes: e["attributes"],
          blocked: e["attributes"]["blocked"],
          course: e["course"],
          deviceId: e["deviceId"],
          deviceTime: e["deviceTime"],
          fixTime: e["fixTime"],
          latitude: e["latitude"],
          longitude: e["longitude"],
          outdated: e["outdated"],
          protocol: e["protocol"],
          serverTime: e["serverTime"],
          speed: e["speed"],
          type: e["protocol"],
          valid: e["valid"],
        ));
    log("$posData", name: "sgfasgfsag");
    socketPositionsData.value = posData.toList();
    socketPositionsData.value = socketPositionsData.value!.reversed.toList();
    socketPositionsData.refresh();
    log("$socketPositionsData", name: "sgfasgfsag");
    await updateLocationSelectedDevice();
  }

  updateLocationSelectedDevice() async {
    try {
      var deviceIdData = socketPositionsData.value!
          .where((e) => e.deviceId == bmc.mapC.dc.selectedDeviceId.value);
      await bmc.mapC.mapController.value!.updateSymbol(
        bmc.mapC.devLocSymbol.value!,
        SymbolOptions(
          geometry: LatLng(
            deviceIdData.first.latitude!,
            deviceIdData.first.longitude!,
          ),
        ),
      );
    } catch (e) {
      log("$e");
    }
  }
}
