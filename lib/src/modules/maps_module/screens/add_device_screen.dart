import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/widgets/add_device_form.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddDeviceScreen extends StatelessWidget {
  final BaseController bmc;
  const AddDeviceScreen({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: commonAppBar(title: "Add Device"),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: AddDeviceFormComp(bmc: bmc),
      ),
    );
  }
}
