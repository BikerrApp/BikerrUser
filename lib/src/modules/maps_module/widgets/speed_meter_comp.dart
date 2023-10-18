import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/trans_circle_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SpeedMeterComp extends StatelessWidget {
  final BaseController bmc;
  const SpeedMeterComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.w),
      child: TransCircleBtnComp(
        child: Obx(() {
          return MediumTextComp(
            data: "${bmc.mapC.dc.deviceSpeed.value}\nKm/h",
            size: 12,
            isCenter: true,
          );
        }),
        onTap: () {},
      ),
    );
  }
}
