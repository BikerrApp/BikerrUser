import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/screens/more_controls.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/widgets/re_allocation_btn.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/widgets/speed_meter_comp.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/transparent_container.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MoreControlsComp extends StatelessWidget {
  final BaseController bmc;
  const MoreControlsComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return bmc.mapC.dc.selectedDeviceId.value != -1
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SpeedMeterComp(bmc: bmc),
                  5.height,
                  ReallocationBtnComp(bmc: bmc),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
                    child: TransparentContainerComp(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const MediumTextComp(
                            data: "More Controls",
                            size: 14,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: blackColor,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_up_rounded,
                              color: redColor,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Get.bottomSheet(
                          MoreControlsScreen(bmc: bmc),
                          backgroundColor: dGreyColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.r),
                            ),
                          ),
                          isScrollControlled: true,
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox();
    });
  }
}
