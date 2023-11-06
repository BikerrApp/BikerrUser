import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/profile/widgets/user_details_form.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/red_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/app_bar.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/user_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditUserDetails extends StatelessWidget {
  final BaseController bmc;
  const EditUserDetails({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Edit Your Details"),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() {
                return UserImageComp(
                  radius: 70,
                  imagePath: bmc.hc.userDetailsData.first["user_image"],
                  isEdit: true,
                  onEditTap: () async {
                    await bmc.pc.pickUserImage();
                  },
                );
              }),
              20.height,
              UserDetailsFormComp(bmc: bmc),
              50.height,
              RedButtonComp(
                btnName: "Save",
                onTap: () async {
                 /* int id = await SharedPreferencesServices.getIntData(
                          key: "user_id_int") ??
                      0;
                  bmc.pc.updateUserData(
                    id: id,
                    userId: bmc.pc.userIdCntrl.value.value.text,
                    userName: bmc.pc.userNameCntrl.value.value.text,
                    email: bmc.pc.emailCntrl.value.value.text,
                    mobileNumber: bmc.pc.mobNumberCntrl.value.value.text,
                    image: bmc.pc.imagePath.value,
                  );

                  getToast("Profile updated successfully");*/
                },
                isLoading: bmc.pc.isProfileUpdate,
              )
            ],
          ),
        ),
      ),
    );
  }
}
