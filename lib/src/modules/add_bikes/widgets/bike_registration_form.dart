import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/upload_media_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BikeRegistrationFormComp extends StatelessWidget {
  final BaseController bmc;
  const BikeRegistrationFormComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(15.r),
      child: Column(
        children: [
          CustomTextfieldComp(
            title: "Registration Number",
            controller: bmc.ac.registrationNoCntrl.value,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            hintText: "Enter Registration Number",
          ),
          20.height,
          UploadMediaBtnComp(onTap: (){}, string: "Upload Your Front Registration Here"),
          15.height,
          UploadMediaBtnComp(onTap: (){}, string: "Upload Your Back Registration Here"),
        ],
      ),
    );
  }
}
