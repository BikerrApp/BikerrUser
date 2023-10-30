import 'package:bikerr_partner_app/src/modules/maps_module/controllers/playback_controller.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/widgets/playback_controls.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';

class HistoryPlaybackScreen extends StatelessWidget {
  const HistoryPlaybackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pc = Get.put(PlaybackController());
    return Scaffold(
      appBar: commonAppBar(title: "${pc.args["deviceName"]}"),
      body: Stack(
        children: [
          MapmyIndiaMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(0, 0),
              zoom: 14,
            ),
            onMapCreated: (controller) {
              pc.mapController.value = controller;
            },
            myLocationEnabled: false,
            myLocationTrackingMode: MyLocationTrackingMode.None,
            onUserLocationUpdated: (loc) {},
            onStyleLoadedCallback: () {},
            onMapClick: (point, coordinates) {},
          ),
          PlaybackControlsComp(pc: pc)
        ],
      ),
    );
  }
}
