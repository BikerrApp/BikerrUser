import 'dart:developer';

import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/services/traccar_services.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/red_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/toast.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/thin_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteDeviceDialogComp extends StatelessWidget {
  final BaseController bmc;
  final String deviceId;

  const DeleteDeviceDialogComp({
    required this.bmc,
    required this.deviceId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ThinTextComp(
          data: "Are you sure you want to delete this device?",
          isCenter: true,
        ),
        15.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RedButtonComp(
              btnName: "Yes",
              onTap: () async {
                final res = await Traccar.deleteDevice(
                  loading: bmc.mapC.dc.isDeleteDevice,
                  id: deviceId,
                );
                if (res.statusCode == 204) {
                  Get.back();
                  getToast("Device deleted successfully");
                  await bmc.mapC.dc.getAllDevices();
                } else {
                  Get.back();
                  getToast("Something went wrong, Please try again");
                }
                log("$res", name: "klsdjflsdhjf");
              },
              width: 100,
              isLoading: bmc.mapC.dc.isDeleteDevice,
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
    );
  }
}
