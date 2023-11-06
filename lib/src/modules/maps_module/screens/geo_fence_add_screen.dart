import 'package:bikerr_partner_app/src/modules/maps_module/controllers/add_geofence_controller.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/widgets/add_geofence_comp.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';

class GeofenceAddScreen extends StatelessWidget {
  const GeofenceAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gac = Get.put(AddGeofenceController());
    return Scaffold(
      appBar: commonAppBar(title: "Add Geofence"),
      body: Stack(
        children: [
          MapmyIndiaMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(0, 0),
              zoom: 14,
            ),
            onMapCreated: (controller) {
              gac.updateMarker(controller);
            },
            myLocationEnabled: true,
            onStyleLoadedCallback: () {},
            onMapClick: (point, coordinates) {
              gac.geofenceLoc.value = coordinates;
              gac.addFenceVisible.value = true;
              gac.addGeofence();
            },
          ),
          AddGeofenceSetupComp(gac: gac)
        ],
      ),
    );
  }
}
