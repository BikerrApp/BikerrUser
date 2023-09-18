import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InfoRowItemComp extends StatelessWidget {
  final BaseController bmc;
  const InfoRowItemComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const InfoContainerComp(
              infoName: "Basic Information", isFilled: true),
          Obx(() {
            return InfoContainerComp(
                infoName: "Document Information",
                isFilled: bmc.ac.isDocumentInfo.value);
          }),
        ],
      ),
    );
  }
}

class InfoContainerComp extends StatelessWidget {
  final String infoName;
  final bool isFilled;
  const InfoContainerComp({
    required this.infoName,
    required this.isFilled,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MediumTextComp(
          data: infoName,
          size: 12,
          color: isFilled ? whiteColor : greyColor,
        ),
        Container(
          decoration: BoxDecoration(
            color: isFilled ? redColor : greyColor,
            borderRadius: BorderRadius.circular(50.r),
          ),
          height: 10.h,
          width: 160.w,
        )
      ],
    );
  }
}
