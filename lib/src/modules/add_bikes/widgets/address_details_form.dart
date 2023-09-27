import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/text_field.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressDetailsFormComp extends StatelessWidget {
  final BaseController bmc;
  const AddressDetailsFormComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: dGreyColor,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Column(
        children: [
          MediumTextComp(data: "Pickup Address", color: whiteColor),
          15.height,
          CustomTextfieldComp(
            title: "Pickup Address *",
            controller: bmc.ac.pickUpAddressCntrl.value,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.streetAddress,
            hintText: "Enter Your Address",
            suffixIcon: locationOutlineIcon,
          ),
          15.height,
          CustomTextfieldComp(
            title: "State *",
            controller: bmc.ac.stateCntrl.value,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            hintText: "Enter State",
            suffixIcon: arrowOutlineIcon,
          ),
          15.height,
          CustomTextfieldComp(
            title: "City *",
            controller: bmc.ac.cityCntrl.value,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            hintText: "Enter City",
            suffixIcon: cityOutlineIcon,
          ),
          15.height,
          CustomTextfieldComp(
            title: "Zip *",
            controller: bmc.ac.zipCodeCntrl.value,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            hintText: "Enter Zip Code",
          ),
        ],
      ),
    );
  }
}
