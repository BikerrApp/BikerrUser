import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/profile/screens/edit_user_details.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/edit_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/user_image.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserDetailsComp extends StatelessWidget {
  final BaseController bmc;
  final bool isProfile;
  const UserDetailsComp({required this.bmc, this.isProfile = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: isProfile ? EdgeInsets.all(10.r) : null,
        child: Row(
          crossAxisAlignment:
              isProfile ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            bmc.hc.userDetailsData.isNotEmpty
                ? UserImageComp(
                    radius: 40.r,
                    imagePath: bmc.hc.userDetailsData.first["user_image"],
                  )
                : CircularProgressIndicator(
                    color: redColor,
                  ),
            25.width,
            bmc.hc.userDetailsData.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: isProfile
                        ? [
                            MediumTextComp(
                              data:
                                  "${bmc.hc.userDetailsData.first["user_name"]}",
                              color: redColor,
                              size: 16,
                            ),
                            8.height,
                            MediumTextComp(
                              data:
                                  "${bmc.hc.userDetailsData.first["user_number"]}",
                              color: whiteColor,
                              size: 11,
                            ),
                            8.height,
                            MediumTextComp(
                              data:
                                  "${bmc.hc.userDetailsData.first["user_email"]}",
                              color: whiteColor,
                              size: 11,
                            ),
                          ]
                        : [
                            MediumTextComp(
                              data:
                                  "${bmc.hc.userDetailsData.first["user_id"]}",
                              color: redColor,
                              size: 15,
                            ),
                            MediumTextComp(
                              data:
                                  "${bmc.hc.userDetailsData.first["user_name"]}",
                              size: 22,
                            ),
                          ],
                  )
                : CircularProgressIndicator(
                    color: redColor,
                  ),
            const Spacer(),
            isProfile
                ? Column(
                    children: [
                      EditButtonComp(
                        onTap: () {
                          Get.to(
                            () => EditUserDetails(bmc: bmc),
                            transition: Transition.cupertino,
                          );
                          bmc.pc.insertValues();
                        },
                        isInvert: true,
                      ),
                      // 50.height
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      );
    });
  }
}
