import 'package:bikerr_partner_app/src/modules/maps_module/controllers/geo_fence_controller.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/screens/geo_fence_add_screen.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/widgets/fence_card.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              onPressed: () {
                Get.to(() => const GeofenceAddScreen());
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  FenceCardComp(gc: gc, index: index),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: gc.fenceList.length,
            ),
          ),
        ),
      );
    });
  }
}
