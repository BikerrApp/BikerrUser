import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileListComp extends StatelessWidget {
  final BaseController bmc;
  const ProfileListComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          ...List.generate(
            bmc.pc.profileListData.length,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: GestureDetector(
                onTap: () {
                  switch (index) {
                    /*case 0:
                      Get.to(() => ChangePasswordScreen(bmc: bmc));
                      break;*/
                    case 0:
                      bmc.pc.termsAndPolicies(index);
                      break;
                    case 1:
                      bmc.pc.termsAndPolicies(index);
                      break;
                    case 2:
                      bmc.pc.termsAndPolicies(index);
                      break;
                    case 3:
                      bmc.pc.requestDeletion();
                      break;
                    default:
                  }
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      bmc.pc.profileListData[index]["icon"]!,
                      height: 15.h,
                      width: 15.h,
                      color: whiteColor,
                    ),
                    12.width,
                    MediumTextComp(
                      data: bmc.pc.profileListData[index]["name"]!,
                      color: whiteColor,
                      size: 14,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
