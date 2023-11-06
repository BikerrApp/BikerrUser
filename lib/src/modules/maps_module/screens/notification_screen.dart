import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/widgets/notification_type_tile.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsScreen extends StatelessWidget {
  final BaseController bmc;
  const NotificationsScreen({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Notifications"),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: ListView.separated(
          itemBuilder: (context, index) =>
              NotificationTypeTileComp(bmc: bmc, index: index),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: bmc.mapC.nc.notificationsType.length,
        ),
      ),
    );
  }
}
