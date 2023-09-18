import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/user_image.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingUserDetailsComp extends StatelessWidget {
  final BaseController bmc;
  const BookingUserDetailsComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: greyColor,
      height: 100.h,
      padding: EdgeInsets.all(10.r),
      child: Row(
        children: [
          UserImageComp(
            radius: 35.r,
            imagePath: bmc.hc.userDetailsData.first["user_image"],
          ),
          20.width,
          MediumTextComp(
            data: "Maverick is User",
            color: whiteColor,
          ),
        ],
      ),
    );
  }
}
