import 'dart:developer';

import 'package:bikerr_partner_app/src/models/device_model.dart';
import 'package:bikerr_partner_app/src/models/event_model.dart';
import 'package:bikerr_partner_app/src/models/position_model.dart';
import 'package:get/get.dart';

class SocketResponseHandlerController extends GetxController {
  final devicesData = Rxn<List<Device>>();
  final positionsData = Rxn<List<PositionModel>>();
  final eventsData = Rxn<List<Event>>();

  addPositionsFromSocket({required dynamic positionData}) {
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
    positionsData.value = posData.toList();
    positionsData.value = positionsData.value!.reversed.toList();
    positionsData.refresh();
    log("$positionsData", name: "sgfasgfsag");
  }
}
