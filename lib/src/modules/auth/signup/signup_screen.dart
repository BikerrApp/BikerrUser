import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/auth/login/widgets/sign_up_btn.dart';
import 'package:bikerr_partner_app/src/modules/auth/signup/controllers/signup_controller.dart';
import 'package:bikerr_partner_app/src/modules/auth/signup/widgets/signup_form.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/dark_grey_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/terms_and_conditions_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/bg_scaffold.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/bikerr_logo_comp.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/thin_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sc = Get.put(SignUpController());
    return BackgroundScaffold(
      isBackBtn: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.r),
          child: Column(
            children: [
              30.height,
              const BikerrLogoComp(),
              15.height,
              const MediumTextComp(data: "SIGN UP"),
              15.height,
              const ThinTextComp(
                  data: "Register with one of the following options"),
              40.height,
              SignUpFormComp(sc: sc),
              50.height,
              DarkGreyButton(
                btnName: "SIGN UP",
                onTap: () {
                  sc.signupValidation();
                },
                isLoading: sc.isSignup,
              ),
              30.height,
              const SignUpBtn(isLogin: false),
              30.height,
              const TermsAndConditionsBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
