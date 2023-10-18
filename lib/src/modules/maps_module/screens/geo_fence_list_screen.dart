import 'package:bikerr_partner_app/src/modules/maps_module/controllers/geo_fence_controller.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/widgets/fence_card.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeofenceListScreen extends StatelessWidget {
  const GeofenceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = Get.put(GeoFenceController());
    return Obx(() {
      return Scaffold(
        appBar: commonAppBar(
          title: "Geofence List Screen",
          actions: [
            IconButton(
              icon: Icon(Icons.add, color: whiteColor),
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            color: whiteColor,
            child: Column(
              children: [
                ...List.generate(
                  gc.fenceList.length,
                  (index) => FenceCardComp(gc: gc, index: index),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
