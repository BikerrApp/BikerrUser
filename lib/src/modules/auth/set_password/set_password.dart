import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/auth/set_password/controllers/set_pass_controller.dart';
import 'package:bikerr_partner_app/src/modules/auth/set_password/widgets/set_obscure.dart';
import 'package:bikerr_partner_app/src/modules/auth/set_password/widgets/set_pass_form.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/dark_grey_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/bg_scaffold.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/bikerr_logo_comp.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/thin_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SetPasswordScreen extends StatelessWidget {
  const SetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sc = Get.put(SetPasswordController());
    return BackgroundScaffold(
      isBackBtn: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.r),
          child: Column(
            children: [
              50.height,
              const BikerrLogoComp(),
              15.height,
              const MediumTextComp(data: "Set Password"),
              15.height,
              const ThinTextComp(
                  data: "Register with one of the following options"),
              50.height,
              SetPasswordFormComp(sc: sc),
              PasswordObscureComp(sc: sc),
              60.height,
              DarkGreyButton(
                btnName: "Confirm",
                onTap: () {
                  sc.validatePassword();
                },
                isLoading: sc.isSetPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
