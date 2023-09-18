import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/radio_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/upload_media_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/text_field.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BikeInsuranceFormComp extends StatelessWidget {
  final BaseController bmc;
  const BikeInsuranceFormComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MediumTextComp(
            data: "Do You Have Insurance ?",
            color: whiteColor,
            size: 18,
          ),
          Obx(() {
            return Row(
              children: [
                CustomRadioBtnComp(
                  value: "yes",
                  groupValue: bmc.ac.isInsurance.value,
                  onChanged: (e) {
                    bmc.ac.isInsurance.value = e;
                  },
                  name: "Yes",
                ),
                50.width,
                CustomRadioBtnComp(
                  value: "no",
                  groupValue: bmc.ac.isInsurance.value,
                  onChanged: (e) {
                    bmc.ac.isInsurance.value = e;
                  },
                  name: "No",
                ),
              ],
            );
          }),
          CustomTextfieldComp(
            title: "Insurance Number",
            controller: bmc.ac.insuranceNoCntrl.value,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            hintText: "Enter Insurance Number",
          ),
          20.height,
          UploadMediaBtnComp(
            onTap: () {},
            string: "Upload Your Insurance Here",
          ),
          15.height,
        ],
      ),
    );
  }
}
