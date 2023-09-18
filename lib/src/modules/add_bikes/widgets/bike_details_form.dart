import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BikeDetailsFormComp extends StatelessWidget {
  final BaseController bmc;
  const BikeDetailsFormComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      child: Column(
        children: [
          CustomTextfieldComp(
            title: "Bike Name *",
            controller: bmc.ac.bikeNameCntrl.value,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            hintText: "Enter Bike Name",
          ),
          15.height,
          CustomTextfieldComp(
            title: "Bike Brand *",
            controller: bmc.ac.brandNameCntrl.value,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            hintText: "Enter Bike Brand",
          ),
          15.height,
          CustomTextfieldComp(
            title: "Additional Information *",
            controller: bmc.ac.addDetailsCntrl.value,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            hintText: "Enter Additional Information",
          ),
          15.height,
        ],
      ),
    );
  }
}
