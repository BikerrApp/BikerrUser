import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';

class MapMyIndiaComp extends StatelessWidget {
  final BaseController bmc;
  const MapMyIndiaComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return bmc.mapC.mapLoading.value
            ? SpinKitSpinningLines(color: redColor)
            : MapmyIndiaMap(
                initialCameraPosition: bmc.mapC.myLoc,
                onMapCreated: bmc.mapC.onMapCreated,
                myLocationEnabled: true,
                myLocationTrackingMode: MyLocationTrackingMode.NoneCompass,
                onUserLocationUpdated: (loc) {},
                onStyleLoadedCallback: () {},
              );
      },
    );
  }
}
