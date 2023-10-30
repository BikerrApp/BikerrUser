// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';

import 'package:bikerr_partner_app/src/extensions/bitmap_convertor.dart';
import 'package:bikerr_partner_app/src/models/position_model.dart';
import 'package:bikerr_partner_app/src/models/stop_model.dart';
import 'package:bikerr_partner_app/src/services/traccar_services.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/dialog_box.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/no_data_pop_ups.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';

class PlaybackController extends GetxController {
  late final mapController = Rxn<MapmyIndiaMapController>();

  final isPlaying = false.obs;
  final isPositions = false.obs;
  final isStops = false.obs;
  final isPlayingIcon = Icons.pause_circle_outline.obs;

  final postsController = Rxn<StreamController<PositionModel>>();

  late Timer timerPlayBack;

  final routeList = <PositionModel>[].obs;
  final isLoading = false.obs;

  final routeStopSymbol = Rxn<Symbol>();
  final routeArrowSymbol = Rxn<Symbol>();

  final sliderValue = 0.obs;
  final sliderValueMax = 0.obs;
  final playbackTime = 200.obs;
  final polylineCoordinates = <LatLng>[].obs;
  final polylines = <dynamic, dynamic>{}.obs;
  final choices = <Choice>[].obs;
  final selectedChoice = Rxn<Choice>(); // The app's "state".
  final stopList = <Stop>[].obs;

  final args = Get.arguments;

  @override
  void onInit() {
    postsController.value = StreamController();
    getReport();
    super.onInit();
  }

  select(Choice choice) {
    selectedChoice.value = choice;

    if (selectedChoice.value!.title == "Slow") {
      playbackTime.value = 400;
      timerPlayBack.cancel();
      playRoute();
    } else if (selectedChoice.value!.title == "Medium") {
      playbackTime.value = 200;
      timerPlayBack.cancel();
      playRoute();
    } else if (selectedChoice.value!.title == "Fast") {
      playbackTime.value = 100;
      timerPlayBack.cancel();
      playRoute();
    }
  }

  getReport() async {
    await getStops();
    await Traccar.getPositions(
      loading: isPositions,
      deviceId: "${args["deviceId"]}",
      from: args["from"],
      to: args["to"],
    ).then((value) async {
      if (value != null) {
        routeList.addAll(value);
        routeList.refresh();
        sliderValueMax.value = value.length - 1;
        value.forEach((e) {
          postsController.value!.add(e);
          postsController.refresh();
          polylineCoordinates.add(LatLng(e.latitude!, e.longitude!));
          polylineCoordinates.refresh();
        });
        await playRoute();
      } else {
        dialogBox(
          title: "No Data",
          centerChild: const NoDataPopUpComp(),
        );
      }
    });
    await drawPolyline();
  }

  getStops() async {
    await Traccar.getStops(
      deviceId: "${args["deviceId"]}",
      from: args["from"],
      to: args["to"],
      loading: isStops,
    ).then((value) {
      stopList.value = value!;
      stopList.map((e) => addStopMarker(e));
    });
  }

  addStopMarker(Stop e) async {
    await addImageFromAsset("stopRoute", routeStopIcon, mapController.value!);
    routeStopSymbol.value = await mapController.value!.addSymbol(
      SymbolOptions(
        geometry: LatLng(e.latitude!, e.longitude!),
        iconImage: "stopRoute",
        iconSize: 0.5,
      ),
    );
  }

  drawPolyline() async {
    LatLngBounds latLngBounds = boundsFromLatLngList(polylineCoordinates);
    mapController.value!
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds));
    mapController.value!.addLine(LineOptions(
        geometry: polylineCoordinates, lineColor: "#3bb2d0", lineWidth: 6));
    update();
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

  void moveCamera(PositionModel pos) async {
    CameraPosition cPosition = CameraPosition(
      target: LatLng(pos.latitude!, pos.longitude!),
      zoom: 14.0,
    );

    if (isLoading.value) {}
    isLoading.value = false;

    mapController.value!
        .animateCamera(CameraUpdate.newCameraPosition(cPosition));
  }

  playRoute() async {
    await addImageFromAsset("arrowRoute", arrowIcon, mapController.value!);
    interval(Duration(milliseconds: playbackTime.value), (timer) async {
      if (routeList.length != sliderValue.value) {
        sliderValue.value++;
      }
      timerPlayBack = timer;

      if (routeList.length - 1 == sliderValue.value.toInt()) {
        timerPlayBack.cancel();
      } else if (routeList.length != sliderValue.value.toInt()) {
        moveCamera(routeList[sliderValue.value.toInt()]);

        routeStopSymbol.value = await mapController.value!.addSymbol(
          SymbolOptions(
            geometry: LatLng(
              routeList[sliderValue.value.toInt()].latitude!,
              routeList[sliderValue.value.toInt()].longitude!,
            ),
            iconImage: "arrowRoute",
            iconSize: 0.5,
            iconRotate: routeList[sliderValue.value.toInt()].course!,
          ),
        );
      } else {
        timerPlayBack.cancel();
      }
    });
  }

  Timer interval(Duration duration, func) {
    Timer function() {
      Timer timer = Timer(duration, function);

      func(timer);

      return timer;
    }

    return Timer(duration, function);
  }

  playPausePressed() {
    isPlaying.value = !isPlaying.value;
    if (isPlaying.value) {
      timerPlayBack.cancel();
    } else {
      playRoute();
    }
    isPlayingIcon.value = !isPlaying.value
        ? Icons.pause_circle_outline
        : Icons.play_circle_outline;
  }
}

class Choice {
  const Choice({required this.title, required this.icon});

  final String title;
  final IconData icon;
}
