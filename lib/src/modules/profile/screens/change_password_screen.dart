import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/red_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/app_bar.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatelessWidget {
  final BaseController bmc;
  const ChangePasswordScreen({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Change Password"),
      body: Padding(
        padding: EdgeInsets.all(15.r),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextfieldComp(
                title: "Current Password",
                controller: bmc.pc.currentPassCntrl.value,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
                hintText: "Enter your current password",
              ),
              25.height,
              CustomTextfieldComp(
                title: "New Password",
                controller: bmc.pc.newPassCntrl.value,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
                hintText: "Enter new password",
              ),
              25.height,
              CustomTextfieldComp(
                title: "Confirm New Password",
                controller: bmc.pc.conPassCntrl.value,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
                hintText: "Re-enter new password",
              ),
              25.height,
              RedButtonComp(
                btnName: "Confirm",
                onTap: () async {
                  await bmc.pc.changePassword();
                },
                isLoading: bmc.pc.isChangePassword,
              )
            ],
          ),
        ),
      ),
    );
  }
}
