import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/radio_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/red_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/upload_media_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/text_field.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BikePollutionFormComp extends StatelessWidget {
  final BaseController bmc;
  const BikePollutionFormComp({required this.bmc, super.key});

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
            data: "Do You Have Pollution Certificate ?",
            color: whiteColor,
            size: 18,
          ),
          Obx(() {
            return Row(
              children: [
                CustomRadioBtnComp(
                  value: 1,
                  groupValue: bmc.ac.isPollution.value,
                  onChanged: (e) {
                    bmc.ac.isPollution.value = e;
                  },
                  name: "Yes",
                ),
                50.width,
                CustomRadioBtnComp(
                  value: 0,
                  groupValue: bmc.ac.isPollution.value,
                  onChanged: (e) {
                    bmc.ac.isPollution.value = e;
                  },
                  name: "No",
                ),
              ],
            );
          }),
          CustomTextfieldComp(
            title: "Pollution Number",
            controller: bmc.ac.pollutionNoCntrl.value,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            hintText: "Enter Pollution Number",
          ),
          20.height,
          UploadMediaBtnComp(
            onTap: () async {
              await bmc.ac.uploadPollutionDoc();
            },
            imagePath: bmc.ac.pollutionDocImage,
            string: "Upload Your Pollution Certificate Here",
          ),
          50.height,
          RedButtonComp(
            btnName: "Save",
            onTap: () {
              bmc.ac.validateDocumentInfo();
            },
            isLoading: bmc.ac.isDocumentLoading,
          ),
          30.height,
        ],
      ),
    );
  }
}
