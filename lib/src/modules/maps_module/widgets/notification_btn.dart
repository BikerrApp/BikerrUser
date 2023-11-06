import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/screens/notification_screen.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/transparent_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationBtnComp extends StatelessWidget {
  final BaseController bmc;
  const NotificationBtnComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return TransparentContainerComp(
      child: Icon(
        Icons.notifications_active_outlined,
        color: whiteColor,
      ),
      onTap: () {
        Get.to(() => NotificationsScreen(bmc: bmc));
      },
    );
  }
}
