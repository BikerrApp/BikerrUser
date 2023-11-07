import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationTypeTileComp extends StatelessWidget {
  final BaseController bmc;
  final int index;
  const NotificationTypeTileComp({
    required this.bmc,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: greyColor,
      title: MediumTextComp(
        data: bmc.mapC.nc.notificationsType[index].type!,
        size: 16.sp,
      ),
      trailing: Obx(() {
        return Switch(
          value: bmc.mapC.nc.notificationsType[index].enabled ?? false,
          onChanged: (value) {
            if (value) {
              bmc.mapC.nc.enableNotification(
                  bmc.mapC.nc.notificationsType[index].type!, index);
            } else {
              bmc.mapC.nc.removeNotification(
                  bmc.mapC.nc.notificationsType[index].id!, index);
            }
          },
          activeColor: redColor,
          thumbColor: MaterialStateColor.resolveWith((states) => redColor),
        );
      }),
    );
  }
}
