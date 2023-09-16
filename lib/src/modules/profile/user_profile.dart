import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/home/widgets/user_details_comp.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/red_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bmc = Get.find<BaseController>();
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Column(
        children: [
          UserDetailsComp(bmc: bmc, isProfile: true),
          const Spacer(),
          MediumTextComp(
            data: "Version - 0.0.1",
            color: lGreyColor,
            size: 12,
          ),
          10.height,
          RedButtonComp(
            btnName: "Log Out",
            onTap: () {},
            isLoading: bmc.pc.isLoggingOut,
          ),
        ],
      ),
    );
  }
}
