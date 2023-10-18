import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/screens/add_device_screen.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DeviceDropDownListComp extends StatelessWidget {
  final BaseController bmc;

  const DeviceDropDownListComp({
    required this.bmc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return bmc.mapC.dc.isListVisible.value
          ? Padding(
              padding: EdgeInsets.all(15.r),
              child: Column(
                children: [
                  80.height,
                  Container(
                    decoration: BoxDecoration(
                      color: blackColor,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(15.r),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            bmc.mapC.dc.isMyLocation.value = true;
                            bmc.mapC.dc.selectedDeviceId.value = -1;
                            bmc.mapC.dc.deviceValue.value = "Your Location";
                            await bmc.mapC.moveToMyLocation();
                          },
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 5.h),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: dGreyColor,
                                  border: Border.all(
                                      color: bmc.mapC.dc.isMyLocation.value
                                          ? redColor
                                          : dGreyColor),
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                width: double.infinity,
                                height: 65.h,
                                child: const Center(
                                  child: MediumTextComp(
                                    size: 12,
                                    data: "This Device",
                                  ),
                                ),
                              )),
                        ),
                        ...List.generate(
                          bmc.mapC.dc.devicesList.value != null
                              ? bmc.mapC.dc.devicesList.value!.length
                              : 0,
                          (index) => GestureDetector(
                            onTap: () {
                              bmc.mapC.dc.selectedDeviceId.value =
                                  bmc.mapC.dc.devicesList.value![index].id!;
                              bmc.mapC.dc.deviceValue.value =
                                  bmc.mapC.dc.devicesList.value![index].name!;
                              bmc.mapC.moveToMarker(
                                  deviceId: bmc.mapC.dc.selectedDeviceId.value);
                              bmc.mapC.dc.isMyLocation.value = false;
                              bmc.mapC.dc.deviceSpeed.value = bmc
                                  .sockC.srh.socketPositionsData.value!
                                  .where((e) =>
                                      e.deviceId ==
                                      bmc.mapC.dc.devicesList.value![index]
                                          .id!).first.speed!.toInt();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 5.h),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: dGreyColor,
                                  border: Border.all(
                                      color:
                                          bmc.mapC.dc.selectedDeviceId.value ==
                                                  bmc.mapC.dc.devicesList
                                                      .value![index].id!
                                              ? redColor
                                              : dGreyColor),
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                padding: EdgeInsets.all(15.r),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MediumTextComp(
                                            size: 12,
                                            data:
                                                "${bmc.mapC.dc.devicesList.value![index].name}"),
                                        8.height,
                                        MediumTextComp(
                                            size: 12,
                                            data:
                                                "${bmc.mapC.dc.devicesList.value![index].uniqueId}"),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MediumTextComp(
                                            size: 12,
                                            data:
                                                "Validity : ${bmc.mapC.dc.devicesList.value![index].status}"),
                                        8.height,
                                        MediumTextComp(
                                            size: 12,
                                            data:
                                                "Mob. ${bmc.mapC.dc.devicesList.value![index].phone}"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        bmc.mapC.dc.devicesList.value != null
                            ? 30.height
                            : const SizedBox(),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => AddDeviceScreen(bmc: bmc));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: dGreyColor,
                              border: Border.all(color: lGreyColor),
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            height: 30.h,
                            width: 120.w,
                            child: Center(
                              child: MediumTextComp(
                                data: "Add Device",
                                color: redColor,
                                size: 14,
                              ),
                            ),
                          ),
                        ),
                        bmc.mapC.dc.devicesList.value != null
                            ? 10.height
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox();
    });
  }
}
