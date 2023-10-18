import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/red_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/dialog_box.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/thin_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EngineOnOffBtnComp extends StatelessWidget {
  final BaseController bmc;
  const EngineOnOffBtnComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          // bmc.mapC.dc.isEngineOn.value = !bmc.mapC.dc.isEngineOn.value;
          dialogBox(
            title: bmc.mapC.dc.isEngineOn.value ? "Engine Off" : "Engine On",
            centerChild: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ThinTextComp(
                  data: bmc.mapC.dc.isEngineOn.value
                      ? "Are you sure you want to cutoff the engine"
                      : "Are you sure you want to turn on the engine",
                  isCenter: true,
                ),
                15.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RedButtonComp(
                      btnName: "Yes",
                      onTap: () async {
                        await bmc.mapC.dc.sendEngineCommands();
                      },
                      width: 100,
                      isLoading: bmc.mapC.dc.isEngineCommandChange,
                    ),
                    15.width,
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const MediumTextComp(
                        data: "Cancel",
                        size: 15,
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
        child: Image.asset(
          engineIcon,
          color: bmc.mapC.dc.isEngineOn.value ? greenColor : redColor,
          height: 30.h,
        ),
      );
    });
  }
}
