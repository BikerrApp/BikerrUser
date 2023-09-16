import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/widgets/add_device_comp.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/widgets/device_drop_down_list.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/widgets/map_my_india_comp.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/widgets/more_controls_comp.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/widgets/search_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MapScreenClass extends StatelessWidget {
  const MapScreenClass({super.key});

  @override
  Widget build(BuildContext context) {
    final bmc = Get.find<BaseController>();
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        MapMyIndiaComp(bmc: bmc),
        Padding(
          padding: EdgeInsets.only(right: 15.w, left: 15.w, top: 50.w),
          child: Obx(() {
            return Row(
              mainAxisAlignment: bmc.mapC.isSearch.value
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.spaceBetween,
              children: [
                AddDeviceComp(bmc: bmc),
                SearchOnMapComp(bmc: bmc),
              ],
            );
          }),
        ),
        DeviceDropDownListComp(bmc: bmc),
        MoreControlsComp(bmc: bmc),
      ],
    );
  }
}
