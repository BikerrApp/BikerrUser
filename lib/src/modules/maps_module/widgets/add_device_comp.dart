import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/transparent_container.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddDeviceComp extends StatelessWidget {
  final BaseController bmc;
  const AddDeviceComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return bmc.mapC.isSearch.value
          ? const SizedBox()
          : TransparentContainerComp(
              child: Row(
                children: [
                  MediumTextComp(
                    data: bmc.mapC.dc.devicesList.value != null
                        ? bmc.mapC.dc.deviceValue.value
                        : "Add Device",
                    size: 14,
                  ),
                  30.width,
                  Obx(() {
                    return GestureDetector(
                      onTap: () {
                        bmc.mapC.dc.isListVisible.value =
                            !bmc.mapC.dc.isListVisible.value;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: blackColor,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Icon(
                          bmc.mapC.dc.isListVisible.value
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          color: redColor,
                        ),
                      ),
                    );
                  }),
                ],
              ),
              onTap: () {},
            );
    });
  }
}
