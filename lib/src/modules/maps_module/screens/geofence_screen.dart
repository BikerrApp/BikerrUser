import 'package:bikerr_partner_app/src/modules/maps_module/controllers/geo_fence_controller.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';

class GeofenceScreen extends StatelessWidget {
  final GeoFenceController gc;
  final int index;
  const GeofenceScreen({required this.gc,required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "${gc.args["deviceName"]}"),
      body: Stack(
        children: [
          MapmyIndiaMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(0, 0),
              zoom: 14,
            ),
            onMapCreated: (controller) {
              gc.mapController.value = controller;
            },
            myLocationEnabled: false,
            myLocationTrackingMode: MyLocationTrackingMode.None,
            onUserLocationUpdated: (loc) {},
            onStyleLoadedCallback: () {
              gc.createGeofence(index);
            },
            onMapClick: (point, coordinates) {},
          ),
        ],
      ),
    );
  }
}
