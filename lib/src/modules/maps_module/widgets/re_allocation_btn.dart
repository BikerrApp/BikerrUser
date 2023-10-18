import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/trans_circle_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ReallocationBtnComp extends StatelessWidget {
  final BaseController bmc;
  const ReallocationBtnComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.w),
      child: TransCircleBtnComp(
        child: SvgPicture.asset(reallocationIcon),
        onTap: () {
          bmc.mapC.moveToMarker(deviceId: bmc.mapC.dc.selectedDeviceId.value);
        },
      ),
    );
  }
}
