import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/edit_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/user_image.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDetailsComp extends StatelessWidget {
  final BaseController bmc;
  final bool isProfile;
  const UserDetailsComp({required this.bmc, this.isProfile = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isProfile
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: greyColor,
            )
          : null,
      padding: isProfile ? EdgeInsets.all(10.r) : null,
      child: Row(
        children: [
          UserImageComp(
            radius: 40.r,
            backgroundImage: const AssetImage(bikerrLogo),
          ),
          25.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MediumTextComp(
                data: "Usercode",
                color: redColor,
                size: 15,
              ),
              const MediumTextComp(
                data: "UserName",
                size: 22,
              ),
            ],
          ),
          const Spacer(),
          isProfile
              ? Column(
                  children: [EditButtonComp(onTap: () {}), 50.height],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
