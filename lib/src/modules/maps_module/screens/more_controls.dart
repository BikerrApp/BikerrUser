import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/screens/geo_fence_list_screen.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/widgets/engine_on_off.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/widgets/history_selection_dialog.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/dialog_box.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class MoreControlsScreen extends StatelessWidget {
  final BaseController bmc;
  const MoreControlsScreen({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            20.height,
            Padding(
              padding: EdgeInsets.all(20.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MediumTextComp(
                    data: "More Controls",
                  ),
                  EngineOnOffBtnComp(bmc: bmc),
                ],
              ),
            ),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 20.w,
                  mainAxisSpacing: 40.h,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ...List.generate(
                        bmc.mapC.dc.moreControlsList.length,
                        (index) => Stack(
                              alignment: Alignment.topCenter,
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  width: 150.w,
                                  padding: EdgeInsets.all(5.r),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(color: blackColor),
                                    ),
                                    child: Column(
                                      children: [
                                        25.height,
                                        MediumTextComp(
                                          data: bmc.mapC.dc
                                              .moreControlsList[index]["name"]!,
                                          size: 12,
                                          color: blackColor,
                                        ),
                                        5.height,
                                        GestureDetector(
                                          onTap: () {
                                            if (index == 5) {
                                              Get.to(
                                                  () =>
                                                      const GeofenceListScreen(),
                                                  arguments: {
                                                    "deviceId": bmc.mapC.dc
                                                        .selectedDeviceId.value,
                                                    "deviceName": bmc.mapC.dc
                                                        .deviceValue.value,
                                                  });
                                            } else if (index == 4) {
                                              dialogBox(
                                                title: "Select Duration",
                                                centerChild:
                                                    HistorySelectionDialogComp(
                                                        bmc: bmc),
                                              );
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: HexColor("#EEEEEE"),
                                              borderRadius:
                                                  BorderRadius.circular(50.r),
                                            ),
                                            height: 20.h,
                                            width: 90.w,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6.w),
                                            child: Center(
                                              child: MediumTextComp(
                                                data: bmc.mapC
                                                    .getMoreControlsData(
                                                  index,
                                                  deviceId: bmc.mapC.dc
                                                      .selectedDeviceId.value,
                                                ),
                                                size: 11,
                                                color: blackColor,
                                                isOverflow: true,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -25.h,
                                  child: Image.asset(
                                    bmc.mapC.dc.moreControlsList[index]
                                        ["icon"]!,
                                    height: 50.h,
                                  ),
                                )
                              ],
                            )),
                  ],
                ),
              ),
            )
          ],
        ),
        Positioned(
          top: -15.h,
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              decoration: BoxDecoration(
                color: redColor,
                borderRadius: BorderRadius.circular(5.r),
              ),
              height: 30.h,
              width: 40.w,
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: whiteColor,
                size: 35,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
