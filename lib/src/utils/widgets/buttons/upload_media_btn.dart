import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class UploadMediaBtnComp extends StatelessWidget {
  final void Function()? onTap;
  final String string;
  const UploadMediaBtnComp(
      {required this.onTap, required this.string, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: redColor),
          borderRadius: BorderRadius.circular(10.r),
          color: greyColor,
        ),
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        width: double.infinity,
        child: Column(
          children: [
            SvgPicture.asset(uploadOutlineIcon),
            5.height,
            MediumTextComp(
              data: string,
              color: whiteColor.withOpacity(0.2),
              isCenter: true,
              size: 13,
            ),
            5.height,
            MediumTextComp(
              data: "Browse",
              color: redColor,
              isDecorate: true,
              size: 13,
            ),
          ],
        ),
      ),
    );
  }
}
